package com.easycloudstorage.controller.organizationmodule;

import com.easycloudstorage.pojo.Organization;
import com.easycloudstorage.pojo.User;
import com.easycloudstorage.service.organizationmodule.OrganizationService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@Controller
public class OrganizationController {
    @Autowired
    private OrganizationService organizationService;

    @RequestMapping("organization")
    public ModelAndView homePage(int orgId, HttpSession session) {
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
}
