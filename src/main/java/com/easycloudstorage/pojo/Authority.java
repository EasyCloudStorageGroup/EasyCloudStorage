package com.easycloudstorage.pojo;

public class Authority {
    private String accountId;
    private int orgId;
    private int authority;

    public static int VISIBLE = 1;

    public static int VISIBLE_DOWNLOADABLE = 2;
    public static int VISIBLE_EDITABLE = 3;
    public static int VISIBLE_NEWABLE = 4;

    public static int VISIBLE_DOWNLOADABLE_EDITABLE = 5;
    public static int VISIBLE_DOWNLOADABLE_NEWABLE = 6;
    public static int VISIBLE_EDITABLE_NEWABLE = 7;
    public static int VISIBLE_DOWNLOADABLE_EDITABLE_NEWABLE = 8;

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public int getOrgId() {
        return orgId;
    }

    public void setOrgId(int orgId) {
        this.orgId = orgId;
    }

    public int getAuthority() {
        return authority;
    }

    public void setAuthority(int authority) {
        this.authority = authority;
    }
}
