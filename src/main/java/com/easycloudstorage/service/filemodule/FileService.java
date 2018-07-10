package com.easycloudstorage.service.filemodule;

import com.easycloudstorage.mapper.filemodule.FileMapper;
import com.easycloudstorage.pojo.Directory;
import com.easycloudstorage.pojo.NormalFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FileService {
    @Autowired
    private FileMapper fileMapper;

    public void insertFile(NormalFile file){
        fileMapper.insertFile(file);
    }

    public NormalFile selectNormalFile(int fileId)
    {
        return fileMapper.selectNormalFile(fileId);
    }

    public List<NormalFile> selectAllNormalFile()
    {
        return fileMapper.selectAllNormalFiles();
    }

    public Directory selectDirectory(int dirId)
    {
        return fileMapper.selectDirectory(dirId);
    }

    public List<Directory> selectAllDirectories()
    {
        return fileMapper.selectAllDirectories();
    }

    public void updateNormalFile(NormalFile normalFile)
    {
        fileMapper.updateNormalFile(normalFile);
    }

    public void updateDirectory(Directory directory)
    {
        fileMapper.updateDirectory(directory);
    }

    public void deleteNormalFile(NormalFile normalFile)
    {
        fileMapper.deleteNormalFile(normalFile);
    }

    public void deleteDirectory(Directory directory)
    {
        fileMapper.deleteDirectory(directory);
    }

    public void newDirectory(Directory directory)
    {
        fileMapper.newDirectory(directory);
    }
}
