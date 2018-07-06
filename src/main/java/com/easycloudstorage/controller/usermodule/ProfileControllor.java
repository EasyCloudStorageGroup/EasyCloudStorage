package com.easycloudstorage.controller.usermodule;

import com.easycloudstorage.pojo.User;
import com.easycloudstorage.util.ImageUtil;
import com.easycloudstorage.service.usermodule.ProfileService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;

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
    public String modifyInfo(@RequestParam String name,@RequestParam String sex,@RequestParam String phoneNumber,
                             HttpSession session){
        User newUser=new User();
        if(sex.equals("男")) sex="male";
        else sex="female";
        newUser.setAccountId(((User)session.getAttribute("User")).getAccountId());
        newUser.setUserName(name);
        newUser.setSex(sex);
        newUser.setPhoneNumber(phoneNumber);
        theUser.modInfo(newUser);

        return "redirect:infoShow";
    }

    @RequestMapping(value = "modifyAvatar", method = RequestMethod.POST)
    public String modifyAvatar(MultipartFile avatar, MultipartHttpServletRequest request) throws IOException{
        User user = (User) request.getSession().getAttribute("user");

        File avatarFolder= new File(request.getSession().getServletContext().getRealPath("img/avatar"));
        File avatarImage = new File(avatarFolder,user.getAccountId()+".jpg");

        avatar.transferTo(avatarImage);
        BufferedImage img = ImageUtil.change2jpg(avatarImage);
        ImageIO.write(img, "jpg", avatarImage);

        user.setDefaultAvatar(0);
        theUser.unUseDefaultAvatar(user);

        return "redirect:infoShow";
    }
}
