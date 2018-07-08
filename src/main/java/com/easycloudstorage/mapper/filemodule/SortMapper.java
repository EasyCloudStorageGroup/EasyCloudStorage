package com.easycloudstorage.mapper.filemodule;

import com.easycloudstorage.pojo.NormalFile;
import com.easycloudstorage.pojo.User;

import java.util.List;

public interface SortMapper {
    List<NormalFile> normalFileList(User user);
}
