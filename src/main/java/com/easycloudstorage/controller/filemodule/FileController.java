package com.easycloudstorage.controller.filemodule;

import com.easycloudstorage.pojo.Directory;
import com.easycloudstorage.pojo.FileManager;
import com.easycloudstorage.pojo.Test;
import com.easycloudstorage.service.TestService;

import com.easycloudstorage.service.filemodule.FileService;
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
    private FileService fileService;


    @RequestMapping("test")
    public String temp3(){
        return "test/newTest";
    }

    @ResponseBody
    @RequestMapping(value="/upload", method=RequestMethod.POST)
    public Result  doUploadFile(@RequestParam("file") MultipartFile[] files, HttpServletRequest request) {
        System.out.println("function called "+files.length);
        String result=FileManager.uploadFiles(files,request,fileService);
        Result res=new Result();
        if (result.equals("success"))
        res.setCode(0);
        else
            res.setCode(1);
        return res;
        }

}

class Result{
    public int code;
    public Result(){

    }
    public void setCode(int newCode){
        this.code=newCode;
    }
    public int getCode(){
        return code;
    }
}