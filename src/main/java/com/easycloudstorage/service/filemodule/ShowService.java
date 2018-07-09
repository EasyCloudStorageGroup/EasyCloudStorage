package com.easycloudstorage.service.filemodule;

import com.easycloudstorage.mapper.filemodule.ShowMapper;
import com.easycloudstorage.pojo.Directory;
import com.easycloudstorage.pojo.File;
import com.easycloudstorage.pojo.NormalFile;
import com.easycloudstorage.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.FileInputStream;
import java.security.PublicKey;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;



@Service
public class ShowService {
    @Autowired
    private ShowMapper showMapper;

    public List<NormalFile> normalFileList()
    {List<NormalFile> list=showMapper.normalFileList();
        for (NormalFile normalFile:list
                ) {
            normalFile.setDisplayTime();
        }

        return  list;
    };//这里返回的是数据库中的所有非目录文件
    public List<Directory> directoryList()
    {

        List<Directory> list =showMapper.directoryList();
        for (Directory directory:list
             ) {
            directory.setDisplayTime();
        }
        System.out.println("======="+list.size());
        return  list;
    };//这里返回的是数据库中的所有目录

    /*
    * 该方法找到一个用户的根目录
    * */
    public Directory rootDirectory(User user, List<Directory> directoryList){
        Directory tem=new Directory();
        for(int i=0;i<directoryList.size();i++) {
            tem = directoryList.get(i);
            if (tem.getParentDirId() == 0 && tem.getOwnerId().equals(user.getAccountId()))
            {
                return tem;
            }
        }
        return null;
    }
/*
* 该方法找到当前目录下的所有子目录
* */
    public List<Directory> showDirectory(int currentDirId, List<Directory> directoryList){
        Directory tem=new Directory();
        List<Directory> result=new ArrayList<Directory>();
        for(int i=0;i<directoryList.size();i++) {
            tem = directoryList.get(i);

            if (tem.getParentDirId()!=0&&tem.getParentDirId() == currentDirId)
                result.add(tem);
        }
        return result;

    }
/*
* 该方法找到当前目录下的所有非目录文件
* */
    public List<NormalFile> showNormalFile(int currentDirId, List<NormalFile> normalFileList){
       NormalFile tem=new NormalFile();
        List<NormalFile> result=new ArrayList<NormalFile>();
        for(int i=0;i<normalFileList.size();i++) {
            tem = normalFileList.get(i);
            if (tem.getParentDirId()!=0&&tem.getParentDirId() == currentDirId)
                result.add(tem);
        }
        return result;
    }
/*
 * 根据dirID找到他的父目录
 */

    public  Directory findParentDir(int dirId,List<Directory> directoryList)//找到该dir的父目录
    {

        Directory currentDir=new Directory();

        Directory parentDir=new Directory();

        for(int i=0;i<directoryList.size();i++) {//找到该dirId的dir对象
            currentDir = directoryList.get(i);
            if (currentDir.getDirId() == dirId)//通过Id找到了该对象
                break;
        }
    for(int i=0;i<directoryList.size();i++) {//找到该dirId的dir对象
        parentDir = directoryList.get(i);
        if (currentDir.getParentDirId()!=0&&currentDir.getParentDirId() == parentDir.getDirId())//通过Id找到了该对象
            return parentDir;
        }
    return null;
    }

/*
* 根据dirID找到该ID的directory对象
* */


    public Directory findDirectoryById(int dirId,List<Directory> directoryList)

    {
        Directory currentDir;
        for(int i=0;i<directoryList.size();i++)
        {
            currentDir=directoryList.get(i);
            if(dirId!=0&&dirId == currentDir.getDirId())
                return currentDir;

        }
        return null;
    }
    /*
     * 根据fileID找到该ID的file对象
     * */
    public NormalFile findNormalFileById(int fileId,List<NormalFile> normalFileList)
    {
        NormalFile file;
        for(int i=0;i<normalFileList.size();i++)
        {
            file=normalFileList.get(i);
            if(fileId!=0&&fileId==(file.getFileId()))
                return file;

        }
        return null;
    }

  /*  public StringBuffer readFile(String filePath){
        StringBuffer fileContent = new StringBuffer();
        File file = new File(uploadPath+fileName);
        if(file.exists()){
            String suffix = file.getName().substring(file.getName().lastIndexOf(".")+1);
            //Word2003
            if (suffix.equals("doc")) {
                FileInputStream fis = new FileInputStream(file);
                WordExtractor wordExtractor = new WordExtractor(fis);
                String text = wordExtractor.getText();
                fileContent.append(text);
            }
            //Word2007
            else if (suffix.equals("docx")) {
                OPCPackage opcPackage = POIXMLDocument.openPackage(uploadPath+fileName);
                POIXMLTextExtractor extractor = new XWPFWordExtractor(opcPackage);
                String text = extractor.getText();
                fileContent.append(text);
            }
            //TXT
            else if (suffix.equals("txt")) {
                BufferedReader bufferReader = new BufferedReader(new InputStreamReader(new FileInputStream(file),"utf-8"));
                //每从BufferedReader对象中读取一行字符。
                String line = null;
                while((line=bufferReader.readLine()) !=null){
                    fileContent.append(line);
                }
                bufferReader.close();
            }
        }else{
            System.out.println("文件不存在！");
        }
        return fileContent;
    }*/



    /*
     * 对普通文件列表进行排序
     */
    public void orderNormalFileList(List<NormalFile> nfs, String orderBy) {
        if(orderBy == null)
            orderBy = "name";

        for(int i = 0; i < nfs.size()-1; i++) {
            for(int j = 0; j < nfs.size()-i-1; j++) {
                if(orderBy.equals("name")) {
                    if(nfs.get(j).getName().toLowerCase().compareTo(nfs.get(j+1).getName().toLowerCase())>0) {
                        NormalFile nf = nfs.get(j);
                        nfs.set(j, nfs.get(j+1));
                        nfs.set(j+1, nf);
                    }
                }
                else if(orderBy.equals("lastMovedTime")) {
                    if(nfs.get(j).getLastMovedTime().compareTo(nfs.get(j+1).getLastMovedTime())>0) {
                        NormalFile nf = nfs.get(j);
                        nfs.set(j, nfs.get(j+1));
                        nfs.set(j+1, nf);
                    }
                }
                else if(orderBy.equals("size")) {
                    if(nfs.get(j).getSize().compareTo(nfs.get(j+1).getSize())>0) {
                        NormalFile nf = nfs.get(j);
                        nfs.set(j, nfs.get(j+1));
                        nfs.set(j+1, nf);
                    }
                }
            }
        }
    }

    /*
     * 目录排序
     */
    public void orderDirectoryList(List<Directory> ds, String orderBy) {
        if(orderBy == null)
            orderBy = "name";

        for(int i = 0; i < ds.size()-1; i++) {
            for(int j = 0; j < ds.size()-i-1; j++) {
                if(orderBy.equals("name")) {
                    if(ds.get(j).getName().toLowerCase().compareTo(ds.get(j+1).getName().toLowerCase())>0) {
                        Directory d = ds.get(j);
                        ds.set(j, ds.get(j+1));
                        ds.set(j+1, d);
                    }
                }
                else if(orderBy.equals("lastMovedTime")) {
                    if(ds.get(j).getLastMovedTime().compareTo(ds.get(j+1).getLastMovedTime())>0) {
                        Directory d = ds.get(j);
                        ds.set(j, ds.get(j+1));
                        ds.set(j+1, d);
                    }
                }
                else if(orderBy.equals("size")) {
                }
            }
        }
    }

    /*
     * 文件名搜索
     */
    public void searchFiles(List<NormalFile> srcNFiles, List<Directory> srcDirectories,
                            List<NormalFile> searchedNFiles, List<Directory> searchedDirectories,
                            String keyword) {
        for(NormalFile srcNFile : srcNFiles) {
            if(srcNFile.getName().toLowerCase().contains(keyword.toLowerCase()))
                searchedNFiles.add(srcNFile);
        }

        for(Directory directory : srcDirectories) {
            if(directory.getName().toLowerCase().contains(keyword.toLowerCase()))
                searchedDirectories.add(directory);

            List<Directory> nextSrcDirs = showDirectory(directory.getDirId(), directoryList());
            List<NormalFile> nexSrcNFiles = showNormalFile(directory.getDirId(), normalFileList());

            searchFiles(nexSrcNFiles, nextSrcDirs, searchedNFiles, searchedDirectories, keyword);
        }
    }

}
