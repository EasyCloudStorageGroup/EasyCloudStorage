package com.easycloudstorage.mapper.organizationmodule;

import com.easycloudstorage.pojo.DirAuthority;
import com.easycloudstorage.pojo.NorFileAuthority;

public interface AuthorityMapper {
    void addNorFileAuthority(NorFileAuthority norFileAuthority);

    void addDirAuthority(DirAuthority dirAuthority);
}
