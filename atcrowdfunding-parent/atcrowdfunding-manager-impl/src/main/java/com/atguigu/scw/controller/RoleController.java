package com.atguigu.scw.controller;

import com.atguigu.scw.bean.TRole;
import com.atguigu.scw.service.RoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sun.scenario.effect.impl.sw.sse.SSEBlend_SRC_OUTPeer;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/role")
public class RoleController {
    @Autowired
    RoleService roleService;

    //批量删除角色
    @ResponseBody
    @RequestMapping("/batchDel")
    public String batchDel(@RequestParam("ids") List<Integer> ids){
        roleService.batchDel(ids);
        return "ok";
    }



    //增加角色
    @ResponseBody
    @RequestMapping("/insertRole")
    public String insertRole(TRole tRole){
        roleService.insertRole(tRole);
        return "ok";
    }


    //单个删除
    @ResponseBody
    @RequestMapping("/delete")
    public String delete(Integer id){
        roleService.deleteRole(id);

        return "ok";
    }

    //分页列表展示
    @ResponseBody
    @RequestMapping("/getRoles")
    public PageInfo<TRole> getRoles(@RequestParam(defaultValue = "1",required = false)Integer pageNum, @RequestParam(defaultValue = "",required = false) String condition){
        int pageSize = 3;
        PageHelper.startPage(pageNum,pageSize);
        List<TRole> roles = roleService.getRoles(condition);
        PageInfo<TRole> pageInfo = new PageInfo<>(roles,3);
        return pageInfo;
    }



    //跳转到角色页面
    @RequestMapping("/index")
    public String rolePage(){
        return "/admin/role";
    }

}
