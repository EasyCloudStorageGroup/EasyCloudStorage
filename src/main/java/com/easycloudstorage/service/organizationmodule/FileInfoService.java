package com.easycloudstorage.service.organizationmodule;

import com.easycloudstorage.mapper.organizationmodule.FileInfoMapper;
import com.easycloudstorage.pojo.DirAuthority;
import com.easycloudstorage.pojo.Directory;
import com.easycloudstorage.pojo.NorFileAuthority;
import com.easycloudstorage.pojo.NormalFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FileInfoService {
    @Autowired
    private FileInfoMapper fileInfoMapper;

    public NormalFile getNormalFile(int fileId){
        return  fileInfoMapper.getNormalFile(fileId);
    }

    public NorFileAuthority getNorAuthority(int fileId,String accountId){
        return fileInfoMapper.getNorAuthority(fileId,accountId);
    }

    public Directory getDirectory(int fileId){
        return  fileInfoMapper.getDirectory(fileId);
    }

    public DirAuthority getDirAuthority(int fileId, String accountId){
        return fileInfoMapper.getDirAuthority(fileId,accountId);
    }
}
