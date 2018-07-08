package com.easycloudstorage.util;


import com.easycloudstorage.pojo.User;

import java.io.File;

public class CreateDirForUser {
    private static String path = "E:\\EasyCloudStorageData\\";

    public String createDir(User user){
        String userRootDir = path + user.getAccountId();
        File dir = new File(userRootDir);
        if(!dir.exists()){
            dir.mkdir();
        }
        return userRootDir;

    }
}
