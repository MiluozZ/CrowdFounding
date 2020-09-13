package com.atguigu.scw.service;

import com.atguigu.scw.bean.TAdmin;
import com.atguigu.scw.bean.TAdminExample;
import com.atguigu.scw.mapper.TAdminMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService{

    @Autowired
    TAdminMapper tAdminMapper;


    @Override
    public TAdmin login(String loginacct, String userpswd) {
        TAdminExample exa = new TAdminExample();

        exa.createCriteria().andLoginacctEqualTo(loginacct).andUserpswdEqualTo(userpswd);

        List<TAdmin> admins = tAdminMapper.selectByExample(exa);

        if (CollectionUtils.isEmpty(admins) || admins.size() > 1){
            return null;
        }

        TAdmin admin = admins.get(0);

        return admin;
    }
}
