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

    public static boolean uploadFiles(MultipartFile[] files, HttpServletRequest request, FileService fileService){

        boolean flag=true;
        for (MultipartFile file:files
             ) {
            boolean result=uploadOneFile(file,request,fileService);
            flag &=  result;
        }
        return flag;
    }
    public static String changeName(File parentDir,String str){
        int i=1;
        int indexOfDot=str.lastIndexOf('.');
        int indexOfNum;
        if (indexOfDot==-1){
            str+="("+i+")";
            indexOfNum=str.length()-2;
        }
        else{
            str=str.substring(0,indexOfDot)+"("+i+")."+str.substring(indexOfDot+1);
            indexOfNum=indexOfDot+1;
        }
        File tempFile = new File(parentDir,str);
        while (tempFile.exists()){
            ++i;
            str=str.substring(0,indexOfNum)+i+str.substring(indexOfNum+1);
            tempFile=new File(parentDir,str);
        }
        return str;
    }
    public static String changeSize(long size){
        int count=0;
        while(size>1000){
            size/=1000;
            ++count;
        }
        String postFix;
        switch (count){
            case 0:
                postFix="KB";
                break;
            case 1:
                postFix="MB";
                break;
            case 2:
                postFix="GB";
                break;
            case 3:
                postFix="TB";
                break;
            default:
                postFix="";
                break;
        }
        return size+postFix;
    }
    public static boolean uploadOneFile(MultipartFile file, HttpServletRequest request,FileService fileService){

        String name=file.getOriginalFilename();
        HttpSession session=request.getSession();
        Directory dir=(Directory) session.getAttribute("currentDir");
        com.easycloudstorage.pojo.NormalFile uploadFile=new com.easycloudstorage.pojo.NormalFile();

        String size=changeSize(file.getSize());
        uploadFile.setSize(size);
        uploadFile.setType(file.getContentType());
        uploadFile.setLastMovedTime(new Date());
        uploadFile.setOwnerId(dir.getOwnerId());
        uploadFile.setParentDirId(dir.getDirId());
        uploadFile.setRealPath(dir.getRealPath()+"\\"+name);

        java.io.File userDir=new File(dir.getRealPath());
        try {
            if (!userDir.exists())
            userDir.mkdirs();
            File temp=new File(userDir,name);
            if (temp.exists()) {
                name = changeName(userDir,name);
            }
            temp = new File(userDir,name);
            uploadFile.setName(name);
            fileService.insertFile(uploadFile);
            file.transferTo(temp);
        } catch (Exception e){
            e.printStackTrace();
            return false;
        }
        return true;  //上传成功则跳转至此success.jsp页
    }


}
