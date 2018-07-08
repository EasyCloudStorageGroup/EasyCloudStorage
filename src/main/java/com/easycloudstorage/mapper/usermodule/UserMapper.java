package com.easycloudstorage.mapper.usermodule;

import com.easycloudstorage.pojo.Directory;
import com.easycloudstorage.pojo.File;
import com.easycloudstorage.pojo.User;

import java.util.List;

public interface UserMapper {
    List<User> userList();
    List<User> userList2();
    void addUser(User user);
    User getUserByAccountId(String accountId);
    void addDir(File file);
}
