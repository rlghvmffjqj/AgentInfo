package com.secuve.agentInfo.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.server.ResponseStatusException;

import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.ProductVersionService;

@Controller
public class ProductVersionController {
	@Autowired FavoritePageService favoritePageService;
	@Autowired ProductVersionService productVersionService;
	
	@GetMapping(value = "/productVersion/{mainTitle}")
    public String menuList(Model model, Principal principal, HttpServletRequest req, @PathVariable("mainTitle") String mainTitle, String subTitle) {
		int nonExist = productVersionService.getProductVersionNoneExist(mainTitle, subTitle);
		if (nonExist == 0) {
	        throw new ResponseStatusException(HttpStatus.NOT_FOUND, "해당 메뉴 정보가 존재하지 않습니다.");
	    }
		if(subTitle == "" || subTitle == null) {
			favoritePageService.insertFavoritePage(principal, req, mainTitle);
			model.addAttribute("menuTitle", mainTitle);
			model.addAttribute("menuType", "main");
		} else {
			favoritePageService.insertFavoritePage(principal, req, subTitle);
			model.addAttribute("menuTitle", subTitle);
			model.addAttribute("menuType", "sub");
		}

        return "productVersion/ProductVersionList";
    }
}
