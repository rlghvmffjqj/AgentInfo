package com.secuve.agentInfo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CustomPackageController {
	@GetMapping(value = "/customPackage/List")
	public String CustomPackage( Model model) {
		return "customPackage/CustomPackageList";
	}
}
