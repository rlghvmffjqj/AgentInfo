package com.secuve.agentInfo.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.AutomatedTestingService;
import com.secuve.agentInfo.service.FavoritePageService;

@Controller
public class AutomatedTestingController {
	@Autowired AutomatedTestingService automatedTestingService;
	@Autowired FavoritePageService favoritePageService;
	
	@GetMapping(value = "/automatedTesting/list")
	public String AutomatedTestingList(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "자동화 테스트");
		return "automatedTesting/AutomatedTestingList";
	}
	
	@ResponseBody
	@PostMapping(value = "/automatedTesting/addAccount")
	public String AddAccount() {
		return automatedTestingService.automatedTestingRun("addAccount");
	}
	
	

	
}
