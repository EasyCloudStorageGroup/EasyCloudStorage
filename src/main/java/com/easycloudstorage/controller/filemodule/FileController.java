package com.easycloudstorage.controller.filemodule;

import com.easycloudstorage.pojo.*;
import com.easycloudstorage.service.filemodule.FileService;
import com.easycloudstorage.service.filemodule.ShowService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.io.File;
import java.net.URLDecoder;
import java.util.Date;
import java.util.List;

@Controller
public class FileController {

    @Autowired
    private FileService fileService;

    @Autowired
    private ShowService showService;

    @RequestMapping("uploadPage")
    public String uploadPage(){
        return "upload/uploadPage";
    }

    @ResponseBody
    @RequestMapping(value="upload", method=RequestMethod.POST)
    public Result  doUploadFile(@RequestParam("file") MultipartFile[] files, HttpServletRequest request) {
        boolean result=FileManager.uploadFiles(files,request,fileService);
        Result res=new Result();
        if (result)
        res.setCode(0);
        else
            res.setCode(1);
        return res;
    }

    @RequestMapping("rename")
    public ModelAndView list() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("rename");
        return mv;
    }

    @RequestMapping("renameFilePage")
    public String renameFilePage(@RequestParam("oldFileId")int oldFileId, String newFileName, int dirId)
            throws IOException
    {
        newFileName = URLDecoder.decode(newFileName, "utf-8").replaceAll("%25","%")
                .replaceAll("%23","#").replaceAll("%26","&")
                .replaceAll("%2B","+");
        NormalFile normalFile=fileService.selectNormalFile(oldFileId);
        File file=new File(normalFile.getRealPath());

        //处理文件后缀名
        String suffix="";
        if(!file.isDirectory() && file.getName().contains("."))
            suffix= file.getName().substring(file.getName().indexOf('.'));

        //对本地文件处理
        File newFile;
        if(newFileName.contains("."))
            newFile=new File(normalFile.getRealPath().substring(0,normalFile.getRealPath().lastIndexOf("\\")+1) + newFileName);
        else
            newFile=new File(normalFile.getRealPath().substring(0,normalFile.getRealPath().lastIndexOf("\\")+1)  + newFileName+suffix);
        boolean result=file.renameTo(newFile);

        //对数据库操作
        normalFile.setName(newFile.getName());
        normalFile.setRealPath(newFile.getAbsolutePath());
        fileService.updateNormalFile(normalFile);

        if(dirId == 0)
            return "redirect:homePage?dirId=0";
        else
            return "redirect:homePage?dirId="+dirId;
    }
    @RequestMapping("renameDirectoryPage")
    public String renameDirectoryPage(@RequestParam("oldFileId")int oldFileId, String newFileName,int dirId)
            throws IOException
    {
        newFileName = URLDecoder.decode(newFileName, "utf-8").replaceAll("%25","%")//处理特殊字符
                .replaceAll("%23","#").replaceAll("%26","&")
                .replaceAll("%2B","+");
        System.out.println("in file rename dir  and pid="+oldFileId+" and new name: "+newFileName);
        Directory directory=fileService.selectDirectory(oldFileId);
        File file=new File(directory.getRealPath());

        //对本地文件处理
        File newFile=new File(directory.getRealPath().substring(0,directory.getRealPath().lastIndexOf("\\")) + "\\"+newFileName);
        System.out.println("old+"+file.getName()+" new +"+newFile.getName());
        boolean result=file.renameTo(newFile);

        //对数据库操作
        directory.setName(newFile.getName());
        directory.setRealPath(newFile.getAbsolutePath());
        fileService.updateDirectory(directory);

        if(dirId == 0)
            return "redirect:homePage?dirId=0";
        else
            return "redirect:homePage?dirId="+dirId;
    }
    @RequestMapping("newDirPage")
    public String newDirectory(@RequestParam("dirId")int dirId, String newFileName,HttpSession session)
            throws UnsupportedEncodingException
    {
        newFileName = URLDecoder.decode(newFileName, "utf-8").replaceAll("%25","%")//处理特殊字符
                .replaceAll("%23","#").replaceAll("%26","&")
                .replaceAll("%2B","+");
        User user=(User)session.getAttribute("user");
        List<Directory> directories= showService.directoryList();
        ShowService showService = new ShowService();
        Directory userRootDir = showService.rootDirectory(user, directories);
        if(dirId == 0 && userRootDir!=null)
            dirId=(userRootDir).getDirId();
        Directory directory=fileService.selectDirectory(dirId);
        File file=new File(directory.getRealPath()+"\\"+newFileName);
        file.mkdir();

        Directory newDir=new Directory();
        newDir.setName(newFileName);
        newDir.setLastMovedTime(new Date());
        newDir.setParentDirId(dirId);
        newDir.setOwnerId(user.getAccountId());
        newDir.setRealPath(file.getAbsolutePath());
        fileService.newDirectory(newDir);

        return "redirect:homePage?dirId="+dirId;
    }

    @RequestMapping("deleteFilePage")
    public String deleteFile(int fileId, int dirId)throws IOException
    {
        NormalFile normalFile=fileService.selectNormalFile(fileId);

        File file=new File(normalFile.getRealPath());
        fileService.deleteNormalFile(normalFile);
        file.delete();

        if(dirId == 0)
            return "redirect:homePage?dirId=0";
        else
            return "redirect:homePage?dirId="+dirId;
    }

    @RequestMapping("deleteDirectoryPage")
    public String deleteDirectory(int fileId, int dirId)throws IOException
    {System.out.println("in dir delete  and pid="+fileId);
        Directory directory=fileService.selectDirectory(fileId);
        File file=new File(directory.getRealPath());
        file.delete();

        fileService.deleteDirectory(directory);

        if(dirId == 0)
            return "redirect:homePage?dirId=0";
        else
            return "redirect:homePage?dirId="+dirId;
    }
    @RequestMapping("moveFilePage")
    public String moveFile(@RequestParam("fileId")int fileId, int moveToId, int dirId)
            throws IOException
    {
        Directory movetoDir=fileService.selectDirectory(moveToId);
        NormalFile normalFile=fileService.selectNormalFile(fileId);

        File file=new File(normalFile.getRealPath());
        File moveToFile=new File(movetoDir.getRealPath()+"\\"+file.getName());

        //if(!moveToFile.getParentFile().exists())    moveToFile.getParentFile().mkdirs();

        normalFile.setParentDirId(movetoDir.getDirId());
        normalFile.setRealPath(moveToFile.getAbsolutePath());
        fileService.updateNormalFile(normalFile);

        if(dirId == 0)
            return "redirect:homePage?dirId=0";
        else
            return "redirect:homePage?dirId="+dirId;
    }
    @RequestMapping("moveDirectoryPage")
    public String moveDirectory(@RequestParam("fileId")int fileId, int moveToId, int dirId)
            throws IOException
    {
        Directory movetoDir=fileService.selectDirectory(moveToId);
        Directory srcDir=fileService.selectDirectory(fileId);

        File file=new File(srcDir.getRealPath());
        File moveToFile=new File(movetoDir.getRealPath()+"\\"+file.getName());

        srcDir.setParentDirId(movetoDir.getDirId());
        srcDir.setRealPath(moveToFile.getAbsolutePath());
        fileService.updateDirectory(srcDir);

        //if(!moveToFile.getParentFile().exists())    moveToFile.getParentFile().mkdirs();

        if(dirId == 0)
            return "redirect:homePage?dirId=0";
        else
            return "redirect:homePage?dirId="+dirId;
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