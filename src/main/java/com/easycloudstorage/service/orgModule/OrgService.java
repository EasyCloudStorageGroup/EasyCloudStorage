package com.easycloudstorage.service.orgModule;

import com.easycloudstorage.mapper.orgModule.OrgMapper;
import com.easycloudstorage.pojo.Organization;
import com.easycloudstorage.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrgService {
    @Autowired
    private OrgMapper orgMapper;
    public List<Organization> orgList(User user) {
        return orgMapper.orgList(user);
    }
}