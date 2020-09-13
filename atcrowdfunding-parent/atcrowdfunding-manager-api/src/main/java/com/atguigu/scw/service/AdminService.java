package com.atguigu.scw.service;

import com.atguigu.scw.bean.TAdmin;

public interface AdminService {

    TAdmin login(String loginacct, String userpswd);
}
