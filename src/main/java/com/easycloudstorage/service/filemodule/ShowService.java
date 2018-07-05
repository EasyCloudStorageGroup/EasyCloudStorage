package com.easycloudstorage.service.filemodule;

import com.easycloudstorage.mapper.filemodule.ShowMapper;
import com.easycloudstorage.pojo.Directory;
import com.easycloudstorage.pojo.NormalFile;
import com.easycloudstorage.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


@Service
public class ShowService {
    @Autowired
    private ShowMapper showMapper;
    public List<NormalFile> normalFileList()
    {
        return  showMapper.normalFileList();
    };//这里返回的是数据库中的所有非目录文件
    public List<Directory> directoryList()
    {
        System.out.println("oooos");
        List<Directory> list =showMapper.directoryList();
        System.out.println("======="+list.size());
        return  list;
    };//这里返回的是数据库中的所有目录

    /*
    * 该方法找到一个用户的根目录
    * */
    public Directory rootDirectory(User user, List<Directory> directoryList){
        Directory tem=new Directory();
        for(int i=0;i<directoryList.size();i++) {
            tem = directoryList.get(i);
            if (tem.getParentDirId() == null && tem.getOwnerId().equals(user.getAccountId())) ;
            return tem;
        }
        return null;
    }
/*
* 该方法找到当前目录下的所有子目录
* */
    public List<Directory> showDirectory(Directory currentDir, List<Directory> directoryList){
        Directory tem=new Directory();
        List<Directory> result=new ArrayList<Directory>();
        for(int i=0;i<directoryList.size();i++) {
            tem = directoryList.get(i);
            System.out.println(tem.getDirId());
            if (tem.getParentDirId()!=null && tem.getOwnerId().equals(currentDir.getOwnerId()))
                if(tem.getParentDirId().equals(currentDir.getDirId()))
                result.add(tem);
        }
        return result;

    }
/*
* 该方法找到当前目录下的所有非目录文件
* */
    public List<NormalFile> showNormalFile(Directory currentDir, List<NormalFile> normalFileList){
       NormalFile tem=new NormalFile();
        List<NormalFile> result=new ArrayList<NormalFile>();
        for(int i=0;i<normalFileList.size();i++) {
            tem = normalFileList.get(i);
            if (tem.getParentDirId()!=null && tem.getOwnerId().equals(currentDir.getOwnerId()))
                if(tem.getParentDirId().equals(currentDir.getDirId()))
                    result.add(tem);
        }
        return result;

    }

}
