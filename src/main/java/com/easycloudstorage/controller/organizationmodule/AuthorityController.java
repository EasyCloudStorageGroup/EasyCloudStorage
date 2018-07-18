package com.easycloudstorage.controller.organizationmodule;

import com.easycloudstorage.pojo.*;
import com.easycloudstorage.service.organizationmodule.AuthorityService;
import com.easycloudstorage.service.organizationmodule.OrganizationService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class AuthorityController {
    @Autowired
    private AuthorityService authorityService;

    @RequestMapping(value = "authorityManage",method = {RequestMethod.POST})
    public String authorityManage(@RequestBody String[][] data,
                                  HttpSession session) throws IOException{
        String[] userArray = data[0];
        String[] norFileIds = data[1];
        String[] dirIds = data[2];

        //userArray最后一个字符串为所选权限
        int orgId=(int)session.getAttribute("orgId");
        int authority=Integer.parseInt(userArray[userArray.length-1]);
        //String[] norTemp=dirArray;

        //数据库中已存在的普通文件的权限数据
        List<NorFileAuthority> norAuthority=new ArrayList<>();
        norAuthority=authorityService.norList();
        //数据库中已存在的目录的权限数据
        List<DirAuthority> dirAuthority=new ArrayList<>();
        dirAuthority=authorityService.dirAuthorityList();
        session.setAttribute("norAuthority",norAuthority);
        session.setAttribute("dirAuthority",dirAuthority);

        //为用户新选择的文件权限构建List<Authority>
        List<NorFileAuthority> newNorAuthority=new ArrayList<>();
        for(int i=0;i<(userArray.length-1);i++){
            for(int j=0;j<norFileIds.length;j++) {
                NorFileAuthority norTemp=new NorFileAuthority();
                norTemp.setAccountId(userArray[i]);
                norTemp.setAuthority(authority);
                norTemp.setOrgId(orgId);
                norTemp.setFileId(Integer.parseInt(norFileIds[j]));
                newNorAuthority.add(norTemp);
            }
        }

        //为用户新选择的目录权限构建List<Authority>
        List<DirAuthority> newDirAuthority=new ArrayList<>();
        for(int i=0;i<(userArray.length-1);i++){
            for(int j=0;j<dirIds.length;j++) {
                DirAuthority dirTemp=new DirAuthority();
                dirTemp.setAccountId(userArray[i]);
                dirTemp.setAuthority(authority);
                dirTemp.setOrgId(orgId);
                dirTemp.setDirId(Integer.parseInt(dirIds[j]));
                newDirAuthority.add(dirTemp);
            }
        }

        //比较新的为用户选择的目录的权限是否在数据库已经存在，如果已经存在则update，否则就insert
        for(int i=0;i<newDirAuthority.size();i++){
            boolean isUpdated = false;
            for(int j=0;j<dirAuthority.size();j++){
                if((newDirAuthority.get(i).getAccountId().equals(dirAuthority.get(j).getAccountId()))&&
                        (newDirAuthority.get(i).getDirId().equals(dirAuthority.get(j).getDirId()))&&(newDirAuthority.get(i).getOrgId().equals(dirAuthority.get(j).getOrgId()))){
                    //NorFileAuthority test=newNorAuthority.get(i);
                    authorityService.updateDirAuthority(newDirAuthority.get(i));
                    isUpdated = true;
                }
            }
            if(isUpdated == false)
                authorityService.insertDirAuthority(newDirAuthority.get(i));
        }

        //比较新的为用户选择的文件的权限是否在数据库已经存在，如果已经存在则update，否则就insert
        for(int i=0;i<newNorAuthority.size();i++){
            boolean isUpdated = false;
            for(int j=0;j<norAuthority.size();j++){
                if((newNorAuthority.get(i).getAccountId().equals(norAuthority.get(j).getAccountId()))&&
                        (newNorAuthority.get(i).getFileId().equals(norAuthority.get(j).getFileId()))&&(newNorAuthority.get(i).getOrgId().equals(norAuthority.get(j).getOrgId()))){
                    authorityService.updateNorAuthority(newNorAuthority.get(i));
                    isUpdated = true;
                }
            }
            if(isUpdated == false)
                authorityService.insertNorAuthority(newNorAuthority.get(i));
        }

        return "redirect:orgHomePage";
    }
    @RequestMapping("authorityShow")
    public String authorityShow(HttpSession session,String userId){
      int orgId=(int)session.getAttribute("orgId");
      List<NorFileAuthority> norFileAuthorityList=authorityService.findFileAuthority(userId,orgId,authorityService.norList());
      List<DirAuthority> dirAuthorityList=authorityService.findDirAuthority(userId,orgId,authorityService.dirAuthorityList());
      session.setAttribute("norFileAuthorityList",norFileAuthorityList);
      session.setAttribute("dirAuthorityList",dirAuthorityList);
      return "redirect:orgHomePage";
    }
}