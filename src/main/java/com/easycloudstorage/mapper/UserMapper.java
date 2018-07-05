package com.easycloudstorage.mapper;

import com.easycloudstorage.pojo.User;

import java.util.List;

public interface UserMapper {
    List<User> userList();
    List<User> userList2();
    void addUser(User user);
}
