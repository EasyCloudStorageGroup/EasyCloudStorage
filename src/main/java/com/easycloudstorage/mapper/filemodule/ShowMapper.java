package com.easycloudstorage.mapper.filemodule;

import com.easycloudstorage.pojo.Directory;
import com.easycloudstorage.pojo.NormalFile;

import java.util.List;

public interface ShowMapper {
    List<NormalFile> normalFileList();
    List<Directory> directoryList();
}