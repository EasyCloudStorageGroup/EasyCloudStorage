package com.easycloudstorage.controller.organizationmodule;

import com.easycloudstorage.pojo.Directory;
import com.easycloudstorage.pojo.File;
import com.easycloudstorage.pojo.Organization;
import com.easycloudstorage.pojo.User;
import com.easycloudstorage.service.organizationmodule.OrganizationService;

import com.easycloudstorage.util.CreateDirForOrg;
import com.easycloudstorage.util.CreateDirForUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Controller
public class OrganizationController {
    @Autowired
    private OrganizationService organizationService;

    @RequestMapping("organization")
    public ModelAndView homePage(Integer orgId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        boolean isMember = organizationService.isMember(user.getAccountId(), orgId);

        ModelAndView mv = new ModelAndView();

        //获取organization
        if(!isMember)
            mv.setViewName("organization/home/404");
        else {
            Organization organization = organizationService.getByOrgId(orgId);
            if(organization == null)
                mv.setViewName("organization/home/404");
            else
                mv.setViewName("organization/home/orgHomePage");
            mv.addObject(organization);
        }
        //获取有权限的文件和文件夹
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
