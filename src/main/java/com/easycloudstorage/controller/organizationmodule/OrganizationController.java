package com.easycloudstorage.controller.organizationmodule;

import com.easycloudstorage.pojo.Directory;

import com.easycloudstorage.pojo.Group;
import com.easycloudstorage.pojo.Organization;
import com.easycloudstorage.pojo.User;
import com.easycloudstorage.service.filemodule.FileService;
import com.easycloudstorage.service.organizationmodule.OrganizationService;
import com.easycloudstorage.util.CreateDirForOrg;

import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import com.easycloudstorage.service.usermodule.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.Console;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class OrganizationController {
    @Autowired
    private OrganizationService organizationService;
    @Autowired
    private FileService fileService;
    @Autowired
    private UserService userService;

    //点击某一个组织之后，进入这个controller
    @RequestMapping("enterOrganization")
    public String enterOrganization(int orgId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        boolean isMember = organizationService.isMember(user.getAccountId(), orgId);
        if(!isMember)
            return "organization/home/404";
        else {
            session.setAttribute("orgId", orgId);

            return "redirect:orgHomePage";
        }
    }

    public void toTheDir(Integer dirId, HttpSession session) {
        int orgId = (Integer) session.getAttribute("orgId");
        User user = (User) session.getAttribute("user");
        Directory root = fileService.makeVisibleFileSys(user.getAccountId(), orgId);

        if(dirId == null) {
            session.setAttribute("currentDir", root);
            return;
        }
        else {
            List<Directory> unVisitedDirs = new ArrayList<>();
            for(Directory d : root.getChildDirectories()) {
                unVisitedDirs.add(d);
            }

            int index = 0;
            while(unVisitedDirs.size() != 0)
            {
                Directory nowDir = unVisitedDirs.get(index);
                if(nowDir.getDirId().equals(dirId)) {
                    session.setAttribute("currentDir", nowDir);
                    return;
                }
                else {
                    unVisitedDirs.remove(index);
                    for(Directory d : nowDir.getChildDirectories())
                        unVisitedDirs.add(d);
                }
            }
        }
        session.removeAttribute("currentDir");
    }

    /*得到当前目录的父目录，包括当前目录*/
    public List<Directory> getDirNav(HttpSession session) {
        Directory currentDir = (Directory) session.getAttribute("currentDir");
        List<Directory> parentDirs = new ArrayList<>();

        parentDirs.add(currentDir);
        while(currentDir.getParentDir() != null) {
            parentDirs.add(0, currentDir.getParentDir());
            currentDir = currentDir.getParentDir();
        }
        //使根目录名为“全部文件”
        Directory root = new Directory();
        root.setName("全部文件");
        parentDirs.set(0, root);

        return parentDirs;
    }

    @RequestMapping("orgHomePage")
    public ModelAndView orgHomePage(Integer dirId, HttpSession session) {
        int orgId = (Integer) session.getAttribute("orgId");
        Organization organization = organizationService.getByOrgId(orgId);

        ModelAndView mv = new ModelAndView();
        mv.setViewName("organization/home/orgHomePage");
        mv.addObject("organization", organization);

        toTheDir(dirId, session);
        List<Directory> dirNav = getDirNav(session);
        session.setAttribute("dirNav", dirNav);

        return mv;
    }

    @RequestMapping(value = "/toCreatePage", method = RequestMethod.GET)
    public String toCreatePage() {
        return "organization/create/createPage";
    }

    @RequestMapping(value = "/toInvite", method = RequestMethod.GET)
    public String toInvite(){
        return "organization/create/inviteMember";
    }

    @RequestMapping(value = "/toOrgPage", method = RequestMethod.GET)
    public String toOrgPage(){
        return "home/organizationPage";
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public ModelAndView create(@RequestParam("name")String name, @RequestParam("description")String description,HttpSession session){
        ModelAndView mv = new ModelAndView();
        List<Organization> orgList = organizationService.list();

        int repeatFlag = 0;

        for(Organization org:orgList){
            if(name.equals(org.getName())){
                repeatFlag++;
            }
        }
        Organization org=null;
        //避免输入为空
        if("".equals(name) || "".equals(description)){
            mv.setViewName("organization/create/createPage");
            String error = "输入为空";
            mv.addObject("error", error);
        }
        else{
            //用户名重复
            if(repeatFlag != 0){
                mv.setViewName("organization/create/createPage");
                String error = "已被注册的组织名";
                mv.addObject("error", error);
            }
            //均符合规范向数据库中添加用户
            else{
                User user=new User();
                user=(User)session.getAttribute("user");
                org= new Organization();
                org.setName(name);
                org.setOwnerId(user.getAccountId());
                org.setDescription(description);
                organizationService.addOrg(org);
                mv.setViewName("organization/create/inviteMember");
                org=organizationService.getOrgByName(org.getName());
                CreateDirForOrg co=new CreateDirForOrg();
                String userRootDir = co.createDirForOrg(org);
                //向directory中添加数据
                Directory file = new Directory();
                file.setName(org.getName());
                file.setLastMovedTime(new Date());
                file.setRealPath(userRootDir);
                file.setOrgId(org.getOrgId());
                organizationService.addDir(file);
                organizationService.addMember(user.getAccountId(),org.getOrgId());
            }
            //mv.setViewName("checkout/register");
        }
        if(org!=null)
        session.setAttribute("orgId",org.getOrgId());
        return mv;
    }

    @RequestMapping(value = "/invite", method = RequestMethod.POST)
    public ModelAndView invite(@RequestParam("accountId")String accountId,HttpSession session){
        ModelAndView mv = new ModelAndView();
        int orgId=(int)session.getAttribute("orgId");
        boolean flag=organizationService.isMember(accountId,orgId);
        boolean flag2=organizationService.isUser(accountId);
        //避免输入为空
        if("".equals(accountId)){
            mv.setViewName("organization/create/inviteMember");
            String error = "输入为空";
            mv.addObject("error", error);
        }
        else{
            //用户名重复
            if(flag==true){
                mv.setViewName("organization/create/inviteMember");
                String error = "该成员已经在组织内";
                mv.addObject("error", error);
            }
            else if(flag2==false){
                mv.setViewName("organization/create/inviteMember");
                String error = "无该用户";
                mv.addObject("error", error);
            }
            //均符合规范向数据库中添加用户
            else{
                String message="邀请成功";
                mv.addObject("message", message);
                mv.setViewName("organization/create/inviteMember");
                organizationService.addMember(accountId,orgId);
            }
            //mv.setViewName("checkout/register");
        }
        return mv;
    }

    @RequestMapping("organizationPage")
    public ModelAndView organizationPage(String type,HttpSession session){
        User user=(User) session.getAttribute("user");

        session.setAttribute("navigatorType","orgPage");

        if(type==null)
            type="all";

        List<Organization> orgList=organizationService.findMyOrgByType(user,organizationService.list(),type);

        session.setAttribute("orgList",orgList);

        ModelAndView mv = new ModelAndView("home/organizationPage");

        return mv;
    }
    @RequestMapping("modifyOrg")
    public ModelAndView modifyPage(HttpSession session){
        int orgId=(Integer) session.getAttribute("orgId");
        Organization org=organizationService.getByOrgId(orgId);
        ModelAndView mv = new ModelAndView("organization/orgInfo/orgInfo");
        mv.addObject("organization",org);
        List<Group> groups=organizationService.getGroupByOrgId(orgId);
        for (int i=0;i<groups.size();++i){
            Group group=groups.get(i);
            group.setMembers(organizationService.getUsersByGroupId(group.getGroupId()));
        }
        mv.addObject("groupList",groups);
        return mv;
    }

    @RequestMapping(value = "submitForm",method = RequestMethod.POST)
    public ModelAndView modifyState(HttpServletRequest request,HttpSession session){
        //Integer orgId=(Integer)request.getAttribute("orgId");//获取客户端传来的组织id
        int orgId=(Integer) session.getAttribute("orgId");
        Organization org=organizationService.getByOrgId(orgId);
        String name=request.getParameter("newName");
        String description=(String) request.getParameter("description");
        List<Group> groups=organizationService.getGroupByOrgId(orgId);
        for (int i=0;i<groups.size();++i){
            int groupId=groups.get(i).getGroupId();
            String groupName=request.getParameter("name"+groupId);
            String groupDescription=request.getParameter("description"+groupId);
            organizationService.changeGroupName(groupId,groupName);
            organizationService.changeGroupDescription(groupId,groupDescription);
        }
        organizationService.changeName(orgId,name);
        organizationService.changeDescription(orgId,description);
        ModelAndView mv =new ModelAndView("organization/orgInfo/success");
        mv.addObject("org",org);
        return mv;
    }



    //接口方法,主要是增加删除等功能，映射还未添加

    //将成员踢出组织,参数含义为第一个是被踢的人的id，第三个用来获取当前组织的id
    @RequestMapping("removeOrgMember")
    public String removeOrgMember(String memberId,HttpSession session) {
        int orgId=(int)session.getAttribute("orgId");
       User user=(User)session.getAttribute("user");
      Organization org=organizationService.getByOrgId(orgId);
       String userId=user.getAccountId();
       Group group=null;
       User temp=null;
       if(userId!=null&&!userId.equals(organizationService.getByOrgId(orgId).getOwnerId())){//判断该用户是否为组织的拥有者，如果不是拥有者，直接退出此函数
           return "redirect:orgHomePage" ;
       }
       else {
           if(memberId.equals(user.getAccountId()))
               return "redirect:orgHomePage" ;

           for(int i=0;i<org.getGroups().size();i++) {
              group=org.getGroups().get(i);
                 for(int j=0;j<group.getMembers().size();j++){
                     temp=group.getMembers().get(j);
                     if(temp!=null&&temp.getAccountId().equals(memberId))
                        organizationService.removeGpMember(memberId,group.getGroupId());
                 }
              }

           organizationService.removeMember(memberId,orgId);
           return "redirect:orgHomePage" ;
       }
    }

    //删除该组织
    @RequestMapping("deleteOrg")
    public String deleteOrg(HttpSession session){
        User user=(User)session.getAttribute("user");
        String userId=user.getAccountId();
        Group group=null;
        int orgId=(int)session.getAttribute("orgId");
        Organization org=organizationService.getByOrgId(orgId);
        if(!userId.equals(organizationService.getByOrgId(orgId).getOwnerId())){
            return "redirect:orgHomePage";
        }
        else {
            if(org.getGroups()!=null)
            for(int i=0;i<org.getGroups().size();i++) {
                group=org.getGroups().get(i);
                for(User tem:group.getMembers()){
                    organizationService.removeGpMember(tem.getAccountId(),group.getGroupId());
                }
                organizationService.deleteGroup(group.getGroupId());
                }
            if(org.getMembers()!=null)
                 for(int j=0;j<org.getMembers().size();j++){
                user=org.getMembers().get(j);
                organizationService.removeMember(user.getAccountId(),orgId);
                }
            organizationService.deleteOrg(orgId);
            return "redirect:organizationPage";
            }
        }

    //往分组里添加已经在组织内的成员
    @RequestMapping("addGroupMember")
    public String addGroupMember(String[] members,int groupId,HttpSession session){
        String memberId=new String();
        if(members.length==1)
             memberId=members[0];
        User user=(User)session.getAttribute("user");
        String userId=user.getAccountId();
        int orgId=(int)session.getAttribute("orgId");
        Group tem=null;
        User temp=null;
        Organization org=organizationService.getByOrgId(orgId);
        if(!userId.equals(organizationService.getByOrgId(orgId).getOwnerId())){
            return "redirect:orgHomePage";
        }
        else {
            for(int i=0;i<org.getGroups().size();i++){
                tem=org.getGroups().get(i);
                if(tem.getGroupId().equals(groupId))
                    break;
            }
            for(int i=0;i<members.length;i++) {
                memberId=members[i];
                for (int j = 0; j < tem.getMembers().size(); j++) {
                    temp = tem.getMembers().get(j);
                    if (temp.getAccountId().equals(memberId))
                        return "redirect:orgHomePage";
                }
                organizationService.distributeMember(memberId,groupId);
            }
            return  "redirect:orgHomePage";
        }
    }

    //新建分组，需要填写组名，描述,orgId会自动获取，groupId会自动生成
    @RequestMapping(value = "/addGroup", method = RequestMethod.POST)
    public String addGroup(@RequestParam("name")String name, @RequestParam("description")String description,HttpSession session){
          Group group= new Group();
                group.setName(name);
                group.setOrgId((int)session.getAttribute("orgId"));
                group.setDescription(description);
                organizationService.addGroup(group);
        return "redirect:orgHomePage" ;
    }

    //删除分组
    @RequestMapping("deleteGroup")
    public String deleteGroup(int groupId,HttpSession session){
    User user=(User)session.getAttribute("user");
    String userId=user.getAccountId();
    int orgId=(int)session.getAttribute("orgId");
    Organization org=organizationService.getByOrgId(orgId);
    Group group=new Group();
        for (Group temp :org.getGroups()) {
            if(temp.getGroupId().equals(groupId))
                group=temp;
        }
    if(!userId.equals(organizationService.getByOrgId(orgId).getOwnerId())){
        return "redirect:orgHomePage";
    }
    else {
        for(User tem:group.getMembers()){
        organizationService.removeGpMember(tem.getAccountId(),groupId);
        }
        organizationService.deleteGroup(groupId);
        return "redirect:orgHomePage";
    }
}

    //删除分组成员
    @RequestMapping("removeGroupMember")
    public String removeGroupMember(String memberId,int groupId,HttpSession session){
        User user=(User)session.getAttribute("user");
        String userId=user.getAccountId();
        int orgId=(int)session.getAttribute("orgId");
        if(!userId.equals(organizationService.getByOrgId(orgId).getOwnerId())){
            return "redirect:orgHomePage";
        }
        else {
            organizationService.removeGpMember(memberId,groupId);
            return "redirect:orgHomePage";
        }
    }

    //退出组织
    @RequestMapping("dropoutOrg")
    public String dropoutOrg(HttpSession session) {
        int orgId=(int)session.getAttribute("orgId");
        User user=(User)session.getAttribute("user");
        Organization org=organizationService.getByOrgId(orgId);
        String userId=user.getAccountId();
        Group group=null;
        User temp=null;
        for(int i=0;i<org.getGroups().size();i++) {
            group=org.getGroups().get(i);
            for(int j=0;j<group.getMembers().size();j++){
                temp=group.getMembers().get(j);
                if(temp!=null&&temp.getAccountId().equals(userId))
                    organizationService.removeGpMember(userId,group.getGroupId());
            }
        }
            organizationService.removeMember(userId,orgId);
            return "redirect:orgHomePage" ;
    }
}
