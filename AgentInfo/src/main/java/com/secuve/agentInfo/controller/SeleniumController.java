package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.core.PlayerService;
import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.SeleniumService;
import com.secuve.agentInfo.vo.Selenium;

@Controller
public class SeleniumController {
	@Autowired FavoritePageService favoritePageService;
	@Autowired SeleniumService seleniumService;
	@Autowired PlayerService playerService;

	@GetMapping(value = "/selenium/list")
    public String SeleniumList(Model model, Principal principal, HttpServletRequest req) {
        favoritePageService.insertFavoritePage(principal, req, "자동화 테스트");

        return "selenium/SeleniumMain";
    }
	
	@ResponseBody
	@PostMapping(value = "/selenium/start")
	public void SeleniumStart(Selenium selenium) {
		System.out.println("Controller: Recording started.");
        new Thread(() -> {
        	seleniumService.start(selenium);
        }).start();
	}
	
	@ResponseBody
	@PostMapping(value = "/selenium/stop")
	public String SeleniumStop() {
		System.out.println("Controller: Recording stopped and saved.");
        return seleniumService.stop();
	}
	
	@ResponseBody
	@PostMapping(value = "/selenium/run")
	public void SeleniumRun() {
		System.out.println("Controller: Playback started.");
        new Thread(() -> {
        	playerService.runPlayback(); // 매개변수 없이 호출
        }).start();
	}
	
	@PostMapping(value = "/selenium/startView")
	public String SeleniumView() {
		return "/selenium/SeleniumView";
	}
	
	@ResponseBody
	@PostMapping(value = "/selenium/insert")
	public Map InsertSelenium(Selenium selenium, Principal principal) {
		selenium.setSeleniumRegistrant(principal.getName());
		selenium.setSeleniumRegistrationDate(seleniumService.nowDate());

		Map<String, Object> map = new HashMap<>();
		String result = seleniumService.insertSelenium(selenium);
		
		map.put("seleniumKeyNum", selenium.getSeleniumKeyNum());
		map.put("result", result);
		return map;
	}
}
