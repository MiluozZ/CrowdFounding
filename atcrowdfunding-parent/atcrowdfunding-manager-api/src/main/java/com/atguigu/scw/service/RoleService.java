package com.atguigu.scw.service;

import com.atguigu.scw.bean.TRole;

import java.util.List;

public interface RoleService {
    List<TRole> getRoles(String condition);


    void deleteRole(Integer id);

    void insertRole(TRole tRole);

    void batchDel(List<Integer> ids);

    TRole getRole(Integer id);

    void updateRole(TRole tRole);
}
