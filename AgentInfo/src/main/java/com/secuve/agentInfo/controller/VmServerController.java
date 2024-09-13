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
import com.secuve.agentInfo.service.VmServerService;
import com.secuve.agentInfo.vo.VmServer;
import com.secuve.agentInfo.vo.VmServerHost;

@Controller
public class VmServerController {
	@Autowired VmServerService vmServerService;
	@Autowired FavoritePageService favoritePageService;
	
	@GetMapping(value = "/vmServer/list")
	public String VmServers(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "서버 목록 - VM 서버");
		
		List<String> vmServerHostName = vmServerService.getSelectInput("vmServerHostName");
		List<String> vmServerName = vmServerService.getSelectInput("vmServerName");
		List<String> vmServerStatus = vmServerService.getSelectInput("vmServerStatus");
		
		model.addAttribute("vmServerHostName", vmServerHostName);
		model.addAttribute("vmServerName", vmServerName);
		model.addAttribute("vmServerStatus", vmServerStatus);

		return "vmServer/VmServerList";
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
	
	@PostMapping(value = "/vmServer/insertView")
	public String InsertVmServerView(Model model) {
		return "/vmServer/VmServerHost";
	}
	
	@PostMapping(value = "/vmServer/deleteView")
	public String DeleteVmServerView(Model model) {
		List<String> vmServerHostName = vmServerService.getSelectInput("vmServerHostName");
		model.addAttribute("vmServerHostName", vmServerHostName);
		return "/vmServer/VmServerHostDel";
	}
	
	@ResponseBody
	@PostMapping(value = "/vmServer/insert")
	public String InsertVmServer(VmServerHost vmServerHost, Principal principal) {
		vmServerHost.setVmServerHostRegistrant(principal.getName());
		vmServerHost.setVmServerHostRegistrationDate(vmServerService.nowDate());

		return vmServerService.insertVmServerHost(vmServerHost);
	}
	
	@ResponseBody
	@PostMapping(value = "/vmServer/synchronization")
	public String SynchronizationVmServer() {
		return vmServerService.synchronization();
	}
	
	@ResponseBody
	@PostMapping(value = "/vmServer/delete")
	public String DeleteVmServer(VmServer vmServer) {
		return vmServerService.deleteVmServerHost(vmServer.getVmServerHostNameList());
	}
	
	@PostMapping(value = "/vmServer/export")
	public void exportServerList(@ModelAttribute VmServer vmServer, @RequestParam String[] columns,
			@RequestParam String[] headers, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

		
		String filename = "VM Server - "+formatter.format(now) + ".xls";

		List list = vmServerService.getVmServerSearchAll(vmServer);

		try {
			Util.exportExcelFile(response, filename, list, columns, headers);
		} catch (Exception e) {
			System.out.println("FAIL: Export failed.\n" + e.toString());
		}
	}
}
