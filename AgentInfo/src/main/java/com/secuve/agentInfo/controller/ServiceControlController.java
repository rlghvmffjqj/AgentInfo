package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.text.ParseException;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.ServiceControlService;
import com.secuve.agentInfo.vo.ServiceControl;

@Controller
public class ServiceControlController {
	@Autowired ServiceControlService serviceControlService;
	@Autowired FavoritePageService favoritePageService;
	
	@GetMapping(value = "/serviceControl/list")
	public String ServiceControl(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "서비스 제어");
		List<String> serviceControlPurpose = serviceControlService.getServiceControlValue("serviceControlPurpose");
		List<String> serviceControlIp = serviceControlService.getServiceControlValue("serviceControlIp");
		model.addAttribute("serviceControlPurpose", serviceControlPurpose);
		model.addAttribute("serviceControlIp", serviceControlIp);
		return "serviceControl/ServiceControlList";
	}
	
	@ResponseBody
	@PostMapping(value = "/serviceControl")
	public Map<String, Object> ServiceControl(ServiceControl search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<ServiceControl
		> list = new ArrayList<>(serviceControlService.getServiceControlList(search));

		int totalCount = serviceControlService.getServiceControlListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@PostMapping(value = "/serviceControl/insertView")
	public String ServiceControlAdd(Model model) {
		return "/serviceControl/ServiceControlAdd";
	}
	
	@ResponseBody
	@PostMapping(value = "/serviceControl/insert")
	public String ServiceControlInsert(Principal principal, ServiceControl serviceControl) throws ParseException {
		if(serviceControlService.getServiceControlOne(serviceControl.getServiceControlIp()) != null) {
			return "duplication";
		}
		return serviceControlService.serviceControlInsert(serviceControl);
	}
	
	@ResponseBody
	@PostMapping(value = "/serviceControl/delete")
	public String ServiceControlDelete(@RequestParam int[] chkList, Principal principal) {
		return serviceControlService.delServiceControl(chkList, principal);
	}
	
	@ResponseBody
	@PostMapping(value = "/serviceControl/synchronization")
	public String ServiceControlSynchronization() {
		return serviceControlService.serviceControlSynchronization();
	}
}
