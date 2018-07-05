package com.easycloudstorage.service;

import com.easycloudstorage.mapper.UserMapper;
import com.easycloudstorage.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;

    public List<User> list(){ return userMapper.userList();}
    public List<User> list2(){return userMapper.userList2();}

    public void addUser(User user){ userMapper.addUser(user); }
}
