package com.secuve.agentInfo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class GeneralPackageController {
	@GetMapping(value = "/releaseNotes/generalPackage")
	public String GeneralPackage( Model model) {
		return "releaseNotes/GeneralPackage";
	}
}
