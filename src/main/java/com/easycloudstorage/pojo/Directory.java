package com.easycloudstorage.pojo;

import java.util.ArrayList;
import java.util.List;

public class Directory extends File {
    private Integer dirId;
    private DirAuthority dirAuthority;
    private List<Directory> childDirectories = new ArrayList<>();
    private List<NormalFile> childNorFiles = new ArrayList<>();

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

    public List<Directory> getChildDirectories() {
        return childDirectories;
    }

    public void setChildDirectories(List<Directory> childDirectories) {
        this.childDirectories = childDirectories;
    }

    public List<NormalFile> getChildNorFiles() {
        return childNorFiles;
    }

    public void setChildNorFiles(List<NormalFile> childNorFiles) {
        this.childNorFiles = childNorFiles;
    }
}
