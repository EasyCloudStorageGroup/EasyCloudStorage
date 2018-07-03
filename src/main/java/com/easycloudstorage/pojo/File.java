package com.easycloudstorage.pojo;

import java.util.Date;

public class File {
    private String name;
    private Date lastMovedTime;
    private String realPath;
    private String parentDirId;
    private String ownerId;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getLastMovedTime() {
        return lastMovedTime;
    }

    public void setLastMovedTime(Date lastMovedTime) {
        this.lastMovedTime = lastMovedTime;
    }

    public String getRealPath() {
        return realPath;
    }

    public void setRealPath(String realPath) {
        this.realPath = realPath;
    }

    public String getParentDirId() {
        return parentDirId;
    }

    public void setParentDirId(String parentDirId) {
        this.parentDirId = parentDirId;
    }

    public String getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(String ownerId) {
        this.ownerId = ownerId;
    }
}
