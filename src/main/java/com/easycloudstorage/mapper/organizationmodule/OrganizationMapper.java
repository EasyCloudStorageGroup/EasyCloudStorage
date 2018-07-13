package com.easycloudstorage.mapper.organizationmodule;

import com.easycloudstorage.pojo.*;

import java.util.List;

public interface OrganizationMapper {
    Organization getByOrgId(int orgId);

    List<Organization> orgList();

    void addOrg(Organization org);//增加组织

    void deleteOrg(int orgId);//删除组织

    int isMember(String accountId, int orgId);//是否为组织内成员

    void addDir(Directory directory);//为每一个组织生成一个文件管理的根目录

    Organization getOrgByName(String name);//根据name来查找org对象

    void addMember(String accountId,int orgId);//往组织内添加成员

    void removeMember(String accountId,int orgId);//将用户踢出组织

    int isUser(String accountId);//添加成员进入组织时需要判断该Id是否存在用户

//下面是group部分,功能类似

    List<Group> groupList();

    void addGroup(Group group);//新建分组

    void deleteGroup(int groupId);//删除分组

    Group getByGroupId(int groupId);//根据ID查找分组

    Group getGroupByName(String  name);//根据name获得对象

    void distributeMember(String accountId,int groupId);//往分组内分配成员

    void removeGpMember(String accountId,int groupId);//将组员移出该分组

    /*得到组织拥有者id*/
    String getOwnerId(Integer orgId);
}
