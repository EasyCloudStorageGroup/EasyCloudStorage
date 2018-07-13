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

    public Organization getByOrgId(int orgId) {
        Organization organization = organizationMapper.getByOrgId(orgId);
        organization.setUnGroupedMembers(getUnGroupedMembers(organization));

        return organization;
    }

    public List<Organization> list(){return organizationMapper.orgList();}

    public void addOrg(Organization org){organizationMapper.addOrg(org); }

    public void deleteOrg(int orgId){organizationMapper.deleteOrg(orgId);}

    public List<Organization> findMyOrgByType(User user, List<Organization> organizationList,String type){
        Organization tem=new Organization();
        List<Organization> result=new ArrayList<Organization>();
        if(type.equals("owner")) {
            for (int i = 0; i < organizationList.size(); i++) {
                tem = organizationList.get(i);
                if (tem.getOwnerId().equals(user.getAccountId()))
                    result.add(tem);
            }
        }
        else {
            for (int i = 0; i < organizationList.size(); i++) {
                tem = organizationList.get(i);
                if ((organizationMapper.isMember(user.getAccountId(),tem.getOrgId()))>0)
                    result.add(tem);
            }
        }
        return result;
    }

    public boolean isMember(String accountId, int orgId) {
        if(organizationMapper.isMember(accountId, orgId) > 0)
            return true;
        else
            return false;
    }

    public void addDir(Directory file){organizationMapper.addDir(file);}

    public Organization getOrgByName(String name){return organizationMapper.getOrgByName(name);}

    public void addMember(String accountId,int orgId){organizationMapper.addMember(accountId,orgId);}

    public void removeMember(String accountId,int orgId){organizationMapper.removeMember(accountId,orgId);}

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

    public boolean isUser(String accountId){
        if(organizationMapper.isUser(accountId)>0)
             return true;
        else
            return false;
    }

    public List<Group> groupList(){return organizationMapper.groupList();}

    public void addGroup(Group group){organizationMapper.addGroup(group);}

    public void deleteGroup(int groupId){organizationMapper.deleteGroup(groupId);}

    public Group getByGroupId(int groupId){return organizationMapper.getByGroupId(groupId);}

    public Group getGroupByName(String  name){return organizationMapper.getGroupByName(name);}

    public void distributeMember(String accountId,int groupId){organizationMapper.distributeMember(accountId,groupId);}

    public void removeGpMember(String accountId,int groupId){organizationMapper.removeGpMember(accountId,groupId);}

    public String getOwnerId(Integer orgId) {
        return organizationMapper.getOwnerId(orgId);
    }
}
