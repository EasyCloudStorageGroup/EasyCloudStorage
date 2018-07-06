package com.easycloudstorage.mapper.usermodule;

import com.easycloudstorage.pojo.User;

public interface ProfileMapper {
    User userInfo();
    void modifyInfo(User user);
    void unUseDefaultAvatar(User user);
}
