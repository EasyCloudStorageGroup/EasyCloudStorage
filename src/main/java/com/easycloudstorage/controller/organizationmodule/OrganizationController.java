package com.easycloudstorage.controller.organizationmodule;

import com.easycloudstorage.pojo.Organization;
import com.easycloudstorage.service.organizationmodule.OrganizationService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class OrganizationController {
    @Autowired
    private OrganizationService organizationService;

    @RequestMapping("organization")
    public ModelAndView homePage(int orgId) {
        Organization organization = organizationService.getByOrgId(orgId);

        ModelAndView mv = new ModelAndView();
        mv.setViewName("organization/home/orgHomePage");
        mv.addObject(organization);

        return mv;
    }
}
