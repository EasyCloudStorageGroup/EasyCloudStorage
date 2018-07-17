package com.easycloudstorage.mapper.sharingmodule;

import com.easycloudstorage.pojo.Sharing;

import java.util.List;

public interface SharingMapper {
    void addSharingData(Sharing sharing);
    List<Sharing> listSharingData();
    Sharing getSharingDataByStr(String str);
}
