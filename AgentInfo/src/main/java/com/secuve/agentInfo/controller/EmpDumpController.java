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

import com.secuve.agentInfo.service.EmpDumpService;
import com.secuve.agentInfo.service.FavoritePageService;

@Controller
public class EmpDumpController {
	@Autowired EmpDumpService empDumpService;
	@Autowired FavoritePageService favoritePageService;
	
	@GetMapping(value = "/empDump/list")
	public String empDumpList(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "고객사 인사정보 파일");
		

		return "empDump/EmpDumpList";
	}
	
	@ResponseBody
	@PostMapping(value = "/empDumpEmpty")
	public Map<String, Object> empDumpEmpty() {
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("page", 0);
		map.put("total", 0);
		map.put("records", 0);
		map.put("rows", null);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/empDump/create")
	public String create(String empDumpCount, String empDumpCustomer) {
		empDumpService.create(empDumpCount, empDumpCustomer);
		return "OK";
	}
	
}
