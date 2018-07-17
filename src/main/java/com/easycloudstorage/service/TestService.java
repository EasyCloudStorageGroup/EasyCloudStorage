package com.easycloudstorage.service;

import com.easycloudstorage.mapper.TestMapper;
import com.easycloudstorage.pojo.Test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TestService {
    @Autowired
    private TestMapper testMapper;

    public List<Test> list() {
        return testMapper.list();
    }
}
