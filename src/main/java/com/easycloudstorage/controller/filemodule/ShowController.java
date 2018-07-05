package com.easycloudstorage.controller.filemodule;

import com.easycloudstorage.pojo.Directory;
import com.easycloudstorage.pojo.NormalFile;
import com.easycloudstorage.pojo.Test;
import com.easycloudstorage.pojo.User;
import com.easycloudstorage.service.filemodule.ShowService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ShowController {
    @Autowired
    private ShowService showService;

    @RequestMapping("homePage")
    public ModelAndView show(String dirId, HttpSession session) {

        Directory rootDirectory=null;

        User user=(User)session.getAttribute("user");

        if(dirId==null) {//如果是第一次进入该函数，该函数为用户的根目录，此时dirID为空，先找到用户的根目录

            rootDirectory = showService.rootDirectory(user, showService.directoryList()); //找到用户的根目录

            dirId = rootDirectory.getDirId();
        }
        List<Directory> directoryList=new ArrayList<Directory>();//当前目录下的子目录，即根目录下的第一层目录

        directoryList=showService.showDirectory(dirId,showService.directoryList());

        List<NormalFile> normalFileList=new ArrayList<NormalFile>();//当前目录下的文件,即根目录下的文件

        normalFileList=showService.showNormalFile(dirId,showService.normalFileList());

        ModelAndView mv = new ModelAndView();

        mv.setViewName("home/homePage");

        mv.addObject("directoryList",directoryList);//根目录下的子目录

        mv.addObject("normalFileList",normalFileList);//根目录下的文件

        mv.addObject("rootDirectory", rootDirectory);//根目录

        return mv;
    }
}
