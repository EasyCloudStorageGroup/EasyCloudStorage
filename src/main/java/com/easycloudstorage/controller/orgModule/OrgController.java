package com.easycloudstorage.controller.orgModule;

import com.easycloudstorage.pojo.Organization;
import com.easycloudstorage.pojo.User;
import com.easycloudstorage.service.orgModule.OrgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class OrgController {
    @Autowired
    private OrgService orgService;

    @RequestMapping("orgnizationPage")
    public ModelAndView orgList(HttpSession session){
        User user=(User) session.getAttribute("user");
        List<Organization> orgList=orgService.orgList(user);
        session.setAttribute("orgList",orgList);
        ModelAndView mv = new ModelAndView("home/orgnizationPage");
        return mv;
    }


}
