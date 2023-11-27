package com.secuve.agentInfo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.secuve.agentInfo.service.ServiceControlService;
import com.secuve.agentInfo.vo.License5;

@Controller
public class ServiceControlController {
	@Autowired ServiceControlService serviceControlService;
	
	@GetMapping(value = "/serviceControl/list")
	public String ServiceControl(Model model) {
		return "serviceControl/ServiceControlList";
	}
	
	@PostMapping(value = "/serviceControl/add")
	public String ServiceControlAdd(License5 license, Model model) {
		return "/serviceControl/ServiceControlAdd";
	}
}
