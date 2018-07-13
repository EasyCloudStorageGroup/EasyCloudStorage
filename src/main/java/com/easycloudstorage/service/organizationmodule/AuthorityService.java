package com.easycloudstorage.service.organizationmodule;

import com.easycloudstorage.mapper.organizationmodule.AuthorityMapper;
import com.easycloudstorage.pojo.NorFileAuthority;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AuthorityService {
    @Autowired
    private AuthorityMapper authorityMapper;

    public void addNorFileAuthority(NorFileAuthority norFileAuthority) {
        authorityMapper.addNorFileAuthority(norFileAuthority);
    }
}
