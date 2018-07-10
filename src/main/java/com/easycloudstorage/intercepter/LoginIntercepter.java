package com.easycloudstorage.intercepter;

import com.easycloudstorage.pojo.User;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginIntercepter extends HandlerInterceptorAdapter{
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler) throws Exception {

        String[] noNeedLoginUris = {"checkout", "toLogin", "toRegister", "login", "register"};
        User user = (User) request.getSession().getAttribute("user");
        String uri = request.getRequestURI();
        uri = uri.replace("/EasyCloudStorage/", "");

        if(user == null)
        {
            for(String noNeedUri : noNeedLoginUris)
                if(uri.equals(noNeedUri))
                    return true;

            response.sendRedirect("/EasyCloudStorage/checkout");
            return false;
        }

        return true;
    }
}