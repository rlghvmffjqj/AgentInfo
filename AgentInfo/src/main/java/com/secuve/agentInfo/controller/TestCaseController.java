package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.TestCaseService;
import com.secuve.agentInfo.vo.TestCase;

@Controller
public class TestCaseController {
	@Autowired TestCaseService testCaseService;
	
	@GetMapping(value = "/testCase/list")
	public String TestCaseList(Model model) {
		List<String> testCaseFormList = testCaseService.getTestCaseForm();
		
		model.addAttribute("testCaseFormList",testCaseFormList);
		return "testCase/TestCaseList";
	}
	
	@PostMapping(value = "/testCase/insertFormView")
	public String InsertTestCaseView(Model model) {
		model.addAttribute("viewType", "insert");
		return "/testCase/TestCaseFormView";
	}
	
	@ResponseBody
	@PostMapping(value = "/testCase/insertForm")
	public String insertTestCaseForm(TestCase testCase, Principal principal) {
		testCase.setTestCaseFormRegistrant(principal.getName());
		testCase.setTestCaseFormRegistrationDate(testCaseService.nowDate());
		return testCaseService.insertTestCaseForm(testCase);
	}
	
	@ResponseBody
	@PostMapping(value = "/testCase/delTestCaseForm")
	public String delTestCaseForm(TestCase testCase) {
		return testCaseService.delTestCaseForm(testCase);
	}
	
	@PostMapping(value = "/testCase/updateFormView")
	public String updateTestCaseView(String testCaseFormName, Model model) {
		model.addAttribute("viewType", "update");
		model.addAttribute("testCaseFormName", testCaseFormName);
		return "/testCase/TestCaseFormView";
	}
	
	@ResponseBody
	@PostMapping(value = "/testCase/updateForm")
	public String updateTestCaseForm(TestCase testCase, Principal principal) {
		testCase.setTestCaseFormModifier(principal.getName());
		testCase.setTestCaseFormModifiedDate(testCaseService.nowDate());
		return testCaseService.updateTestCaseForm(testCase);
	}
}
