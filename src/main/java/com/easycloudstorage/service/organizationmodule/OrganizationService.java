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
        List<Group> groups = organizationMapper.getGroupsByOrgId(orgId);
        organization.setGroups(groups);
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
        else if(type.equals("all")){
            for (int i = 0; i < organizationList.size(); i++) {
                tem = organizationList.get(i);
                if ((organizationMapper.isMember(user.getAccountId(),tem.getOrgId()))>0)
                    result.add(tem);
            }
        }
        else {
            for (int i = 0; i < organizationList.size(); i++) {
                tem = organizationList.get(i);
                if ((organizationMapper.isMember(user.getAccountId(),tem.getOrgId()))>0)
                    if(!tem.getOwnerId().equals(user.getAccountId()))
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

    public void changeName(int orgId,String newName){
        organizationMapper.changeName(orgId,newName);
    }

    public void changeDescription(int orgId,String newDes){
        organizationMapper.changeDescription(orgId,newDes);
    }

    public void changeGroupName(int groupId,String newName){organizationMapper.changeGroupName(groupId,newName);};

    public void changeGroupDescription(int groupId,String newDescription){
        organizationMapper.changeGroupDescription(groupId,newDescription);
    };

    public boolean checkOwner(String userId,int orgId){
        String ownerId=organizationMapper.getOwnerId(orgId);
        return ownerId.equals(userId);
    }

    public List<Group> getGroupByOrgId(int orgId){
        return organizationMapper.getGroupByOrgId(orgId);
    }

    public List<User> getUsersByGroupId(int groupId){return organizationMapper.getUsersByGroupId(groupId);}

}
