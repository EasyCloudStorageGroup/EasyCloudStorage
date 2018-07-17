package com.easycloudstorage.pojo;

import java.util.List;

public class DirAuthority extends Authority {
    private Integer dirId;

    private Directory directory;

    public Integer getDirId() {
        return dirId;
    }

    public void setDirId(Integer dirId) {
        this.dirId = dirId;
    }

    public Directory getDirectory() {
        return directory;
    }

    public void setDirectory(Directory directory) {
        this.directory = directory;
    }
}
