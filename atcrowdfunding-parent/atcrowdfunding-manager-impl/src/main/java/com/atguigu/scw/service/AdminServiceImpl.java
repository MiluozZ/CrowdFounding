package com.atguigu.scw.service;

import com.atguigu.scw.bean.TAdmin;
import com.atguigu.scw.bean.TAdminExample;
import com.atguigu.scw.mapper.TAdminMapper;
import com.atguigu.scw.utils.DateUtil;
import com.atguigu.scw.utils.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;

@Service
public class AdminServiceImpl implements AdminService{

    @Autowired
    TAdminMapper tAdminMapper;


    @Override
    public TAdmin login(String loginacct, String userpswd) {
        TAdminExample exa = new TAdminExample();

        exa.createCriteria().andLoginacctEqualTo(loginacct).andUserpswdEqualTo(MD5Util.digest(userpswd));

        List<TAdmin> admins = tAdminMapper.selectByExample(exa);

        if (CollectionUtils.isEmpty(admins) || admins.size() > 1){
            return null;
        }

        TAdmin admin = admins.get(0);

        return admin;
    }



    @Override
    public List<TAdmin> getUserList(String condition) {
//如果有条件则带条件查询分页数据：  select * from t_admin where xxx like '' limit index ,size
        //如果没有条件则查询所有数据的分页数据  select * from t_admin  like '' limit index ,size
        if(StringUtils.isEmpty(condition)){
            return tAdminMapper.selectByExample(null);
        }
        TAdminExample exa = new TAdminExample();
        //select * from t_admin where loginacct like '%xxx%' or username like '%xx%'  or email like '%xxx%'  limit index ,size
        TAdminExample.Criteria c1 = exa.createCriteria();//exa的第一个默认的条件
        c1.andLoginacctLike("%"+condition+"%");
        TAdminExample.Criteria c2 = exa.createCriteria();
        c2.andUsernameLike("%"+condition+"%");
        TAdminExample.Criteria c3 = exa.createCriteria();
        c3.andEmailLike("%"+condition+"%");
        exa.or(c2);
        exa.or(c3);
        return  tAdminMapper.selectByExample(exa);
    }

    @Override
    public void saveUser(TAdmin admin) {


        TAdminExample exa = new TAdminExample();
        exa.createCriteria().andLoginacctEqualTo(admin.getLoginacct());
        long loginacctCount = tAdminMapper.countByExample(exa);
        if (loginacctCount>0){
            throw new RuntimeException("账户被占用");
        }
        exa.clear();

        exa.createCriteria().andEmailEqualTo(admin.getEmail());
        long emailCount =tAdminMapper.countByExample(exa);
        if (emailCount>0){
            throw new RuntimeException("邮箱被占用");
        }


        admin.setCreatetime(DateUtil.getFormatTime());
        admin.setUserpswd(MD5Util.digest(admin.getUserpswd()));
        tAdminMapper.insertSelective(admin);
    }

    @Override
    public void deleteUser(Integer id) {
        int i = tAdminMapper.deleteByPrimaryKey(id);

    }

    @Override
    public void batchDeleteUser(List<Integer> ids) {


        TAdminExample exa = new TAdminExample();
        exa.createCriteria().andIdIn(ids);
        tAdminMapper.deleteByExample(exa);

    }
}
