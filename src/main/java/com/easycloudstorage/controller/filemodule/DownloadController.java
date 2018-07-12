package com.easycloudstorage.controller.filemodule;



import com.easycloudstorage.service.filemodule.FileService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@Controller
public class DownloadController {
    @Autowired
    private FileService fileService;



    @RequestMapping(value = "/download")
    public ResponseEntity<byte[]> download(@RequestParam(value = "idCollection[]", required = false)Integer[] idCollection, @RequestParam(value = "idCollection2[]", required = false)Integer[] idCollection2, HttpServletRequest request) throws IOException{
        //通过文件id获取路径
        //获取普通文件路径
        ArrayList<String> paths = new ArrayList<>();
        if(idCollection!=null)
        for(Integer i:idCollection){
            paths.add(fileService.selectNormalFile(i).getRealPath());
        }
        //获取文件夹路径
        /*
        *文件夹下载待完成
        */
        String resourcesName = "files.zip";
        ZipOutputStream zipOut = new ZipOutputStream(new FileOutputStream("E:/" + resourcesName));
        InputStream input = null;
        for(String path:paths){
            File file = new File(path);
            String fileName = file.getName();
            input = new FileInputStream(path);
            zipOut.putNextEntry(new ZipEntry(fileName));
            int temp = 0;
            while ((temp = input.read()) != -1){
                zipOut.write(temp);
            }
            input.close();

        }
        zipOut.close();

        File file = new File("E:/" + resourcesName);
        HttpHeaders headers = new HttpHeaders();
        String name = new String(resourcesName.getBytes("utf-8"),"iso-8859-1");
        headers.setContentDispositionFormData("attachment", name);
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers,HttpStatus.CREATED);
    }
}

