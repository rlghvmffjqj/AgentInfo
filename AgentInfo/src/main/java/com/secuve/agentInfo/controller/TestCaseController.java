package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.TestCaseService;
import com.secuve.agentInfo.vo.TestCase;

@Controller
public class TestCaseController {
	@Autowired TestCaseService testCaseService;
	
	@GetMapping(value = "/testCase/list")
	public String TestCaseList(Model model) {
		List<String> testCaseFormList = testCaseService.getTestCaseForm();
		List<String> testCaseRouteCustomer = testCaseService.getSearchValue("testCaseRouteCustomer");
		List<String> testCaseRouteNote = testCaseService.getSearchValue("testCaseRouteNote");
		
		model.addAttribute("testCaseRouteNote",testCaseRouteNote);
		model.addAttribute("testCaseRouteCustomer",testCaseRouteCustomer);
		model.addAttribute("testCaseFormList",testCaseFormList);
		return "testCase/TestCaseList";
	}
	
	@ResponseBody
	@PostMapping(value = "/testCase")
	public Map<String, Object> Package(TestCase search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<TestCase> list = new ArrayList<>(testCaseService.getTestCaseList(search));

		int totalCount = testCaseService.getTestCaseListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@GetMapping(value = "/testCase/insertTestCaseView")
	public String insertTestCaseView(TestCase testCase, Model model) {
		model.addAttribute("viewType", "insert");
		model.addAttribute("testCaseFormName",testCase.getTestCaseFormName());
		return "testCase/TestCaseView";
	}
	
	@PostMapping(value = "/testCase/updateTestCaseView")
	public String updateTestCaseView(String testCaseRouteCustomerView, String testCaseRouteNoteView, String testCaseFormNameView, Model model) {
		model.addAttribute("viewType", "update");
		model.addAttribute("testCaseFormName",testCaseFormNameView);
		model.addAttribute("testCaseRouteNote",testCaseRouteNoteView);
		model.addAttribute("testCaseRouteCustomer",testCaseRouteCustomerView);
		return "testCase/TestCaseView";
	}
	
	
	/* ==================================================================== */
	
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
	public String updateFormView(String testCaseFormName, Model model) {
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
	
	
	/* ==================================================================== */
	
	@ResponseBody
	@PostMapping(value = "/testCase/routeList")
	public Object routeList(TestCase testCase) {
		return testCaseService.getRouteList(testCase);
	}
	
	@PostMapping(value = "/testCase/insertRouteView")
	public String insertRouteView(Model model, @RequestParam String testCaseRouteFullPath) {
		model.addAttribute("viewType","insert").addAttribute("testCaseRouteFullPath", testCaseRouteFullPath);
		return "/testCase/TestCaseRouteView";
	}
	
	@ResponseBody
	@PostMapping(value = "/testCase/insertRoute")
	public Map<String,String> insertRoute(TestCase testCase, Principal principal) {
		testCase.setTestCaseRouteRegistrant(principal.getName());
		testCase.setTestCaseRouteRegistrationDate(testCaseService.nowDate());
		testCase.setTestCaseRouteModifier(principal.getName());
		testCase.setTestCaseRouteModifiedDate(testCaseService.nowDate());
		testCase.setTestCaseRouteDate(testCaseService.nowDate());
		
		Map<String,String> map = new HashMap<String,String>();
		String result = testCaseService.insertRoute(testCase);
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/testCase/deleteRoute")
	public Map<String,String> deleteRoute(TestCase testCase) {
		Map<String,String> map = new HashMap<String,String>();
		String result = testCaseService.deleteRoute(testCase);
		map.put("result", result);
		return map;
	}
	
	@PostMapping(value = "/testCase/updateRouteView")
	public String updateRouteView(Model model, @RequestParam String testCaseRouteFullPath) {
		model.addAttribute("viewType","update").addAttribute("testCaseRouteFullPath", testCaseRouteFullPath);
		return "/testCase/TestCaseRouteView";
	}
	
	@ResponseBody
	@PostMapping(value = "/testCase/updateRoute")
	public Map<String,String> updateRoute(TestCase testCase, Principal principal) {
		testCase.setTestCaseRouteModifier(principal.getName());
		testCase.setTestCaseRouteModifiedDate(testCaseService.nowDate());
		testCase.setTestCaseRouteDate(testCaseService.nowDate());
		
		Map<String,String> map = new HashMap<String,String>();
		String result = testCaseService.updateRoute(testCase);
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/testCase/testCaseConfirmed")
	public String testCaseConfirmed(TestCase testCase) {
		return testCaseService.testCaseConfirmed(testCase);
	}
}