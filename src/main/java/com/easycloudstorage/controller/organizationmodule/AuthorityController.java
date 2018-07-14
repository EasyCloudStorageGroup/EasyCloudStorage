package com.easycloudstorage.controller.organizationmodule;

import com.easycloudstorage.pojo.NorFileAuthority;
import com.easycloudstorage.pojo.DirAuthority;
import com.easycloudstorage.service.organizationmodule.AuthorityService;
import com.easycloudstorage.service.organizationmodule.OrganizationService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestBody;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Controller
public class AuthorityController {
    @Autowired
    private AuthorityService authorityService;

    @RequestMapping(value = "authorityManage",method = {RequestMethod.POST})
    public String authorityManage(@RequestBody String[] userArray,HttpSession session) throws IOException{
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

        //为用户新选择的文件权限构建List<Authority>
        List<NorFileAuthority> newNorAuthority=new ArrayList<>();
        NorFileAuthority norTemp=new NorFileAuthority();
        for(int i=0;i<(userArray.length-1);i++){
            for(int j=0;j<1;j++) {
                norTemp.setAccountId(userArray[i]);
                norTemp.setAuthority(authority);
                norTemp.setOrgId(orgId);
                norTemp.setFileId(441);
                newNorAuthority.add(norTemp);
            }
        }

        //为用户新选择的目录权限构建List<Authority>
        List<DirAuthority> newDirAuthority=new ArrayList<>();
        DirAuthority dirTemp=new DirAuthority();
        for(int i=0;i<(userArray.length-1);i++){
            for(int j=0;j<1;j++) {
                dirTemp.setAccountId(userArray[i]);
                dirTemp.setAuthority(authority);
                dirTemp.setOrgId(orgId);
                dirTemp.setDirId(234);
                newDirAuthority.add(dirTemp);
            }
        }

        //比较新的为用户选择的目录的权限是否在数据库已经存在，如果已经存在则update，否则就insert
        for(int i=0;i<newDirAuthority.size();i++){
            for(int j=0;j<dirAuthority.size();j++){
                if((newDirAuthority.get(i).getAccountId().equals(dirAuthority.get(j).getAccountId()))&&
                        (newDirAuthority.get(i).getDirId()==dirAuthority.get(j).getDirId())&&(newDirAuthority.get(i).getOrgId()==dirAuthority.get(j).getOrgId())){
                    //NorFileAuthority test=newNorAuthority.get(i);
                    authorityService.updateDirAuthority(newDirAuthority.get(i));
                }
                else {
                    //NorFileAuthority test=newNorAuthority.get(i);
                    authorityService.insertDirAuthority(newDirAuthority.get(i));
                }
            }
        }

        //比较新的为用户选择的文件的权限是否在数据库已经存在，如果已经存在则update，否则就insert
        for(int i=0;i<newNorAuthority.size();i++){
            for(int j=0;j<norAuthority.size();j++){
                if((newNorAuthority.get(i).getAccountId().equals(norAuthority.get(j).getAccountId()))&&
                        (newNorAuthority.get(i).getFileId()==norAuthority.get(j).getFileId())&&(newNorAuthority.get(i).getOrgId()==norAuthority.get(j).getOrgId())){
                    authorityService.updateNorAuthority(newNorAuthority.get(i));
                }
                else {
                    authorityService.insertNorAuthority(newNorAuthority.get(i));
                }
            }
        }

        return "redirect:enterOrganization";
    }

}
