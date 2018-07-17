package com.easycloudstorage.service.organizationmodule;

import com.easycloudstorage.mapper.organizationmodule.AuthorityMapper;
import com.easycloudstorage.pojo.DirAuthority;
import com.easycloudstorage.pojo.NorFileAuthority;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AuthorityService {
    @Autowired
    private AuthorityMapper authorityMapper;

    public void addNorFileAuthority(NorFileAuthority norFileAuthority) {
        authorityMapper.addNorFileAuthority(norFileAuthority);
    }

    public void addDirAuthority(DirAuthority dirAuthority) {
        authorityMapper.addDirAuthority(dirAuthority);
    }

    /*权限管理*/

    public List<NorFileAuthority> norList(){return authorityMapper.norAuthority();}

    public List<DirAuthority> dirAuthorityList(){return authorityMapper.dirAuthority();}

    public void updateNorAuthority(NorFileAuthority norFileAuthority){authorityMapper.updateNorAutuority(norFileAuthority);}

    public void updateDirAuthority(DirAuthority dirAuthority){authorityMapper.updateDirAutuority(dirAuthority);}

    public void insertNorAuthority(NorFileAuthority norFileAuthority){authorityMapper.insertNorAuthority(norFileAuthority);}

    public void insertDirAuthority(DirAuthority dirAuthority){authorityMapper.insertDirAuthority(dirAuthority);}
}
