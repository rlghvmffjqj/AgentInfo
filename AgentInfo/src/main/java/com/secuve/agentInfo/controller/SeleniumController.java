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
import org.springframework.web.bind.annotation.RequestParam;
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
	@PostMapping(value = "/selenium/delete")
	public String SeleniumDelete(@RequestParam int[] chkList) {
		return seleniumService.delSelenium(chkList);
	}
	
	@ResponseBody
    @PostMapping(value = "/selenium")
    public Map<String, Object> getSelenium(Selenium search) {
        Map<String, Object> response = new HashMap<>();
        List<Selenium> seleniumList = seleniumService.getSeleniumList(search);
        int totalCount = seleniumService.getSeleniumListCount(search);

        response.put("page", search.getPage());
        response.put("total", Math.ceil((float) totalCount / search.getRows()));
        response.put("records", totalCount);
        response.put("rows", seleniumList);

        return response;
    }
	
	@ResponseBody
	@PostMapping(value = "/selenium/start")
	public String SeleniumStart(HttpServletRequest request, Selenium selenium) {
//		System.out.println("Controller: Recording started.");
//        new Thread(() -> {
//        	seleniumService.start(selenium);
//        }).start();
		try {
			String clientIp = seleniumService.getClientIp(request);
			seleniumService.startApi(selenium, clientIp);
			return "OK";
		} catch (Exception e) {
			return "FALSE";
		}
		
	}
	
	@ResponseBody
	@PostMapping(value = "/selenium/stop")
	public String SeleniumStop(HttpServletRequest request) {
//		System.out.println("Controller: Recording stopped and saved.");
//        return seleniumService.stop();
		try {
			String clientIp = seleniumService.getClientIp(request);
			String result = seleniumService.stopApi(clientIp);
			if(result == "[]") {
				return "Empty";
			} else {
				return result;
			}
		} catch (Exception e) {
			return "FALSE";
		}
	}
	
	@ResponseBody
	@PostMapping(value = "/selenium/run")
	public Map SeleniumRun(Principal principal, HttpServletRequest request, Selenium selenium) {
//		Selenium selenium = seleniumService.getSeleniumOne(seleniumKeyNum);
//		System.out.println("Controller: Playback started.");
//        new Thread(() -> {
//        	playerService.runPlayback(selenium);
//        }).start();
		String saveResult = "";
		String result = "";
		Map<String, Object> map = new HashMap<>();
		if(selenium.getSeleniumKeyNum() == null) {
			selenium.setSeleniumRegistrant(principal.getName());
			selenium.setSeleniumRegistrationDate(seleniumService.nowDate());
			saveResult = seleniumService.insertSelenium(selenium);
		} else {
			selenium.setSeleniumModifier(principal.getName());
			selenium.setSeleniumModifiedDate(seleniumService.nowDate());
			saveResult = seleniumService.updateSelenium(selenium);
		}
		
		if(saveResult == "OK") {
			try {
				String clientIp = seleniumService.getClientIp(request);
				result = seleniumService.runApi(selenium, clientIp);
			}catch (Exception e) {
				result = "FALSE";
			}
		}
		
		map.put("seleniumKeyNum", selenium.getSeleniumKeyNum());
		map.put("result", result);
		return map;
	}
	
	@PostMapping(value = "/selenium/startView")
	public String SeleniumView() {
		return "/selenium/SeleniumView";
	}
	
	@PostMapping(value = "/selenium/updateView")
	public String SeleniumUpdateView(Model model, int seleniumKeyNum) {
		Selenium selenium = seleniumService.getSeleniumOne(seleniumKeyNum);
		model.addAttribute("selenium", selenium);
		return "/selenium/SeleniumView";
	}
	
	@ResponseBody
	@PostMapping(value = "/selenium/insert")
	public Map InsertSelenium(Selenium selenium, Principal principal) {
		String result = "";

		Map<String, Object> map = new HashMap<>();
		if(selenium.getSeleniumKeyNum() == null) {
			selenium.setSeleniumRegistrant(principal.getName());
			selenium.setSeleniumRegistrationDate(seleniumService.nowDate());
			result = seleniumService.insertSelenium(selenium);
		} else {
			selenium.setSeleniumModifier(principal.getName());
			selenium.setSeleniumModifiedDate(seleniumService.nowDate());
			result = seleniumService.updateSelenium(selenium);
		}
		
		map.put("seleniumKeyNum", selenium.getSeleniumKeyNum());
		map.put("result", result);
		return map;
	}
}
