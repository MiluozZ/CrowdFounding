package com.atguigu.scw.service;

import com.atguigu.scw.bean.TAdmin;

import java.util.List;

public interface AdminService {
    TAdmin login(String loginacct, String userpswd);

    List<TAdmin> getUserList(String condition);

    void saveUser(TAdmin admin);

    void deleteUser(Integer id);

    void batchDeleteUser(List<Integer> ids);
}
