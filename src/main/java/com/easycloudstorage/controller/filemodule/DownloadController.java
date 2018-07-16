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



    @RequestMapping(value = "download")
    public ResponseEntity<byte[]> download(@RequestParam(value = "idCollection[]", required = false)Integer[] idCollection, @RequestParam(value = "idCollection2[]", required = false)Integer[] idCollection2, HttpServletRequest request) throws IOException{
        //通过文件id获取路径
        //获取普通文件路径
        //如果只有一个文件则不需要压缩
        if(idCollection.length == 0){
            return null;
        }
        else if (idCollection.length == 1){
            String path = fileService.selectNormalFile(idCollection[0]).getRealPath();
            File file = new File(path);
            HttpHeaders headers = new HttpHeaders();
            String name = new String(file.getName().getBytes("utf-8"),"iso-8859-1");
            headers.setContentDispositionFormData("attachment", name);
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers,HttpStatus.CREATED);
        }
        else {
            ArrayList<String> paths = new ArrayList<>();
            for(Integer i:idCollection){
                paths.add(fileService.selectNormalFile(i).getRealPath());
            }
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
}

