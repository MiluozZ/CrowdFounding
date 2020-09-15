package com.atguigu.scw.controller;

import com.atguigu.scw.bean.TAdmin;
import com.atguigu.scw.bean.TMenu;
import com.atguigu.scw.mapper.TAdminMapper;
import com.atguigu.scw.service.AdminService;
import com.atguigu.scw.service.MenuService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    AdminService adminService;


    //批量删除用户
    @RequestMapping("/batchDelete")
    public String batchDelete(@RequestParam("ids") List<Integer> ids,HttpSession session){
        adminService.batchDeleteUser(ids);

        Integer currentPageNum = (Integer) session.getAttribute("currentPageNum");
        return "redirect:/admin/index?pageNum="+(currentPageNum);
    }




    //单个用户删除
    @RequestMapping("/delete/{id}")
    public String delete(@PathVariable("id") Integer id, HttpSession session){
        adminService.deleteUser(id);
        Integer currentPageNum = (Integer) session.getAttribute("currentPageNum");
        return "redirect:/admin/index?pageNum="+(currentPageNum);
    }


    //增加用户
    @RequestMapping(value = "/saveUser",method = RequestMethod.POST)
    public String saveUser(TAdmin admin,HttpSession session){
        try {
            adminService.saveUser(admin);
        } catch (Exception e) {
            session.setAttribute("saveError",e.getMessage());
            return "redirect:/admin/edit.html";
        }
        Integer totalPage = (Integer) session.getAttribute("totalPage");
        return "redirect:/admin/index?pageNum=" + (totalPage + 1);
    }


    //转发新增用户页面
    @RequestMapping("/edit.html")
    public String edit(){
        return "admin/edit";
    }



    @RequestMapping("/index")
    public String index(HttpSession session,Model model, @RequestParam(defaultValue = "1",required = false) Integer pageNum,@RequestParam(defaultValue = "" , required = false) String condition){
        int pageSize = 3;
        PageHelper.startPage(pageNum,pageSize);

        List<TAdmin> admins = adminService.getUserList(condition);
        PageInfo<TAdmin> pageInfo = new PageInfo<>(admins,3);
        model.addAttribute("pageInfo",pageInfo);
        session.setAttribute("totalPage",pageInfo.getPages());
        session.setAttribute("currentPageNum" , pageInfo.getPageNum());
        return "admin/user";
    }


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


    @Autowired
    MenuService menuService;

    @RequestMapping("/main.html")
    public String mainPage(HttpSession session){

        List<TMenu> pMenus = menuService.getPMenus();
        session.setAttribute("pmenus",pMenus);
        return "/admin/main";
    }


    @RequestMapping("/login.html")
    public String login(){
        return "/admin/login";
    }
}
