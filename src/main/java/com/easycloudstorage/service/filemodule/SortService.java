package com.easycloudstorage.service.filemodule;

import com.easycloudstorage.pojo.NormalFile;
import com.easycloudstorage.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import com.easycloudstorage.mapper.filemodule.SortMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SortService {
    @Autowired
    private SortMapper sortMapper;
    public List<NormalFile> normalFileList(User user)
    {
        return  sortMapper.normalFileList(user);
    }//返回数据库中的所有非目录文件

}
