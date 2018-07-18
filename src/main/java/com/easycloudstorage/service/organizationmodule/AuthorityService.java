package com.easycloudstorage.service.organizationmodule;

import com.easycloudstorage.mapper.filemodule.FileMapper;
import com.easycloudstorage.mapper.filemodule.ShowMapper;
import com.easycloudstorage.mapper.organizationmodule.AuthorityMapper;
import com.easycloudstorage.pojo.*;
import com.easycloudstorage.service.filemodule.ShowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AuthorityService {
    @Autowired
        private AuthorityMapper authorityMapper;
        @Autowired
        private ShowService showService;

        public void addNorFileAuthority(NorFileAuthority norFileAuthority) {
            authorityMapper.addNorFileAuthority(norFileAuthority);
        }

        public void addDirAuthority(DirAuthority dirAuthority) {
            authorityMapper.addDirAuthority(dirAuthority);
    }

    /*权限管理*/

    public List<NorFileAuthority> norList(){
        List<NorFileAuthority> result=new ArrayList<NorFileAuthority>();
        NorFileAuthority temp;
        for(int i=0;i<authorityMapper.norAuthority().size();i++)
        {temp=authorityMapper.norAuthority().get(i);
            Integer fileId=temp.getFileId();
            NormalFile normalFile=showService.findNormalFileById(fileId,showService.normalFileList());
            temp.setNormalFile(normalFile);
            result.add(temp);
        }
        return result;}

    public List<DirAuthority> dirAuthorityList(){{
        List<DirAuthority> result=new ArrayList<DirAuthority>();
        DirAuthority temp;
        for(int i=0;i<authorityMapper.dirAuthority().size();i++)
        {temp=authorityMapper.dirAuthority().get(i);
            Integer fileId=temp.getDirId();
            Directory directory=showService.findDirectoryById(fileId,showService.directoryList());
            temp.setDirectory(directory);
            result.add(temp);
        }
        return result;}}

    public void updateNorAuthority(NorFileAuthority norFileAuthority){authorityMapper.updateNorAutuority(norFileAuthority);}

    public void updateDirAuthority(DirAuthority dirAuthority){authorityMapper.updateDirAutuority(dirAuthority);}

    public void insertNorAuthority(NorFileAuthority norFileAuthority){authorityMapper.insertNorAuthority(norFileAuthority);}

    public void insertDirAuthority(DirAuthority dirAuthority){authorityMapper.insertDirAuthority(dirAuthority);}

    public List<NorFileAuthority> findFileAuthority(String accountId,int orgId,List<NorFileAuthority> norList){
        List<NorFileAuthority> norFileAuthorityList=new ArrayList<NorFileAuthority>();
        NorFileAuthority temp;
        for(int i=0;i<norList.size();i++) {
            temp = norList.get(i);
            if(temp!=null&&temp.getAccountId().equals(accountId)&&temp.getOrgId().equals(orgId))
            norFileAuthorityList.add(temp);
        }
        return norFileAuthorityList;
    }

    public List<DirAuthority> findDirAuthority(String accountId,int orgId,List<DirAuthority> dirAuthorityList){
        List<DirAuthority> result=new ArrayList<DirAuthority>();
        DirAuthority temp;
        for(int i=0;i<dirAuthorityList.size();i++) {
            temp = dirAuthorityList.get(i);
            if(temp!=null&&temp.getAccountId().equals(accountId)&&temp.getOrgId().equals(orgId))
                result.add(temp);
        }
        return result;
    }
}
