package com.easycloudstorage.service.usermodule;

import com.easycloudstorage.mapper.usermodule.ProfileMapper;
import com.easycloudstorage.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProfileService {
    @Autowired
    private ProfileMapper theUser;

    public User getUser(){
        return theUser.userInfo();
    }

    public void modInfo(User user){
        theUser.modifyInfo(user);
    }

    public void unUseDefaultAvatar(User user) {
        theUser.unUseDefaultAvatar(user);
    }
}
