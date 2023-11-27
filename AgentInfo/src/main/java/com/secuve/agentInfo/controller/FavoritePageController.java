package com.secuve.agentInfo.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;

import com.secuve.agentInfo.service.FavoritePageService;

@Controller
public class FavoritePageController {
	@Autowired FavoritePageService favoritePageService;
	
	@PostMapping(value ="/favoritePage/favorite")
	public String Favorite(Model model, Principal principal) {
		model.addAttribute("favoritePageList", favoritePageService.getFavorite(principal.getName()));
		return "/favoritePage/Favorite";
	}
}
