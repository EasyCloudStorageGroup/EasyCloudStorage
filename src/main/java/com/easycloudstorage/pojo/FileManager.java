package com.easycloudstorage.pojo;

import org.springframework.http.HttpRequest;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class FileManager {

    public static String upload(MultipartFile file, HttpServletRequest request){

        System.out.println();
        String name=file.getOriginalFilename();
        User user=(User) request.getSession().getAttribute("user");
        user=new User();
        user.setUserName("why");
        System.out.println(System.getProperty("user.dir"));
        java.io.File userDir=new File("D:\\EasyCloudStorageData\\"+user.getUserName());
        int BufferSize=4096;
        byte buffer[]=new byte[BufferSize];
        try {
            if (!userDir.exists())
            userDir.mkdir();
            File temp=new File(userDir,name);
            FileOutputStream writer=new FileOutputStream(temp);
            InputStream reader=file.getInputStream();

            int number=0;
            while ((number=reader.read(buffer))!=-1){

                writer.write(buffer, 0, number);

            }
            writer.flush();
            writer.close();
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
            return "failed";
        }catch (Exception e){
            e.printStackTrace();
            return "failed";
        }
        return "success";  //上传成功则跳转至此success.jsp页
    }


}
