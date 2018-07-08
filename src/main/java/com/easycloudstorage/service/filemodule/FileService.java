package com.easycloudstorage.service.filemodule;

import com.easycloudstorage.mapper.filemodule.FileMapper;
import com.easycloudstorage.pojo.NormalFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FileService {
    @Autowired
    private FileMapper fileMapper;
    public void insertFile(NormalFile file){
        fileMapper.insertFile(file);
    }

}
