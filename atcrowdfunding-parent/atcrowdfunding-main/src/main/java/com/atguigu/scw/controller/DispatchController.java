package com.atguigu.scw.controller;

import com.atguigu.scw.bean.TMenu;
import com.atguigu.scw.mapper.TMenuMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DispatchController {

    @Autowired
    TMenuMapper tMenuMapper;

    @ResponseBody
    @RequestMapping("/test")
    public List<TMenu> test(){
        return tMenuMapper.selectByExample(null);
    }
}
