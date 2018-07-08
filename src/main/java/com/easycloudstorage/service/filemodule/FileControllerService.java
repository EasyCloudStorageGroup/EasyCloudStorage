package com.easycloudstorage.service.filemodule;

import  com.easycloudstorage.mapper.filemodule.FileControllerMapper;
import com.easycloudstorage.pojo.NormalFile;
import com.easycloudstorage.pojo.Directory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FileControllerService {
    @Autowired
    private FileControllerMapper fileControllerMapper;

    public NormalFile selectNormalFile(String fileId)
    {
        return fileControllerMapper.selectNormalFile(fileId);
    }

    public List<NormalFile> selectAllNormalFile()
    {
        return fileControllerMapper.selectAllNormalFiles();
    }

    public Directory selectDirectory(String dirId)
    {
        return fileControllerMapper.selectDirectory(dirId);
    }

    public List<Directory> selectAllDirectories()
    {
        return fileControllerMapper.selectAllDirectories();
    }

    public void updateNormalFile(NormalFile normalFile)
    {
        fileControllerMapper.updateNormalFile(normalFile);
    }

    public void updateDirectory(Directory directory)
    {
        fileControllerMapper.updateDirectory(directory);
    }

    public void deleteNormalFile(NormalFile normalFile)
    {
        fileControllerMapper.deleteNormalFile(normalFile);
    }

    public void deleteDirectory(Directory directory)
    {
        fileControllerMapper.deleteDirectory(directory);
    }

    public void newDirectory(Directory directory)
    {
        fileControllerMapper.newDirectory(directory);
    }
}
