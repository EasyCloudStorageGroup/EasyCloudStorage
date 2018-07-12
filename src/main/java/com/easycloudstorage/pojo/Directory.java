package com.easycloudstorage.pojo;

import java.util.ArrayList;
import java.util.List;

public class Directory extends File {
    private Integer dirId;
    private DirAuthority dirAuthority;
    private List<File> childFiles = new ArrayList<>();

    public Integer getDirId() {
        return dirId;
    }

    public void setDirId(Integer dirId) {
        this.dirId = dirId;
    }

    public DirAuthority getDirAuthority() {
        return dirAuthority;
    }

    public void setDirAuthority(DirAuthority dirAuthority) {
        this.dirAuthority = dirAuthority;
    }

    public List<File> getChildFiles() {
        return childFiles;
    }

    public void setChildFiles(List<File> childFiles) {
        this.childFiles = childFiles;
    }
}
