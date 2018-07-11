package com.easycloudstorage.service.organizationmodule;

import com.easycloudstorage.mapper.organizationmodule.OrganizationMapper;
import com.easycloudstorage.pojo.Organization;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrganizationService {
    @Autowired
    private OrganizationMapper organizationMapper;

    public Organization getByOrgId(int orgId) {
        return organizationMapper.getByOrgId(orgId);
    }
}
