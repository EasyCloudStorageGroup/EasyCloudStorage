package com.easycloudstorage.controller.usermodule;

import com.easycloudstorage.pojo.Test;

import com.easycloudstorage.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class ProfileControllor {
    @Autowired
    private TestService testService;

    @RequestMapping("infoShow")
    public ModelAndView getInfo() {
        List<Test> theList=testService.list();
        ModelAndView mv = new ModelAndView();
        mv.setViewName("profile/infoShow");
        mv.addObject("Information",theList);

        return mv;
    }

    @RequestMapping("modInfo")
    public ModelAndView getInfo(String name,String sex,String phoneNumber){
        ModelAndView mv=new ModelAndView();
        mv.setViewName("profile/modInfo");
        mv.getViewName();
        return mv;
    }
}
