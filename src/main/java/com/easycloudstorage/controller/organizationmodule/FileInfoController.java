package com.easycloudstorage.controller.organizationmodule;

import com.easycloudstorage.pojo.*;
import com.easycloudstorage.service.organizationmodule.FileInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@Controller
public class FileInfoController {
    @Autowired
    private FileInfoService fileInfoService;

    @RequestMapping("fileInfo")
    public ModelAndView showFileInfo(@RequestParam int fileId, @RequestParam String type, HttpSession session){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("organization/fileInfo/fileInfo");
        modelAndView.addObject("fileType",type);

        User currentUser=(User)session.getAttribute("user");
        String accountId=currentUser.getAccountId();
        if(type.equals("normalFile")){
            NormalFile normalFile=new NormalFile();   //normalfile表中的信息
            normalFile=fileInfoService.getNormalFile(fileId);
            NorFileAuthority norFileAuthority=new NorFileAuthority();  //norfileauthority表中的信息
            norFileAuthority=fileInfoService.getNorAuthority(fileId,accountId);
            modelAndView.addObject("fileInfo",normalFile);
            modelAndView.addObject("fileAuthority",norFileAuthority);
        }
        else{
            Directory directory=new Directory();
            directory=fileInfoService.getDirectory(fileId);
            DirAuthority dirAuthority=new DirAuthority();
            dirAuthority=fileInfoService.getDirAuthority(fileId,accountId);
            modelAndView.addObject("fileInfo",directory);
            modelAndView.addObject("fileAuthority",dirAuthority);
        }

        return modelAndView;
    }
}
