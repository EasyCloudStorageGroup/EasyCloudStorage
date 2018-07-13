package com.easycloudstorage.controller.filemodule;

import com.easycloudstorage.pojo.*;
import com.easycloudstorage.service.filemodule.FileService;
import com.easycloudstorage.service.filemodule.ShowService;

import com.easycloudstorage.service.organizationmodule.AuthorityService;
import com.easycloudstorage.service.organizationmodule.OrganizationService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

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
    @Autowired
    private AuthorityService authorityService;
    @Autowired
    private OrganizationService organizationService;

    @RequestMapping("uploadPage")
    public String uploadPage(){
        return "upload/uploadPage";
    }

    @ResponseBody
    @RequestMapping(value="upload", method=RequestMethod.POST)
    public Result  doUploadFile(@RequestParam("file") MultipartFile[] files, HttpServletRequest request) {
        boolean result=FileManager.uploadFiles(files,request,fileService, authorityService, organizationService);
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
        JSONObject object = new JSONObject();
        object.put("a", "aaaaaa");
        object.put("b", 111111);
        JSONObject b = new JSONObject();
        b.put("ccc", 1);b.put("bbb","ffffefa");
        object.put("obh", b);
        mv.setViewName("rename");
        return mv;
    }

    @RequestMapping("renameFilePage")
    public String renameFilePage(@RequestParam("oldFileId")Integer oldFileId, String newFileName, Integer dirId,
                                 HttpSession session)
            throws IOException
    {
        newFileName = URLDecoder.decode(newFileName, "utf-8").replaceAll("%25","%")
                .replaceAll("%23","#").replaceAll("%26","&")
                .replaceAll("%2B","+");
        List<Directory> allDirectories = showService.directoryList();
        int parentDirId = showService.findParentDir(oldFileId, allDirectories).getDirId();
        NormalFile normalFile=fileService.selectNormalFile(oldFileId);
        if(!normalFile.getName().equals(newFileName) && fileAlreadyExist(parentDirId, newFileName))
        {
            for(int i=1;i<1000;i++)//1000，最多后缀1000,
            {
                if(!fileAlreadyExist(dirId, newFileName.substring(0,newFileName.lastIndexOf("."))+"("+i+")"
                                            +newFileName.substring(newFileName.lastIndexOf(".")))) {
                    newFileName = newFileName.substring(0,newFileName.lastIndexOf("."))+"("+i+")"
                            +newFileName.substring(newFileName.lastIndexOf("."));//这一串处理后缀名
                    break;
                }
            }
        }
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

        if(normalFile.getOrgId() == null) {
            if(dirId == 0)
                return "redirect:homePage";
            else
                return "redirect:homePage?dirId="+dirId;
        }
        else {
            Directory currentDir = (Directory) session.getAttribute("currentDir");
            if(currentDir.getParentDirId() == null)
                return "redirect:orgHomePage";
            else
                return "redirect:orgHomePage?dirId="+currentDir.getDirId();
        }
    }

    @RequestMapping("renameDirectoryPage")
    public String renameDirectoryPage(@RequestParam("oldFileId")Integer oldFileId, String newFileName,Integer dirId,
                                      HttpSession session)
            throws IOException
    {
        newFileName = URLDecoder.decode(newFileName, "utf-8").replaceAll("%25","%")//处理特殊字符
                .replaceAll("%23","#").replaceAll("%26","&")
                .replaceAll("%2B","+");
        List<Directory> allDirectories = showService.directoryList();
        int parentDirId = showService.findParentDir(oldFileId, allDirectories).getDirId();
        System.out.println("in file rename dir  and pid="+oldFileId+" and new name: "+newFileName);
        Directory directory=fileService.selectDirectory(oldFileId);
        if(!directory.getName().equals(newFileName) && fileAlreadyExist(parentDirId, newFileName))
        {
            for(int i=1;i<1000;i++)//1000，最多后缀1000,
            {
                if(!fileAlreadyExist(parentDirId, newFileName+"("+i+")")) {
                    newFileName = newFileName+"("+i+")";
                    break;
                }
            }
        }
        File file=new File(directory.getRealPath());

        //对本地文件处理
        File newFile=new File(directory.getRealPath().substring(0,directory.getRealPath().lastIndexOf("\\")) + "\\"+newFileName);
        System.out.println("old+"+file.getName()+" new +"+newFile.getName());
        boolean result=file.renameTo(newFile);

        //对数据库操作
        directory.setName(newFile.getName());
        directory.setRealPath(newFile.getAbsolutePath());
        fileService.updateDirectory(directory);

        if(directory.getOrgId() == null) {
            if(dirId == 0)
                return "redirect:homePage";
            else
                return "redirect:homePage?dirId="+dirId;
        }
        else {
            Directory currentDir = (Directory) session.getAttribute("currentDir");
            if(currentDir.getParentDirId() == null)
                return "redirect:orgHomePage";
            else
                return "redirect:orgHomePage?dirId="+currentDir.getDirId();
        }
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
        if(dirId == 0 && userRootDir!=null)//根目录
            dirId=(userRootDir).getDirId();
        if(fileAlreadyExist(dirId, newFileName))
        {
            for(int i=1;i<1000;i++)//1000，最多后缀1000,
            {
                if(!fileAlreadyExist(dirId, newFileName+"("+i+")")) {
                    newFileName = newFileName+"("+i+")";
                    break;
                }
            }
        }
        Directory directory=fileService.selectDirectory(dirId);
        File file=new File(directory.getRealPath()+"\\"+newFileName);
        file.mkdir();

        Directory currentDir = (Directory) session.getAttribute("currentDir");    //当前目录
        Directory newDir=new Directory();
        newDir.setName(newFileName);
        newDir.setLastMovedTime(new Date());
        newDir.setParentDirId(currentDir.getDirId());
        newDir.setOwnerId(currentDir.getOwnerId());
        newDir.setRealPath(file.getAbsolutePath());
        newDir.setOrgId(currentDir.getOrgId());
        fileService.newDirectory(newDir);

        /*
         * 判断是组织还是个人
         * 如果是组织，需要插入文件权限
         */
        if(currentDir.getOwnerId() != null)
            return "redirect:homePage?dirId="+dirId;
        else {
            DirAuthority dirAuthority = new DirAuthority();
            dirAuthority.setDirId(newDir.getDirId());
            dirAuthority.setAccountId(user.getAccountId());
            dirAuthority.setOrgId(currentDir.getOrgId());
            dirAuthority.setAuthority(Authority.VISIBLE_EDITABLE_NEWABLE);
            authorityService.addDirAuthority(dirAuthority);

             /*如果当前用户不是组织拥有者，那么需要给拥有者加上权限*/
            String ownerId = organizationService.getOwnerId(currentDir.getOrgId());
            if(!ownerId.equals(user.getAccountId())) {
                dirAuthority.setAccountId(ownerId);
                authorityService.addDirAuthority(dirAuthority);
            }

            if(currentDir.getParentDirId() == null)
                return "redirect:orgHomePage";
            else
                return "redirect:orgHomePage?dirId="+currentDir.getDirId();
        }
    }

    @RequestMapping("deleteFilePage")
    public String deleteFile(Integer fileId, Integer dirId, HttpSession session)throws IOException
    {
        NormalFile normalFile=fileService.selectNormalFile(fileId);

        File file=new File(normalFile.getRealPath());
        fileService.deleteNormalFile(normalFile);
        file.delete();

        return "success";
    }

    @RequestMapping("deleteDirectoryPage")
    public String deleteDirectory(Integer fileId, Integer dirId, HttpSession session)throws IOException
    {System.out.println("in dir delete  and pid="+fileId);
        Directory directory=fileService.selectDirectory(fileId);
        File file=new File(directory.getRealPath());
        file.delete();

        fileService.deleteDirectory(directory);

        return "success";
    }
    @RequestMapping("moveFilePage")
    public String moveFile(@RequestParam("fileId")Integer fileId, Integer moveToId, Integer dirId)
            throws IOException
    {
        Directory movetoDir=fileService.selectDirectory(moveToId);
        NormalFile normalFile=fileService.selectNormalFile(fileId);

        List<Directory> allDirectories = showService.directoryList();
        int parentDirId = movetoDir.getDirId();
        String normalFileName = normalFile.getName();
        if(fileAlreadyExist(parentDirId, normalFileName))
        {
            for(int i=1;i<1000;i++)//1000，最多后缀1000,
            {
                if(!fileAlreadyExist(dirId, normalFileName.substring(0,normalFileName.lastIndexOf("."))+"("+i+")"
                        +normalFileName.substring(normalFileName.lastIndexOf(".")))) {
                    normalFileName = normalFileName.substring(0,normalFileName.lastIndexOf("."))+"("+i+")"
                            +normalFileName.substring(normalFileName.lastIndexOf("."));//这一串处理后缀名
                    normalFile.setName(normalFileName);
                    break;
                }
            }
        }

        File file=new File(normalFile.getRealPath());
        File moveToFile=new File(movetoDir.getRealPath()+"\\"+normalFile.getName());
        file.renameTo(moveToFile);

        //if(!moveToFile.getParentFile().exists())    moveToFile.getParentFile().mkdirs();

        normalFile.setParentDirId(movetoDir.getDirId());
        normalFile.setRealPath(moveToFile.getAbsolutePath());
        fileService.updateNormalFile(normalFile);

        if(dirId == 0)
            return "redirect:homePage";
        else
            return "redirect:homePage?dirId="+dirId;
    }
    @RequestMapping("moveDirectoryPage")
    public String moveDirectory(@RequestParam("fileId")Integer fileId, Integer moveToId, Integer dirId,HttpSession session)
            throws IOException
    {
        if(!(fileId .equals(moveToId)))
        {
            User user=(User)session.getAttribute("user");
            List<Directory> directories= showService.directoryList();
            ShowService showService = new ShowService();
            Directory userRootDir = showService.rootDirectory(user, directories);
            Directory movetoDir=fileService.selectDirectory(moveToId);
            Directory srcDir=fileService.selectDirectory(fileId);
            if(dirId == 0 && userRootDir!=null)//根目录
                dirId=(userRootDir).getDirId();
            if(fileAlreadyExist(moveToId, srcDir.getName()))
            {
                for(int i=1;i<1000;i++)//1000，最多后缀1000,
                {
                    if(!fileAlreadyExist(dirId, srcDir.getName()+"("+i+")")) {
                        srcDir.setName(srcDir.getName()+"("+i+")");
                        break;
                    }
                }
            }

            File file=new File(srcDir.getRealPath());
            File moveToFile=new File(movetoDir.getRealPath()+"\\"+srcDir.getName());
            file.renameTo(moveToFile);

            srcDir.setParentDirId(movetoDir.getDirId());
            srcDir.setRealPath(moveToFile.getAbsolutePath());
            fileService.updateDirectory(srcDir);
        }

        if(dirId == 0)
            return "redirect:homePage";
        else
            return "redirect:homePage?dirId="+dirId;
    }

    @RequestMapping("getAllDirectories")
    @ResponseBody
    public JSONObject allDirectories(HttpSession session)
    {
        User user = (User)session.getAttribute("user");
        List<Directory> directories = showService.directoryList();
        Directory root = showService.rootDirectory(user, directories);
        JSONObject object = getJsonObjectOfDirById(root.getDirId());
        System.out.println(object.toString());
        return object;
    }

    private JSONObject getJsonObjectOfDirById(Integer dirId)
    {
        JSONObject object = new JSONObject();
        List<Directory> directories = showService.directoryList();
        Directory curDir = showService.findDirectoryById(dirId, directories);
        List<Directory> childrenDir = showService.showDirectory(dirId, directories);
        object.put("dirId", ""+curDir.getDirId());
        object.put("name", curDir.getName());

        JSONArray children = new JSONArray();
        if(!childrenDir.isEmpty()) {
            for (Directory directory : childrenDir)
                children.add(getJsonObjectOfDirById(directory.getDirId()));
            object.put("childrenDir", children);
        }
        else
            object.put("childrenDir", (Object)null);

        return object;
    }
    private boolean fileAlreadyExist(Integer parentDirId, String fileName)
    {
        List<Directory> allDirectories = showService.directoryList();
        List<Directory> directoriesOfDir = showService.showDirectory(parentDirId, allDirectories);

        for(Directory directory : directoriesOfDir)
            if(directory.getName().equals(fileName))
                return true;

        List<NormalFile> allNormalFiles = showService.normalFileList();
        List<NormalFile> normalFilesOfDir = showService.showNormalFile(parentDirId, allNormalFiles);
        for(NormalFile normalFile : allNormalFiles)
            if(normalFile.getName().equals(fileName))
                return true;

        return false;
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