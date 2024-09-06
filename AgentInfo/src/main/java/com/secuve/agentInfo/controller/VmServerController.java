package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.util.ArrayList;
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
import com.secuve.agentInfo.service.VmServerService;
import com.secuve.agentInfo.vo.VmServer;

@Controller
public class VmServerController {
	@Autowired VmServerService vmServerService;
	@Autowired FavoritePageService favoritePageService;
	
	@GetMapping(value = "/vmServer/list")
	public String VmServers(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "서버 목록 - VM 서버");
		
		List<String> vmServerHostName = vmServerService.getSelectInput("vmServerHostName");
		List<String> vmServerName = vmServerService.getSelectInput("vmServerName");
		
		model.addAttribute("vmServerHostName", vmServerHostName);
		model.addAttribute("vmServerName", vmServerName);

		return "vmServer/VmVmServer";
	}
	
	@ResponseBody
	@PostMapping(value = "/vmServer")
	public Map<String, Object> Server(VmServer search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<VmServer> list = new ArrayList<>(vmServerService.getVmServer(search));

		int totalCount = vmServerService.getVmServerCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float)totalCount/search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
}
