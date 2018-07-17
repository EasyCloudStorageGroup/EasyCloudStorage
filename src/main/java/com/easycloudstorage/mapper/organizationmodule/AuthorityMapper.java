package com.easycloudstorage.mapper.organizationmodule;

import com.easycloudstorage.pojo.DirAuthority;
import com.easycloudstorage.pojo.NorFileAuthority;

import java.util.List;

public interface AuthorityMapper {
    void addNorFileAuthority(NorFileAuthority norFileAuthority);

    void addDirAuthority(DirAuthority dirAuthority);

    /*权限管理*/
    List<NorFileAuthority> norAuthority();

    void updateNorAutuority(NorFileAuthority norFileAuthority);

    void insertNorAuthority(NorFileAuthority norFileAuthority);

    List<DirAuthority> dirAuthority();

    void updateDirAutuority(DirAuthority dirAuthority);

    void insertDirAuthority(DirAuthority dirAuthority);

    NorFileAuthority getNorFileAuthority(Integer fileId,String accountId);
}
