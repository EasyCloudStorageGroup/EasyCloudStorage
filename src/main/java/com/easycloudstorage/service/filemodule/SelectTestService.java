package com.easycloudstorage.service.filemodule;

import com.easycloudstorage.mapper.filemodule.SelectTestMapper;
import com.easycloudstorage.pojo.NormalFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class SelectTestService {
    @Autowired
    private SelectTestMapper selectTestMapper;

    public List<NormalFile> list(){return selectTestMapper.list();}
}
