package com.easycloudstorage.mapper.organizationmodule;

import com.easycloudstorage.pojo.Organization;

public interface OrganizationMapper {
    Organization getByOrgId(int orgId);

    int isMember(String accountId, int orgId);
}
