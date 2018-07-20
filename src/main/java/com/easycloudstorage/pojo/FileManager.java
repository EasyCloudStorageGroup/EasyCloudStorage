package com.easycloudstorage.pojo;

import com.easycloudstorage.service.filemodule.FileService;
import com.easycloudstorage.service.organizationmodule.AuthorityService;
import com.easycloudstorage.service.organizationmodule.OrganizationService;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.Date;

public class FileManager {

    public static boolean uploadFiles(MultipartFile[] files, HttpServletRequest request, FileService fileService,
                                      AuthorityService authorityService, OrganizationService organizationService){
        boolean flag=true;
        for (MultipartFile file:files) {
            boolean result=uploadOneFile(file, request, fileService, authorityService, organizationService);
            flag &=  result;
        }

        return flag;
    }

    public static String changeName(File parentDir,String str) {
        int i=1;
        int indexOfDot=str.lastIndexOf('.');
        int indexOfNum;
        if (indexOfDot==-1) {
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
                postFix="B";
                break;
            case 1:
                postFix="KB";
                break;
            case 2:
                postFix="MB";
                break;
            case 3:
                postFix="G";
                break;
            default:
                postFix="";
                break;
        }
        return size+postFix;
    }

    public static boolean uploadOneFile(MultipartFile file, HttpServletRequest request, FileService fileService,
                                        AuthorityService authorityService, OrganizationService organizationService) {

        String name=file.getOriginalFilename();
        HttpSession session=request.getSession();
        Directory dir=(Directory) session.getAttribute("currentDir");
        com.easycloudstorage.pojo.NormalFile uploadFile=new com.easycloudstorage.pojo.NormalFile();

        String size=changeSize(file.getSize());
        uploadFile.setSize(size);
        uploadFile.setType(file.getContentType());
        uploadFile.setLastMovedTime(new Date());
        uploadFile.setOwnerId(dir.getOwnerId());
        uploadFile.setOrgId(dir.getOrgId());
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

            /*如果是组织文件上传，那么需要插入对应的权限*/
            if(uploadFile.getOrgId() != null) {
                User user = (User) session.getAttribute("user");
                NorFileAuthority norFileAuthority = new NorFileAuthority();
                norFileAuthority.setFileId(uploadFile.getFileId());
                norFileAuthority.setAccountId(user.getAccountId());
                norFileAuthority.setAuthority(Authority.VISIBLE_DOWNLOADABLE_EDITABLE);
                norFileAuthority.setOrgId(uploadFile.getOrgId());
                authorityService.addNorFileAuthority(norFileAuthority);

                /*如果当前用户不是组织拥有者，那么需要给拥有者加上权限*/
                String ownerId = organizationService.getOwnerId(uploadFile.getOrgId());
                if(!ownerId.equals(user.getAccountId())) {
                    norFileAuthority.setAccountId(ownerId);
                    authorityService.addNorFileAuthority(norFileAuthority);
                }
            }

            file.transferTo(temp);
        } catch (Exception e){
            e.printStackTrace();
            return false;
        }
        return true;  //上传成功则跳转至此success.jsp页
    }


}
