package com.easycloudstorage.service.organizationmodule;

import com.easycloudstorage.mapper.organizationmodule.OrganizationMapper;
import com.easycloudstorage.pojo.Group;
import com.easycloudstorage.pojo.Organization;
import com.easycloudstorage.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class OrganizationService {
    @Autowired
    private OrganizationMapper organizationMapper;

    public Organization getByOrgId(int orgId) {
        Organization organization = organizationMapper.getByOrgId(orgId);
        organization.setUnGroupedMembers(getUnGroupedMembers(organization));

        return organization;
    }

    public List<User> getUnGroupedMembers(Organization organization) {
        List<User> unGroupedMembers = new ArrayList<>();

        for(User member : organization.getMembers()) {
            boolean isGrouped = false;
            for(Group group : organization.getGroups()) {
                for(User gMember : group.getMembers()) {
                    if(gMember.getAccountId().equals(member.getAccountId()))
                        isGrouped = true;
                }
            }

            if(!isGrouped)
                unGroupedMembers.add(member);
        }

        return unGroupedMembers;
    }
}
