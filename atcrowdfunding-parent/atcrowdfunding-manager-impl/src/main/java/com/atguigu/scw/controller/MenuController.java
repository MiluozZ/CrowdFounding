package com.atguigu.scw.controller;

import com.atguigu.scw.bean.TMenu;
import com.atguigu.scw.bean.TMenuExample;
import com.atguigu.scw.mapper.TMenuMapper;
import com.atguigu.scw.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    MenuService menuService;
    //查询所有菜单
    @ResponseBody
    @RequestMapping("/getMenus")
    public List<TMenu> getMenus(){
        List<TMenu> Menus = menuService.getPMenus();
        return Menus;
    }

    //跳转到菜单页面
    @RequestMapping("/index")
    public String menuPage(){
        return "/admin/menu";
    }
}
