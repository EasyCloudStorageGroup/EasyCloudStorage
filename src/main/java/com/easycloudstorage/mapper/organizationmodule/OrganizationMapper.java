package com.easycloudstorage.mapper.organizationmodule;

import com.easycloudstorage.pojo.Directory;
import com.easycloudstorage.pojo.File;
import com.easycloudstorage.pojo.Organization;

import java.util.List;

public interface OrganizationMapper {
    Organization getByOrgId(int orgId);

    List<Organization> orgList();

    void addOrg(Organization org);

    int isMember(String accountId, int orgId);

    void addDir(Directory directory);

    Organization getOrgByName(String name);
}
