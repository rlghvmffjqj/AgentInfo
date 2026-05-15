package com.secuve.agentInfo.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.WorkManageService;

@Controller
public class WorkManageController {
	@Autowired WorkManageService workManageService;
	@Autowired FavoritePageService favoritePageService;

	@GetMapping(value = "/workManage/list")
	public String WorkManageList(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "업무 관리");
		
        
		return "workManage/WorkManageList";
	}
}
