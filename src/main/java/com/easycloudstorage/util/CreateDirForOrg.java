package com.easycloudstorage.util;
import com.easycloudstorage.pojo.Organization;
import java.io.File;


public class CreateDirForOrg {
    private static String path = "D:\\EasyCloudStorageData\\Organization";
    public String createDirForOrg(Organization org){

        String userRootDir = path + org.getOrgId();
        File dir = new File(userRootDir);
        if(!dir.exists()){
            dir.mkdir();
        }
        return userRootDir;
    }
}
