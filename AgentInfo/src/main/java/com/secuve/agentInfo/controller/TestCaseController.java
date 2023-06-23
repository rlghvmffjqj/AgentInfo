package com.secuve.agentInfo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.secuve.agentInfo.service.TestCaseService;

@Controller
public class TestCaseController {
	@Autowired TestCaseService testCaseService;
	
	@GetMapping(value = "/testCase/list")
	public String TestCaseList(Model model) {

		return "testCase/TestCaseList";
	}
}
