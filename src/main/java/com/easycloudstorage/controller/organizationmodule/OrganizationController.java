package com.easycloudstorage.controller.organizationmodule;

import com.easycloudstorage.pojo.Directory;

import com.easycloudstorage.pojo.Organization;
import com.easycloudstorage.pojo.User;
import com.easycloudstorage.service.filemodule.FileService;
import com.easycloudstorage.service.organizationmodule.OrganizationService;

import com.easycloudstorage.util.CreateDirForOrg;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

import java.util.ArrayList;

import java.util.Date;

import java.util.List;

@Controller
public class OrganizationController {
    @Autowired
    private OrganizationService organizationService;
    @Autowired
    private FileService fileService;

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
                if(nowDir.getDirId() == dirId) {
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

    @RequestMapping("orgHomePage")
    public ModelAndView orgHomePage(Integer dirId, HttpSession session) {
        int orgId = (Integer) session.getAttribute("orgId");
        Organization organization = organizationService.getByOrgId(orgId);

        ModelAndView mv = new ModelAndView();
        mv.setViewName("organization/home/orgHomePage");
        mv.addObject("organization", organization);

        toTheDir(dirId, session);

        return mv;
    }

    @RequestMapping(value = "/toCreatePage", method = RequestMethod.GET)
    public String toCreatePage(){
        return "organization/create/createPage";
    }
    @RequestMapping(value = "/toHomePage", method = RequestMethod.GET)
    public String toHomePage(){
        return "home/homePage";
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public ModelAndView register(@RequestParam("name")String name, @RequestParam("description")String description,HttpSession session){
        ModelAndView mv = new ModelAndView();
        List<Organization> orgList = organizationService.list();
        int repeatFlag = 0;

        for(Organization org:orgList){
            if(name.equals(org.getName())){
                repeatFlag++;
            }
        }
        //避免输入为空
        if("".equals(name) || "".equals(description)){
            mv.setViewName("checkout/register");
            String error = "输入为空";
            mv.addObject("error", error);
        }
        else{
            //用户名重复
            if(repeatFlag != 0){
                mv.setViewName("checkout/register");
                String error = "组织名重复";
                mv.addObject("error", error);
            }
            //均符合规范向数据库中添加用户
            else{
                User user=new User();
                user=(User)session.getAttribute("user");
                Organization org = new Organization();
                org.setName(name);
                org.setOwnerId(user.getAccountId());
                org.setDescription(description);
                organizationService.addOrg(org);
                mv.setViewName("home/homePage");
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
            }
            //mv.setViewName("checkout/register");
        }
        return mv;
    }



}
