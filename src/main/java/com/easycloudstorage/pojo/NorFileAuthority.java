package com.easycloudstorage.pojo;

public class NorFileAuthority extends Authority {
    private Integer fileId;

    private NormalFile normalFile;

    public Integer getFileId() {
        return fileId;
    }

    public void setFileId(Integer fileId) {
        this.fileId = fileId;
    }

    public NormalFile getNormalFile() {
        return normalFile;
    }

    public void setNormalFile(NormalFile normalFile) {
        this.normalFile = normalFile;
    }
}