package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.core.Util;
import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.ServerListService;
import com.secuve.agentInfo.vo.ServerList;

@Controller
public class ServerListController {
	@Autowired ServerListService serverListService;
	@Autowired FavoritePageService favoritePageService;
	
	@GetMapping(value = "/serverList/list")
	public String ServerLists(Model model, String serverListType, Principal principal, HttpServletRequest req) {
		String pageName = "서버 목록 - ";
		if(serverListType.equals("externalEquipment"))
			pageName += "외부망 장비";
		else if(serverListType.equals("internalEquipment"))
			pageName += "내부망 장비";
		else if(serverListType.equals("hyperV"))
			pageName += "Hyper-V";	
		favoritePageService.insertFavoritePage(principal, req, pageName);
		
		List<String> serverListIp = serverListService.getSelectInput(serverListType, "serverListIp");
		List<String> serverListMac = serverListService.getSelectInput(serverListType, "serverListMac");
		List<String> serverListAssetNum = serverListService.getSelectInput(serverListType, "serverListAssetNum");
		List<String> serverListHostName = serverListService.getSelectInput(serverListType, "serverListHostName");
		List<String> serverListPurpose = serverListService.getSelectInput(serverListType, "serverListPurpose");
		List<String> serverListOs = serverListService.getSelectInput(serverListType, "serverListOs");
		List<String> serverListServerClass = serverListService.getSelectInput(serverListType, "serverListServerClass");
		List<String> serverListLastModifiedDate = serverListService.getSelectInput(serverListType, "serverListLastModifiedDate");
		
		model.addAttribute("serverListIp", serverListIp);
		model.addAttribute("serverListMac", serverListMac);
		model.addAttribute("serverListAssetNum", serverListAssetNum);
		model.addAttribute("serverListHostName", serverListHostName);
		model.addAttribute("serverListPurpose", serverListPurpose);
		model.addAttribute("serverListOs", serverListOs);
		model.addAttribute("serverListServerClass", serverListServerClass);
		model.addAttribute("serverListLastModifiedDate", serverListLastModifiedDate);
		model.addAttribute("serverListType", serverListType);

		return "serverList/ServerList";
	}
	
	@ResponseBody
	@PostMapping(value = "/serverList")
	public Map<String, Object> Server(ServerList search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<ServerList> list = new ArrayList<>(serverListService.getServerList(search));

		int totalCount = serverListService.getServerListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float)totalCount/search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@PostMapping(value = "/serverList/insertView")
	public String InsertServerView(Model model, ServerList serverList, String serverListType) {
		serverList.setNowDate(serverListService.nowDateYMD());
		model.addAttribute("serverListType", serverListType);
		model.addAttribute("viewType", "insert").addAttribute("serverList", serverList);
		return "/serverList/ServerView";
	}
	
	@ResponseBody
	@PostMapping(value = "/serverList/insert")
	public Map<String, String> InsertServerList(ServerList serverList, Principal principal) {
		serverList.setServerListRegistrant(principal.getName());
		serverList.setServerListRegistrationDate(serverListService.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		String result = serverListService.insertServerList(serverList, principal.getName());
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/serverList/delete")
	public String ServerListDelete(@RequestParam int[] chkList, Principal principal) {
		return serverListService.delServerList(chkList, principal);
	}
	
	@PostMapping(value = "/serverList/updateView")
	public String UpdateServerListView(Model model, int serverListKeyNum) {
		ServerList serverList = serverListService.getServerListOne(serverListKeyNum);
		model.addAttribute("viewType", "update").addAttribute("serverList", serverList);
		return "/serverList/ServerView";
	}
	
	@ResponseBody
	@PostMapping(value = "/serverList/update")
	public Map<String, String> UpdateServerList(ServerList serverList, Principal principal) {
		serverList.setServerListModifier(principal.getName());
		serverList.setServerListModifiedDate(serverListService.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		String result = serverListService.updateServerList(serverList, principal.getName());
		map.put("result", result);
		return map;
	}
	
	@PostMapping(value = "/serverList/stateView")
	public String stateView() {
		return "/serverList/ServerState";
	}
	
	@ResponseBody
	@PostMapping(value = "/serverList/stateChange")
	public Map<String, String> stateChange(@RequestParam int[] chkList, @RequestParam String stateView, Principal principal) {

		Map<String, String> map = new HashMap<String, String>();
		String result = serverListService.stateChange(chkList, stateView);
		map.put("result", result);
		return map;
	}
	
	@PostMapping(value = "/serverList/export")
	public void exportServerList(@ModelAttribute ServerList serverList, @RequestParam String[] columns,
			@RequestParam String[] headers, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String type = "None";
		if(serverList.getServerListType() == "externalEquipment" || serverList.getServerListType().equals("externalEquipment")) {
			type = "외부망 장비 - ";
		} else if(serverList.getServerListType() == "internalEquipment" || serverList.getServerListType().equals("internalEquipment")) {
			type = "내부망 장비 - ";
		} else {
			type = "Hyper-V - ";
		}
		String filename = type + formatter.format(now) + ".xls";

		List list = serverListService.getServerListSearchAll(serverList);

		try {
			Util.exportExcelFile(response, filename, list, columns, headers);
		} catch (Exception e) {
			System.out.println("FAIL: Export failed.\n" + e.toString());
		}
	}
}
