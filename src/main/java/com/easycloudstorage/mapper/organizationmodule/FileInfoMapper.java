package com.easycloudstorage.mapper.organizationmodule;

import com.easycloudstorage.pojo.DirAuthority;
import com.easycloudstorage.pojo.Directory;
import com.easycloudstorage.pojo.NorFileAuthority;
import com.easycloudstorage.pojo.NormalFile;

public interface FileInfoMapper {
    NormalFile getNormalFile(int fileId);
    NorFileAuthority getNorAuthority(int fileId,String accountId);
    Directory getDirectory(int fileId);
    DirAuthority getDirAuthority(int fileId, String accountId);
}
