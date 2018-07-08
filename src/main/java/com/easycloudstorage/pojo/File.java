package com.easycloudstorage.pojo;

import java.text.SimpleDateFormat;
import java.util.Date;

public class File {
    private String name;
    private Date lastMovedTime;
    private String realPath;
    private String parentDirId;
    private String ownerId;
    private String displayTime;

    public void setDisplayTime(){
     if(lastMovedTime!=null){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        displayTime=sdf.format(lastMovedTime);}

    }

    public String getDisplayTime(){return displayTime;}

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
