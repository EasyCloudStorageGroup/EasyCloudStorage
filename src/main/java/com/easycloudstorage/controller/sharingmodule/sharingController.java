package com.easycloudstorage.controller.sharingmodule;

import com.easycloudstorage.pojo.NormalFile;
import com.easycloudstorage.pojo.Sharing;
import com.easycloudstorage.service.filemodule.FileService;
import com.easycloudstorage.service.sharingmodule.SharingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class sharingController {
    @Autowired
    private SharingService sharingService;
    @Autowired
    private FileService fileService;

    //前台生成链接时存入数据库
    @RequestMapping("/sharingData")
    public ModelAndView getStrAndFileId(@RequestParam String str, @RequestParam Integer fileId, @RequestParam String password){
        //防止一个字符串对应多个fileId
        if(password == null){
            System.out.println("null串");
        }
        else if("".equals(password)) {
            System.out.println("空串");
        }
        if(sharingService.getSharingDataByStr(str) == null){
            Sharing sharing = new Sharing();
            sharing.setStr(str);
            sharing.setFileId(fileId);
            sharing.setPassword(password);
            System.out.println(fileId);
            sharingService.addSharingData(sharing);
        }
        return null;
    }

    @RequestMapping("/linkSharing/{str}")
    public ModelAndView toSharingPage(@PathVariable String str, @RequestParam(value = "str2", required = false) String str2,
                                      @RequestParam(value = "password", required = false) String pwd){
        ModelAndView mv = new ModelAndView();
       if("toSharingPage".equals(str)){
            String password = sharingService.getSharingDataByStr(str2).getPassword();
            if(pwd.equals(password)){
                Integer fileId = sharingService.getSharingDataByStr(str2).getFileId();
                NormalFile normalFile = fileService.selectNormalFile(fileId);
                mv.addObject("normalFile", normalFile);
                mv.setViewName("sharing/linkSharing");
            }
            else {
                mv.setViewName("sharing/enterPassword");
                String error = "密码错误";
                mv.addObject("error", error);
            }
        }
        else {
            Integer fileId = sharingService.getSharingDataByStr(str).getFileId();
            String password = sharingService.getSharingDataByStr(str).getPassword();
            //password为空串为共有链接
            if("".equals(password)){
                NormalFile normalFile = fileService.selectNormalFile(fileId);
                mv.setViewName("sharing/linkSharing");
                mv.addObject("normalFile", normalFile);
            }
            //否则为私有加密链接
            else{
                mv.setViewName("sharing/enterPassword");
            }
        }
        return mv;
    }


}
