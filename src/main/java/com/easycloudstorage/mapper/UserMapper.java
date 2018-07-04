package com.easycloudstorage.mapper;

import com.easycloudstorage.pojo.User;

import java.util.List;

public interface UserMapper {
    List<User> userList();
    void addUser(User user);
}
