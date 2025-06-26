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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	
	@PostMapping(value = "/menuSetting/insertView")
	public String InsertMenuSettingView(Model model, MenuSetting menuSetting) {
		
		model.addAttribute("viewType", "insert").addAttribute("menuSetting", menuSetting);
		return "/menuSetting/MenuSettingView";
	}
	
	@ResponseBody
	@PostMapping(value = "/menuSetting/menuInsert")
	public String InsertMenuSetting(MenuSetting menuSetting, Principal principal) {
		menuSetting.setMenuSettingRegistrant(principal.getName());
		menuSetting.setMenuSettingRegistrationDate(menuSettingService.nowDate());

		return menuSettingService.insertMenuSetting(menuSetting);
	}
	
	@PostMapping(value = "/menuSetting/updateView")
	public String UpdateMenuSettingView(Model model, int menuKeyNum) {
		MenuSetting menuSetting = menuSettingService.getMenuSettingOne(menuKeyNum);
		
		model.addAttribute("viewType", "update").addAttribute("menuSetting", menuSetting);
		return "/menuSetting/MenuSettingView";
	}
	
	@ResponseBody
	@PostMapping(value = "/menuSetting/menuUpdate")
	public String UpdateMenuSetting(MenuSetting menuSetting, Principal principal) {
		menuSetting.setMenuSettingModifier(principal.getName());
		menuSetting.setMenuSettingModifiedDate(menuSettingService.nowDate());

		return menuSettingService.updateMenuSetting(menuSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/menuSetting/delete")
	public String MenuSettingDelete(@RequestParam int menuKeyNum) {
		return menuSettingService.delMenuSetting(menuKeyNum);
	}
	
	@ResponseBody
	@PostMapping(value = "/menuSetting/menu")
	public List<MenuSetting> Menu() {
		return menuSettingService.getMenuList();
	}
	
	@GetMapping(value = "/productVersion/{mainMenu}")
    public String menuList(Model model, Principal principal, HttpServletRequest req, @PathVariable("mainMenu") String mainMenu, String subTitle) {
		if(subTitle == "" || subTitle == null) {
			favoritePageService.insertFavoritePage(principal, req, mainMenu);
			model.addAttribute("menuTitle", mainMenu);
		} else {
			favoritePageService.insertFavoritePage(principal, req, subTitle);
			model.addAttribute("menuTitle", subTitle);
		}

        return "productVersion/ProductVersionList";
    }
}
