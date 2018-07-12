package com.easycloudstorage.service.organizationmodule;

import com.easycloudstorage.mapper.organizationmodule.OrganizationMapper;
import com.easycloudstorage.pojo.*;
import org.aspectj.weaver.ast.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class OrganizationService {
    @Autowired
    private OrganizationMapper organizationMapper;

    public List<Organization> list(){return organizationMapper.orgList();}

    public void addOrg(Organization org){organizationMapper.addOrg(org); }

    public Organization getByOrgId(int orgId) {
        Organization organization = organizationMapper.getByOrgId(orgId);
        organization.setUnGroupedMembers(getUnGroupedMembers(organization));

        return organization;
    }
    public Organization getOrgByName(String name){return organizationMapper.getOrgByName(name);}

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

    public void addDir(Directory file){organizationMapper.addDir(file);}

    public boolean isMember(String accountId, int orgId) {
        if(organizationMapper.isMember(accountId, orgId) > 0)
            return true;
        else
            return false;
    }
}
