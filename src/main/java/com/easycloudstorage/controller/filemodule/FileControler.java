package com.easycloudstorage.controller.filemodule;

import com.easycloudstorage.pojo.NormalFile;
import com.easycloudstorage.service.TestService;
import org.apache.ibatis.io.Resources;
import  org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
@Controller
public class FileControler {
    private String dataDir="D:/EasyCloudStorageData/";
    @Autowired
    private TestService testService;

    @RequestMapping("rename")
    public ModelAndView list() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("rename");
        return mv;
    }
    @RequestMapping("renamePage")
    public String renamePage(@RequestParam("oldFileName")String oldFileName, String newFileName)
    {
        File file=new File(oldFileName);
        String suffix="";
        if(!file.isDirectory())
            suffix= file.getName().substring(file.getName().indexOf('.'));
        File newFile=new File(dataDir + newFileName+suffix);
        boolean result=file.renameTo(newFile);
        if(result) System.out.println("rename success");
        else System.out.println("rename failed");

        return "redirect:rename";
    }
    @RequestMapping("deleteFilePage")
    public String delete(String filePid)
    {System.out.println("in delete  and pid="+filePid);
        File file=new File(dataDir+"test.txt");
        file.delete();

        return "redirect:rename";
    }
    @RequestMapping("moveFilePage")
    public String move(@RequestParam("filePid")String filePid, String moveToPath)
    {System.out.println("in move and pid ="+filePid+" and moveToPath="+moveToPath);
        File file=new File(dataDir+"moveFile.txt");
        File moveToFile=new File(dataDir + "yyy/"+"moveFile.txt");
        if(!moveToFile.getParentFile().exists())    moveToFile.getParentFile().mkdirs();
        if(file.renameTo(moveToFile)) System.out.println("successed move");
        else System.out.println("failed move");

        return "redirect:rename";
    }
    @RequestMapping("selectTest")
    public String select() throws IOException
    {
        String resource="fileController.xml";
        InputStream inputStream=Resources.getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
        SqlSession session =sqlSessionFactory.openSession();

        List<NormalFile> test=session.selectList("list");
        for(NormalFile normalFile : test)
            System.out.println(normalFile.getFileId()+" "+ normalFile.getName());
        return "rename";
    }
}
