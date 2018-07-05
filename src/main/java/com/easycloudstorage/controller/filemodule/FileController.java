package com.easycloudstorage.controller.filemodule;

import com.easycloudstorage.pojo.FileManager;
import com.easycloudstorage.pojo.Test;
import com.easycloudstorage.service.TestService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.List;

import  com.easycloudstorage.pojo.User;
@Controller
public class FileController {
    @Autowired
    private TestService testService;

    @RequestMapping("testPage")
    public ModelAndView list() {
        List<Test> tests = testService.list();

        ModelAndView mv = new ModelAndView();
        mv.setViewName("test/testPage");
        mv.addObject("tests", tests);

        return mv;
    }

    //定位到上传单个文件界面 /hello/upload
    @RequestMapping("uploadPage")

    public String showUploadPage(){

        return "test/uploadPage";

    }


    @RequestMapping(value="upload", method=RequestMethod.POST)
    public String doUploadFile(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
        return FileManager.upload(file,request);
    }


}
