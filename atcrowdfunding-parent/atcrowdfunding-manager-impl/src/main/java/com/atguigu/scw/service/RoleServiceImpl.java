package com.atguigu.scw.service;

import com.atguigu.scw.bean.TRole;
import com.atguigu.scw.bean.TRoleExample;
import com.atguigu.scw.mapper.TRoleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    TRoleMapper tRoleMapper;

    @Override
    public List<TRole> getRoles(String condition) {
        TRoleExample exa = new TRoleExample();
        exa.createCriteria().andNameLike("%"+condition + "%");
        List<TRole> tRoles = tRoleMapper.selectByExample(exa);
        return tRoles;
    }

    @Override
    public void deleteRole(Integer id) {
        tRoleMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void insertRole(TRole tRole) {
        tRoleMapper.insertSelective(tRole);
    }

    @Override
    public void batchDel(List<Integer> ids) {
        TRoleExample exa = new TRoleExample();
        exa.createCriteria().andIdIn(ids);
        tRoleMapper.deleteByExample(exa);
    }


}
