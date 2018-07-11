package com.easycloudstorage.controller.usermodule;

import com.easycloudstorage.pojo.File;
import com.easycloudstorage.pojo.User;
import java.util.*;
import com.easycloudstorage.service.usermodule.UserService;
import com.easycloudstorage.util.CreateDirForUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;


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

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public ModelAndView login(@RequestParam("accountId")String accountId, @RequestParam("password")String password,
                              HttpSession session) {
        List<User> userList = userService.list();
        ModelAndView mv = new ModelAndView();
        User theUser = userService.getUserByAccountId(accountId);
        int flag = 0;
        //避免输入为空
        if("".equals(accountId) || "".equals(password)){
            mv.setViewName("checkout/login");
            //String error = "用户名或密码为空";
            //mv.addObject("error2", error);
            return mv;
        }
        else{
            //将数据库中的user集合放在userlist中
            for(User user:userList){
                if(accountId.equals(user.getAccountId()) && password.equals(user.getPassword())){
                  flag++;
                }
            }
            if(flag != 0){
                session.setAttribute("user", theUser);
                mv.setViewName("redirect:homePage");
            }
           else {
                //登录错误
                String error = "账号或密码错误";
                mv.addObject("error2",error);
                mv.setViewName("checkout/login");
            }
            return mv;
        }
    }

    @RequestMapping(value = "/toRegister", method = RequestMethod.GET)
    public String toRegister(){
        return "checkout/register";
    }

    @RequestMapping(value = "/toLogin", method = RequestMethod.GET)
    public String toLogin(){
        return "checkout/login";
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public ModelAndView register(@RequestParam("userName")String userName, @RequestParam("password")String password,
                           @RequestParam("sex")String sex, @RequestParam("phoneNumber")String phoneNumber,
                                 @RequestParam("accountId")String accountId){
        ModelAndView mv = new ModelAndView();
        List<User> userList = userService.list2();
        int repeatFlag = 0;
        int repeatFlag2 = 0;
        for(User user:userList){
            if(userName.equals(user.getUserName())){
                repeatFlag++;
            }
            if(accountId.equals(user.getAccountId())){
                repeatFlag2++;
            }
        }
        //避免输入为空
        if("".equals(userName) || "".equals(password) || "".equals(phoneNumber) || "".equals(accountId)){
            mv.setViewName("checkout/register");
            String error = "输入为空";
            mv.addObject("error", error);
        }
        else{
            //用户名重复
            if(repeatFlag != 0){
                mv.setViewName("checkout/register");
                String error = "用户名重复";
                mv.addObject("error", error);
            }
            //账号重复
            else if(repeatFlag2 != 0){
                mv.setViewName("checkout/register");
                String error = "账号重复";
                mv.addObject("error", error);
            }
            //账号密码只能由字母和数字组成，8-14位
            else if(!(isProper(accountId) && isProper(password))){
                mv.setViewName("checkout/register");
                String error = "账号或密码格式错误";
                mv.addObject("error", error);
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
                //为每一个注册成功的用户生成一个根目录
                CreateDirForUser cd = new CreateDirForUser();
                String userRootDir = cd.createDir(user);
                //向directory中添加数据
                File file = new File();
                file.setName(user.getAccountId());
                file.setLastMovedTime(new Date());
                file.setOwnerId(user.getAccountId());
                file.setRealPath(userRootDir);
                userService.addDir(file);
            }
            //mv.setViewName("checkout/register");

        }
        return mv;
    }

    //判断字符串是否只有字符和数字组成，且为8-14位
    boolean isProper(String str){
        String re = "^[0-9a-zA-Z]{8,14}$";
        return str.matches(re);
    }

    /*
     * 退出登录
     */
    @RequestMapping("logout")
    public String logout(HttpSession session) {
        session.removeAttribute("user");

        return "redirect:checkout";
    }

    @RequestMapping("/getBgUrl")
    public String getBgUrl(@RequestParam("bgUrl") String bgUrl, @RequestParam("accountId") String accountId, HttpSession session){
        User theUser = userService.getUserByAccountId(accountId);
        theUser.setBgUrl(bgUrl);
        userService.updateBgUrl(theUser);
        session.setAttribute("user", theUser);
        return "redirect:homePage";
    }
}
