package com.easycloudstorage.service.sharingmodule;

import com.easycloudstorage.mapper.sharingmodule.SharingMapper;
import com.easycloudstorage.pojo.Sharing;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SharingService {
    @Autowired
    private SharingMapper sharingMapper;

    public void addSharingData(Sharing sharing){
        sharingMapper.addSharingData(sharing);
    }

    public List<Sharing> listSharingData(){
        return sharingMapper.listSharingData();
    }

    public Sharing getSharingDataByStr(String str){
        return sharingMapper.getSharingDataByStr(str);
    }
}
