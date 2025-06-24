package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.MenuSettingService;
import com.secuve.agentInfo.vo.MenuSetting;

@Controller
public class MenuSettingController {
	@Autowired MenuSettingService menuSettingService;
	@Autowired FavoritePageService favoritePageService;

	@GetMapping(value = "/menuSetting/setting")
    public String menuSettingList(Model model, Principal principal, HttpServletRequest req) {
        favoritePageService.insertFavoritePage(principal, req, "메뉴 설정");

        return "menuSetting/MenuSettingList";
    }
	
	@ResponseBody
    @PostMapping(value = "/menuSetting/main")
    public Map<String, Object> mainMenuSetting(MenuSetting search) {
        Map<String, Object> response = new HashMap<>();
        List<MenuSetting> mainMenuSettingList = menuSettingService.getMainMenuSettingList(search);
        int totalCount = menuSettingService.getMainMenuSettingListCount();

        response.put("page", search.getPage());
        response.put("total", Math.ceil((float) totalCount / search.getRows()));
        response.put("records", totalCount);
        response.put("rows", mainMenuSettingList);

        return response;
    }
	
	@ResponseBody
    @PostMapping(value = "/menuSetting/sub")
    public Map<String, Object> subMenuSetting(MenuSetting search) {
        Map<String, Object> response = new HashMap<>();
        List<MenuSetting> subMenuSettingList = menuSettingService.getSubMenuSettingList(search);
        int totalCount = menuSettingService.getSubMenuSettingListCount();

        response.put("page", search.getPage());
        response.put("total", Math.ceil((float) totalCount / search.getRows()));
        response.put("records", totalCount);
        response.put("rows", subMenuSettingList);

        return response;
    }
}
