package com.atguigu.scw.controller;

import com.atguigu.scw.bean.TAdmin;
import com.atguigu.scw.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    AdminService adminService;

    @RequestMapping(value = "/login" ,method = RequestMethod.POST)
    public String login(HttpSession session,Model model, String loginacct, String userpswd){
        TAdmin admin = adminService.login(loginacct, userpswd);
        if (admin == null){
            String errorMsg = "账户密码错误";
            model.addAttribute("errorMsg",errorMsg);
            return "/admin/login";
        }
        session.setAttribute("admin",admin);
        return "redirect:/admin/main.html";
    }

    @RequestMapping("/main.html")
    public String mainPage(){
        return "/admin/main";
    }


    @RequestMapping("/login.html")
    public String login(){
        return "/admin/login";
    }
}
