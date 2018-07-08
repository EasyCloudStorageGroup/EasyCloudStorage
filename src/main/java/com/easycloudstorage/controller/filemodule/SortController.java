package com.easycloudstorage.controller.filemodule;

import com.easycloudstorage.pojo.Directory;
import com.easycloudstorage.pojo.NormalFile;
import com.easycloudstorage.pojo.User;
import com.easycloudstorage.service.filemodule.ShowService;

import com.easycloudstorage.service.filemodule.SortService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class SortController {
    @Autowired
    private SortService sortService;

    @RequestMapping("SortFile")
    public String SortFile(HttpSession session,String typeTag){
        //存储从数据库获取的普通文件的列表
        List<NormalFile> sortFile=new ArrayList<>();
        sortFile=sortService.normalFileList((User)session.getAttribute("user"));

        List<NormalFile> typeFile=new ArrayList<>();//存储相应类型的文件

        for(int i=0;i<sortFile.size();i++){
            if(typeTag.equals("1")&&sortFile.get(i).judgeType().equals("Picture")){
                typeFile.add(sortFile.get(i));
            }
            else if(typeTag.equals("2")&&sortFile.get(i).judgeType().equals("Vedio")){
                typeFile.add(sortFile.get(i));
            }
            else if(typeTag.equals("3")&&sortFile.get(i).judgeType().equals("Music")){
                typeFile.add(sortFile.get(i));
            }
            else if(typeTag.equals("4")&&sortFile.get(i).judgeType().equals("Other"))
                typeFile.add(sortFile.get(i));
        }
        session.setAttribute("currentNormalFiles",typeFile);
        session.setAttribute("currentDirectories", null);

        return "home/homePage";
    }
}