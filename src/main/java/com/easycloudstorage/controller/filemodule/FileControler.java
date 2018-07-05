package com.easycloudstorage.controller.filemodule;

import com.easycloudstorage.mapper.filemodule.FileControllerMapper;
import com.easycloudstorage.pojo.Directory;
import com.easycloudstorage.pojo.NormalFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.io.IOException;
import java.util.List;
@Controller
public class FileControler {
    private String dataDir="D:/EasyCloudStorageData/";
    @Autowired
    private FileControllerMapper fileControllerMapper;

    @RequestMapping("rename")
    public ModelAndView list() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("rename");
        return mv;
    }
    @RequestMapping("renamePage")
    public String renamePage(@RequestParam("oldFilePid")String oldFilePid, String newFileName)
            throws IOException
    {
        NormalFile normalFile=fileControllerMapper.selectNormalFile(oldFilePid);
        File file=new File(dataDir+normalFile.getName());

        //处理文件后缀名
        String suffix="";
        if(!file.isDirectory() && file.getName().contains("."))
            suffix= file.getName().substring(file.getName().indexOf('.'));
        System.out.println(file.getName());
        //对本地文件处理
        File newFile;
        if(newFileName.contains("."))
            newFile=new File(dataDir + newFileName);
        else
            newFile=new File(dataDir + newFileName+suffix);System.out.println(newFile.getName());
        boolean result=file.renameTo(newFile);
        if(result) System.out.println("rename success");    else System.out.println("rename failed");

        //对数据库操作
        normalFile.setName(newFile.getName());
        fileControllerMapper.updateNormalFile(normalFile);

        return "redirect:rename";
    }
    @RequestMapping("deleteFilePage")
    public String delete(String filePid)throws IOException
    {System.out.println("in delete  and pid="+filePid);
        File file=new File(dataDir+"test.txt");
        file.delete();

        return "redirect:rename";
    }
    @RequestMapping("moveFilePage")
    public String move(@RequestParam("filePid")String filePid, String moveToPath)
            throws IOException
    {System.out.println("in move and pid ="+filePid+" and moveToPath="+moveToPath);
        File file=new File(dataDir+"moveFile.txt");
        File moveToFile=new File(dataDir + "yyy/"+"moveFile.txt");
        if(!moveToFile.getParentFile().exists())    moveToFile.getParentFile().mkdirs();
        if(file.renameTo(moveToFile)) System.out.println("successed move");
        else System.out.println("failed move");

        return "redirect:rename";
    }
}
