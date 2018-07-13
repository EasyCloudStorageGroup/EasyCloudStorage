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

    //组织模块
    public Directory makeVisibleFileSys(String accountId, int orgId) {
        List<Directory> visibleDirectories = fileMapper.getVisibleDirectories(accountId, orgId);
        List<NormalFile> visibleNorFiles = fileMapper.getVisibleNorFiles(accountId, orgId);

        for(NormalFile normalFile : visibleNorFiles) {
            int pDirId = normalFile.getParentDirId();
            for(Directory directory : visibleDirectories) {
                if(pDirId == directory.getDirId()) {
                    normalFile.setParentDir(directory);
                    directory.getChildNorFiles().add(normalFile);
                }
            }
        }
        for(Directory directory1 : visibleDirectories) {
            int pDirId = directory1.getParentDirId();
            for(Directory directory2 : visibleDirectories) {
                if(pDirId == directory2.getDirId()) {
                    directory1.setParentDir(directory2);
                    directory2.getChildDirectories().add(directory1);
                }
            }
        }

        Directory root = new Directory();
        root.setDirId(null);
        root.setName("root");

        for(Directory directory : visibleDirectories) {
            if(directory.getParentDir() == null)
            {
                root.getChildDirectories().add(directory);
                directory.setParentDir(root);
            }
        }
        for(NormalFile normalFile : visibleNorFiles) {
            if(normalFile.getParentDir() == null)
            {
                root.getChildNorFiles().add(normalFile);
                normalFile.setParentDir(root);
            }
        }

        return root;
    }
}
