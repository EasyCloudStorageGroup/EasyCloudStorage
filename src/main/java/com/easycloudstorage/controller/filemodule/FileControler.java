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
    private String user="/";
    @Autowired
    private FileControllerMapper fileControllerMapper;

    @RequestMapping("rename")
    public ModelAndView list() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("rename");
        return mv;
    }
    @RequestMapping("renameFilePage")
    public String renameFilePage(@RequestParam("oldFileId")String oldFileId, String newFileName)
            throws IOException
    {
        NormalFile normalFile=fileControllerMapper.selectNormalFile(oldFileId);
        File file=new File(dataDir+normalFile.getName());

        //处理文件后缀名
        String suffix="";
        if(!file.isDirectory() && file.getName().contains("."))
            suffix= file.getName().substring(file.getName().indexOf('.'));
        System.out.println(file.getName());
        //对本地文件处理
        File newFile;
        if(newFileName.contains("."))
            newFile=new File(dataDir + user + newFileName);
        else
            newFile=new File(dataDir + user + newFileName+suffix);System.out.println(newFile.getName());
        boolean result=file.renameTo(newFile);
        if(result) System.out.println("rename success");    else System.out.println("rename failed");

        //对数据库操作
        normalFile.setName(newFile.getName());
        fileControllerMapper.updateNormalFile(normalFile);

        return "redirect:rename";
    }
    @RequestMapping("renameDirectoryPage")
    public String renameDirectoryPage(@RequestParam("oldFileId")String oldFilePid, String newFileName)
            throws IOException
    {
        Directory directory=fileControllerMapper.selectDirectory(oldFilePid);
        File file=new File(dataDir+directory.getName());

        System.out.println(file.getName());
        //对本地文件处理
        File newFile=new File(dataDir + user + newFileName);
        boolean result=file.renameTo(newFile);
        if(result) System.out.println("rename success");    else System.out.println("rename failed");

        //对数据库操作
        directory.setName(newFile.getName());
        fileControllerMapper.updateDirectory(directory);

        return "redirect:rename";
    }
    @RequestMapping("deleteFilePage")
    public String deleteFile(String fileId)throws IOException
    {System.out.println("in file delete  and pid="+fileId);
        NormalFile normalFile=fileControllerMapper.selectNormalFile(fileId);

        File file=new File(dataDir + user + normalFile.getName());
        fileControllerMapper.deleteNormalFile(normalFile);
        file.delete();

        return "redirect:rename";
    }
    @RequestMapping("deleteDirectoryPage")
    public String deleteDirectory(String fileId)throws IOException
    {System.out.println("in dir delete  and pid="+fileId);
        Directory directory=fileControllerMapper.selectDirectory(fileId);
        File file=new File(dataDir + user + directory.getName());
        file.delete();

        fileControllerMapper.deleteDirectory(directory);


        return "redirect:rename";
    }
    @RequestMapping("moveFilePage")
    public String moveFile(@RequestParam("fileId")String fileId, String moveToId)
            throws IOException
    {
        System.out.println("in move and pid ="+fileId+" and moveToPath="+moveToId);
        Directory movetoDir=fileControllerMapper.selectDirectory(moveToId);
        NormalFile normalFile=fileControllerMapper.selectNormalFile(fileId);

        File file=new File(dataDir + user + normalFile.getName());
        File moveToFile=new File(dataDir + user + movetoDir.getName()+"/"+file.getName());

        //if(!moveToFile.getParentFile().exists())    moveToFile.getParentFile().mkdirs();
        if(file.renameTo(moveToFile)) System.out.println("successed move");
        else System.out.println("failed move");

        normalFile.setParentDirId(movetoDir.getDirId());
        normalFile.setRealPath(moveToFile.getAbsolutePath());
        fileControllerMapper.updateNormalFile(normalFile);

        return "redirect:rename";
    }
    @RequestMapping("moveDirectoryPage")
    public String moveDirectory(@RequestParam("fileId")String fileId, String moveToId)
            throws IOException
    {System.out.println("in move and pid ="+fileId+" and moveToPath="+moveToId);
        Directory movetoDir=fileControllerMapper.selectDirectory(moveToId);
        Directory srcDir=fileControllerMapper.selectDirectory(fileId);

        File file=new File(dataDir + user + srcDir.getName());
        File moveToFile=new File(dataDir + user + movetoDir.getName()+"/"+file.getName());

        srcDir.setParentDirId(movetoDir.getDirId());
        srcDir.setRealPath(moveToFile.getAbsolutePath());
        fileControllerMapper.updateDirectory(srcDir);

        //if(!moveToFile.getParentFile().exists())    moveToFile.getParentFile().mkdirs();
        if(file.renameTo(moveToFile)) System.out.println("successed move");
        else System.out.println("failed move");

        return "redirect:rename";
    }
}
