package com.atguigu.scw.service;

import com.atguigu.scw.bean.TMenu;
import com.atguigu.scw.mapper.TMenuMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MenuServiceImpl implements MenuService{

    @Autowired
    TMenuMapper tMenuMapper;


    @Override
    public List<TMenu> getPMenus() {
        List<TMenu> menus = tMenuMapper.selectByExample(null);
        Map<Integer,TMenu> pmenus = new HashMap<>();


        //找出父菜单
        for (TMenu menu : menus) {
            if (menu.getPid() == 0){
                pmenus.put(menu.getId(),menu);
            }
        }


        //将子菜单放入父菜单的子菜单集合中
//        for (TMenu menu : menus) {
//            if (menu.getPid() != 0){
//                TMenu pmenu = pmenus.get(menu.getPid());
//                if (pmenu != null){
//                    pmenu.getChildren().add(menu);
//                }
//            }
//        }
        for (TMenu menu : menus) {
            if(menu.getPid()!=0){//pid除了0之外，一定会对应一个父菜单的id值
                TMenu pmenu = pmenus.get(menu.getPid());
                if(pmenu!=null){
                    pmenu.getChildren().add(menu);
                }
            }
        }


        return new ArrayList<TMenu>(pmenus.values());
    }
}
