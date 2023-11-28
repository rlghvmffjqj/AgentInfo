package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.ServiceControlService;
import com.secuve.agentInfo.vo.License5;

@Controller
public class ServiceControlController {
	@Autowired ServiceControlService serviceControlService;
	
	@GetMapping(value = "/serviceControl/list")
	public String ServiceControl(Model model) {
		return "serviceControl/ServiceControlList";
	}
	
	@PostMapping(value = "/serviceControl/insertView")
	public String ServiceControlAdd(Model model) {
		return "/serviceControl/ServiceControlAdd";
	}
	
	@ResponseBody
	@PostMapping(value = "/serviceControl/insert")
	public Map<String, String> ServiceControlInsert(Principal principal) throws ParseException {
		Map<String, String> map = new HashMap<String, String>();
		String result = serviceControlService.serviceControlInsert();
		map.put("result", result);
		return map;
	}
}
