package com.easycloudstorage.pojo;

import java.util.List;

public class Organization {
    private int orgId;
    private String name;
    private String description;
    private String ownerId;
    private List<User> members;
    private List<Group> groups;
    private List<User> unGroupedMembers;

    public int getOrgId() {
        return orgId;
    }

    public void setOrgId(int orgId) {
        this.orgId = orgId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(String ownerId) {
        this.ownerId = ownerId;
    }

    public List<User> getMembers() {
        return members;
    }

    public void setMembers(List<User> members) {
        this.members = members;
    }

    public List<Group> getGroups() {
        return groups;
    }

    public void setGroups(List<Group> groups) {
        this.groups = groups;
    }

    public List<User> getUnGroupedMembers() {
        return unGroupedMembers;
    }

    public void setUnGroupedMembers(List<User> unGroupedMembers) {
        this.unGroupedMembers = unGroupedMembers;
    }
}
