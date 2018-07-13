package com.easycloudstorage.pojo;

public class Authority {
    private String accountId;
    private Integer orgId;
    private int authority;

    public static int VISIBLE_DOWNLOADABLE = 1;
    public static int VISIBLE_EDITABLE = 2;
    public static int VISIBLE_NEWABLE = 3;

    public static int VISIBLE_DOWNLOADABLE_EDITABLE = 4;        //文件最高权限
    public static int VISIBLE_EDITABLE_NEWABLE = 5;             //文件夹最高权限

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public Integer getOrgId() {
        return orgId;
    }

    public void setOrgId(Integer orgId) {
        this.orgId = orgId;
    }

    public int getAuthority() {
        return authority;
    }

    public void setAuthority(int authority) {
        this.authority = authority;
    }

    public boolean isDownloadable() {
        if(authority == VISIBLE_DOWNLOADABLE || authority == VISIBLE_DOWNLOADABLE_EDITABLE)
            return true;
        else
            return false;
    }

    public boolean isEditable() {
        if(authority == VISIBLE_EDITABLE || authority == VISIBLE_EDITABLE_NEWABLE
                || authority == VISIBLE_DOWNLOADABLE_EDITABLE)
            return true;
        else
            return false;
    }

    public boolean isNewable() {
        if(authority == VISIBLE_NEWABLE || authority == VISIBLE_EDITABLE_NEWABLE)
            return true;
        else
            return false;
    }
}
