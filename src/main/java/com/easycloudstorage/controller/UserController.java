package com.easycloudstorage.controller;

import com.easycloudstorage.pojo.User;
import java.util.*;
import com.easycloudstorage.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import static javafx.scene.input.KeyCode.Z;


@Controller
public class UserController  {
    @Autowired

    private  UserService userService;



    @RequestMapping("checkout")
    public ModelAndView checkout(){

        ModelAndView mv = new ModelAndView();
        mv.setViewName("checkout/login");
        return mv;
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(@RequestParam("accountId")String accountId, @RequestParam("password")String password) {
        List<User> userList = userService.list();

        //将数据库中的user集合放在userlist中
        for(User user:userList){
            if(user.getAccountId().equals(accountId) && user.getPassword().equals(password)){
                return "checkout/welcome";
            }
            else {
                //登录失败

            }
        }
        return "checkout/login";
    }

    @RequestMapping(value = "/toRegister", method = RequestMethod.GET)
    public String toRegister(){
        return "checkout/register";
    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public ModelAndView register(@RequestParam("userName")String userName, @RequestParam("password")String password,
                           @RequestParam("sex")String sex, @RequestParam("phoneNumber")String phoneNumber,
                                 @RequestParam("accountId")String accountId){
        ModelAndView mv = new ModelAndView();
        List<User> userList = userService.list();
        int repeatFlag = 0;
        for(User user:userList){
            if(user.getUserName().equals(userName)){
                repeatFlag++;
            }
        }
        //用户名重复
        if(repeatFlag != 0){
            mv.setViewName("checkout/register");
        }
        //账号密码只能由字母和数字组成，8-14位
        else if(!(isProper(accountId) && isProper(password))){
            mv.setViewName("checkout/register");

        }
        //均符合规范向数据库中添加用户
        else{
            User user = new User();
            user.setUserName(userName);
            user.setPassword(password);
            user.setAccountId(accountId);
            user.setSex(sex);
            user.setPhoneNumber(phoneNumber);
            userService.addUser(user);
            mv.setViewName("checkout/login");
        }
        //返回出错信息

        return mv;
    }

    //判断字符串是否只有字符和数字组成，且为8-14位
    boolean isProper(String str){
        String re = "^[0-9a-zA-Z]{8,14}$";
        return str.matches(re);
    }


}
