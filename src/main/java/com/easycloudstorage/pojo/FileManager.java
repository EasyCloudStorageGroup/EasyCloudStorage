package com.easycloudstorage.pojo;

import com.easycloudstorage.service.filemodule.FileService;
import org.springframework.http.HttpRequest;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;

public class FileManager {

    public static String uploadFiles(MultipartFile[] files, HttpServletRequest request, FileService fileService){

        boolean flag=true;
        for (MultipartFile file:files
             ) {
            String temp=uploadOneFile(file,request,fileService);
            flag &= temp.equals("success");
        }
        if (flag==true)return "success";
        else return "failed";
    }
    public static String uploadOneFile(MultipartFile file, HttpServletRequest request,FileService fileService){

        String name=file.getOriginalFilename();
        HttpSession session=request.getSession();
        Directory dir=(Directory) session.getAttribute("currentDir");
        com.easycloudstorage.pojo.NormalFile uploadFile=new com.easycloudstorage.pojo.NormalFile();

        uploadFile.setName(name);
        String size=Long.toString(file.getSize());
        uploadFile.setSize(size+"kb");
        uploadFile.setType(file.getContentType());
        uploadFile.setLastMovedTime(new Date());
        uploadFile.setOwnerId(dir.getOwnerId());
        uploadFile.setParentDirId(dir.getDirId());
        uploadFile.setRealPath(dir.getRealPath()+"\\"+name);

        java.io.File userDir=new File(dir.getRealPath());
        try {
            fileService.insertFile(uploadFile);
            if (!userDir.exists())
            userDir.mkdirs();
            File temp=new File(userDir,name);
            file.transferTo(temp);
        } catch (Exception e){
            e.printStackTrace();
            return "failed";
        }
        return "success";  //上传成功则跳转至此success.jsp页
    }


}
