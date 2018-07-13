package com.easycloudstorage.mapper.filemodule;

import com.easycloudstorage.pojo.Directory;
import com.easycloudstorage.pojo.File;
import com.easycloudstorage.pojo.NormalFile;

import java.util.List;

public interface FileMapper {
    void insertFile(NormalFile file);

    NormalFile selectNormalFile(int fileId);

    List<NormalFile> selectAllNormalFiles();

    Directory selectDirectory(int dirId);

    List<Directory> selectAllDirectories();

    void updateNormalFile(NormalFile normalFile);

    void updateDirectory(Directory directory);

    void deleteNormalFile(NormalFile normalFile);

    void deleteDirectory(Directory directory);

    void newDirectory(Directory directory);

    //组织模块
    List<Directory> getVisibleDirectories(String accountId, int orgId);

    List<NormalFile> getVisibleNorFiles(String accountId, int orgId);
}
