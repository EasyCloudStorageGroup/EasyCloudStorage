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

import java.util.ArrayList;
import java.util.List;

@Controller
public class ShowController {
    @Autowired
    private ShowService showService;

    @RequestMapping("showPage")
    public ModelAndView list() {
        User user=new User();

        user.setAccountId("1001");
        //user=       //为该用户赋值

        Directory rootDirectory = showService.rootDirectory(user,showService.directoryList());  //依赖于该用户的根目录，需要同user层交互,目前user为空

        List<Directory> directoryList=new ArrayList<Directory>();//当前目录下的子目录，即根目录下的第一层目录

        directoryList=showService.showDirectory(rootDirectory.getDirId(),showService.directoryList());

        List<NormalFile> normalFileList=new ArrayList<NormalFile>();//当前目录下的文件,即根目录下的文件

        normalFileList=showService.showNormalFile(rootDirectory.getDirId(),showService.normalFileList());

        ModelAndView mv = new ModelAndView();

        mv.setViewName("test/showPage");

        mv.addObject("directoryList",directoryList);//根目录下的子目录

        mv.addObject("normalFileList",normalFileList);//根目录下的文件

        mv.addObject("rootDirectory", rootDirectory);//根目录

        return mv;
    }


    @RequestMapping("homePage")
    public String show(String dirId,Model model){

        List<Directory> directoryList=new ArrayList<Directory>();//当前目录下的子目录

        directoryList=showService.showDirectory(dirId,showService.directoryList());

        List<NormalFile> normalFileList=new ArrayList<NormalFile>();//当前目录下的文件

        normalFileList=showService.showNormalFile(dirId,showService.normalFileList());

        model.addAttribute("directoryList",directoryList);

        model.addAttribute("normalFileList",normalFileList);

        model.addAttribute("rootDirectoryId",dirId);

        return "test/showPage";

    };

}
