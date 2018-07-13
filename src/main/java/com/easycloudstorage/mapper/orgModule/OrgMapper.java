package com.easycloudstorage.mapper.orgModule;

import com.easycloudstorage.pojo.Organization;
import com.easycloudstorage.pojo.User;

import java.util.List;

public interface OrgMapper {
   List<Organization> orgList(User user);
}
