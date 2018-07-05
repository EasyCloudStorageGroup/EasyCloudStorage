package com.easycloudstorage.controller.usermodule;

import com.easycloudstorage.pojo.User;

import com.easycloudstorage.service.usermodule.ProfileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ProfileControllor {
    @Autowired
    private ProfileService theUser;

    @RequestMapping("infoShow")
    public ModelAndView showInfo() {
        User selectUser=theUser.getUser();
        ModelAndView mv = new ModelAndView();
        mv.setViewName("profile/infoShow");
        mv.addObject("information",selectUser);

        return mv;
    }

    @RequestMapping("modInfo")
    public ModelAndView getInfo(){
        User selectUser=theUser.getUser();
        ModelAndView mv=new ModelAndView();
        mv.setViewName("profile/modInfo");
        mv.addObject("information",selectUser);

        return mv;
    }

    @RequestMapping("modifyInfo")
    public String modifyInfo(@RequestParam String name,@RequestParam String sex,@RequestParam String phoneNumber){
        User newUser=new User();
        if(sex.equals("男")) sex="male";
        else sex="female";
        newUser.setUserName(name);
        newUser.setSex(sex);
        newUser.setPhoneNumber(phoneNumber);
        theUser.modInfo(newUser);

        return "redirect:infoShow";
    }
}
