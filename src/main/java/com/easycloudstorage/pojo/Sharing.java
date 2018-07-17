package com.easycloudstorage.pojo;

public class Sharing {
    private String str;
    private Integer fileId;
    private String password;

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setStr(String str) {
        this.str = str;
    }

    public int getFileId() {

        return fileId;
    }

    public void setFileId(Integer fileId) {
        this.fileId = fileId;
    }

    public String getStr() {

        return str;
    }
}
