package com.easycloudstorage.controller.filemodule;

import com.easycloudstorage.mapper.filemodule.FileControllerMapper;
import com.easycloudstorage.mapper.filemodule.ShowMapper;
import com.easycloudstorage.pojo.Directory;
import com.easycloudstorage.pojo.NormalFile;
import com.easycloudstorage.pojo.User;
import com.easycloudstorage.service.filemodule.ShowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@Controller
public class FileControler {
    private String dataDir="D:/EasyCloudStorageData/";
    @Autowired
    private FileControllerMapper fileControllerMapper;
    @Autowired
    private ShowMapper showMapper;

    @RequestMapping("rename")
    public ModelAndView list() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("rename");
        return mv;
    }
    @RequestMapping("renameFilePage")
    public String renameFilePage(@RequestParam("oldFileId")String oldFileId, String newFileName, String dirId)
            throws IOException
    {
        NormalFile normalFile=fileControllerMapper.selectNormalFile(oldFileId);
        File file=new File(normalFile.getRealPath());

        //处理文件后缀名
        String suffix="";
        if(!file.isDirectory() && file.getName().contains("."))
            suffix= file.getName().substring(file.getName().indexOf('.'));
        System.out.println(file.getName());
        //对本地文件处理
        File newFile;
        if(newFileName.contains("."))
            newFile=new File(normalFile.getRealPath().substring(0,normalFile.getRealPath().lastIndexOf("\\")+1) + newFileName);
        else
            newFile=new File(normalFile.getRealPath().substring(0,normalFile.getRealPath().lastIndexOf("\\")+1)  + newFileName+suffix);System.out.println(newFile.getName());
        boolean result=file.renameTo(newFile);
        if(result) System.out.println("rename success");    else System.out.println("rename failed");

        //对数据库操作
        normalFile.setName(newFile.getName());
        normalFile.setRealPath(newFile.getAbsolutePath());
        fileControllerMapper.updateNormalFile(normalFile);

        if(dirId.equals("-1"))
            return "redirect:homePage";
        else
            return "redirect:homePage?dirId="+dirId;
    }
    @RequestMapping("renameDirectoryPage")
    public String renameDirectoryPage(@RequestParam("oldFileId")String oldFileId, String newFileName,String dirId)
            throws IOException
    {
        System.out.println("in file rename dir  and pid="+oldFileId+" and new name: "+newFileName);
        Directory directory=fileControllerMapper.selectDirectory(oldFileId);
        File file=new File(directory.getRealPath());

        System.out.println(file.getName());
        //对本地文件处理
        File newFile=new File(directory.getRealPath().substring(0,directory.getRealPath().lastIndexOf("\\")) + "\\"+newFileName);
        System.out.println("old+"+file.getName()+" new +"+newFile.getName());
        boolean result=file.renameTo(newFile);
        if(result) System.out.println("rename success");    else System.out.println("rename failed");

        //对数据库操作
        directory.setName(newFile.getName());
        directory.setRealPath(newFile.getAbsolutePath());
        fileControllerMapper.updateDirectory(directory);

        if(dirId.equals("-1"))
            return "redirect:homePage";
        else
            return "redirect:homePage?dirId="+dirId;
    }
    @RequestMapping("newDirPage")
    public String newDirectory(@RequestParam("dirId")String dirId, String newFileName,HttpSession session)
    {
        User user=(User)session.getAttribute("user");
        List<Directory> directories= showMapper.directoryList();
        ShowService showService = new ShowService();
        Directory userRootDir = showService.rootDirectory(user, directories);
        if(dirId.equals("-1") && userRootDir!=null)
            dirId=(userRootDir).getDirId();
        Directory directory=fileControllerMapper.selectDirectory(dirId);
        File file=new File(directory.getRealPath()+"\\"+newFileName);
        file.mkdir();

        Directory newDir=new Directory();
        newDir.setName(newFileName);
        newDir.setLastMovedTime(new Date());
        newDir.setParentDirId(dirId);
        newDir.setOwnerId(user.getAccountId());
        newDir.setRealPath(file.getAbsolutePath());
        fileControllerMapper.newDirectory(newDir);

        return "redirect:homePage?dirId="+dirId;
    }
    @RequestMapping("deleteFilePage")
    public String deleteFile(String fileId,String dirId)throws IOException
    {System.out.println("in file delete  and pid="+fileId);
        NormalFile normalFile=fileControllerMapper.selectNormalFile(fileId);

        File file=new File(normalFile.getRealPath());
        fileControllerMapper.deleteNormalFile(normalFile);
        file.delete();

        if(dirId.equals("-1"))
            return "redirect:homePage";
        else
            return "redirect:homePage?dirId="+dirId;
    }
    @RequestMapping("deleteDirectoryPage")
    public String deleteDirectory(String fileId,String dirId)throws IOException
    {System.out.println("in dir delete  and pid="+fileId);
        Directory directory=fileControllerMapper.selectDirectory(fileId);
        File file=new File(directory.getRealPath());
        file.delete();

        fileControllerMapper.deleteDirectory(directory);


        if(dirId.equals("-1"))
            return "redirect:homePage";
        else
            return "redirect:homePage?dirId="+dirId;
    }
    @RequestMapping("moveFilePage")
    public String moveFile(@RequestParam("fileId")String fileId, String moveToId,String dirId)
            throws IOException
    {
        System.out.println("in move and pid ="+fileId+" and moveToPath="+moveToId);
        Directory movetoDir=fileControllerMapper.selectDirectory(moveToId);
        NormalFile normalFile=fileControllerMapper.selectNormalFile(fileId);

        File file=new File(normalFile.getRealPath());
        File moveToFile=new File(movetoDir.getRealPath()+"\\"+file.getName());

        //if(!moveToFile.getParentFile().exists())    moveToFile.getParentFile().mkdirs();
        if(file.renameTo(moveToFile)) System.out.println("successed move");
        else System.out.println("failed move");

        normalFile.setParentDirId(movetoDir.getDirId());
        normalFile.setRealPath(moveToFile.getAbsolutePath());
        fileControllerMapper.updateNormalFile(normalFile);

        if(dirId.equals("-1"))
            return "redirect:homePage";
        else
            return "redirect:homePage?dirId="+dirId;
    }
    @RequestMapping("moveDirectoryPage")
    public String moveDirectory(@RequestParam("fileId")String fileId, String moveToId,String dirId)
            throws IOException
    {System.out.println("in move and pid ="+fileId+" and moveToPath="+moveToId);
        Directory movetoDir=fileControllerMapper.selectDirectory(moveToId);
        Directory srcDir=fileControllerMapper.selectDirectory(fileId);

        File file=new File(srcDir.getRealPath());
        File moveToFile=new File(movetoDir.getRealPath()+"\\"+file.getName());

        srcDir.setParentDirId(movetoDir.getDirId());
        srcDir.setRealPath(moveToFile.getAbsolutePath());
        fileControllerMapper.updateDirectory(srcDir);

        //if(!moveToFile.getParentFile().exists())    moveToFile.getParentFile().mkdirs();
        if(file.renameTo(moveToFile)) System.out.println("successed move");
        else System.out.println("failed move");

        if(dirId.equals("-1"))
            return "redirect:homePage";
        else
            return "redirect:homePage?dirId="+dirId;
    }
}
