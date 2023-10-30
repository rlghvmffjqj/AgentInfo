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

import com.secuve.agentInfo.service.FunctionTestService;
import com.secuve.agentInfo.service.FunctionTestSettingService;
import com.secuve.agentInfo.vo.FunctionTest;
import com.secuve.agentInfo.vo.FunctionTestSetting;

@Controller
public class FunctionTestController {
	@Autowired FunctionTestService functionTestService;
	@Autowired FunctionTestSettingService functionTestSettingService;
	
	@GetMapping(value = "/functionTest/list")
	public String functionTestList(String functionTestType, Model model) {
		model.addAttribute("functionTestType",functionTestType);
		return "functionTest/FunctionTest";
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTest")
	public Map<String, Object> functionTest(FunctionTest search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<FunctionTest> list = new ArrayList<>(functionTestService.getFunctionTest(search));

		int totalCount = functionTestService.getFunctionTestCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@GetMapping(value = "/functionTest/view")
	public String ExistingNew(String functionTestType, Model model) {
		List<FunctionTestSetting> functionTestSettingFormTOSMS = functionTestSettingService.functionTestForm("TOSMS", functionTestType);
		List<FunctionTestSetting> functionTestSettingFormAgent = functionTestSettingService.functionTestForm("Agent", functionTestType);
		List<FunctionTestSetting> functionTestSettingCategory = functionTestSettingService.functionTestCategory(functionTestType);
		List<FunctionTestSetting> functionTestSettingSubCategory = functionTestSettingService.functionTestSubCategory(functionTestType);
		FunctionTest functionTest = new FunctionTest();
		functionTest.setFunctionTestKeyNum(0);
		
		model.addAttribute("functionTestSettingFormTOSMS",functionTestSettingFormTOSMS);
		model.addAttribute("functionTestSettingFormAgent",functionTestSettingFormAgent);
		model.addAttribute("functionTestSettingCategory",functionTestSettingCategory);
		model.addAttribute("functionTestSettingSubCategory",functionTestSettingSubCategory);
		model.addAttribute("viewType","insert");
		model.addAttribute("functionTestTitle",functionTest);
		model.addAttribute("functionTestType",functionTestType);
		model.addAttribute("functionTestSettingFormKeyNumMin", functionTestSettingService.getFunctionTestSettingFormKeyNumMin());
		return "/functionTest/FunctionTestView";
	}
	
	@GetMapping(value = "/functionTest/detailView")
	public String detailView(FunctionTestSetting functionTestSetting, Model model) {
		FunctionTestSetting functionTestSettingDetail = functionTestSettingService.functionTestSettingDetail(functionTestSetting.getFunctionTestSettingSubCategoryKeyNum());
		model.addAttribute("functionTestSettingDetail", functionTestSettingDetail);
		return "/functionTest/FunctionTestDetail";
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTest/functionTestSave")
	public Map FunctionTestSave(FunctionTest functionTest, Principal principal) {
		functionTest.setFunctionTestRegistrant(principal.getName());
		functionTest.setFunctionTestRegistrationDate(functionTestService.nowDate());
		
		Map result = functionTestService.insertFunctionTest(functionTest, principal);
		return result;
	}
	
	@GetMapping(value = "/functionTest/updateView")
	public String UpdateView(Model model, Principal principal, int functionTestKeyNum, String functionTestType) {
		FunctionTest functionTestTitle = functionTestService.getFunctionTestOneTitle(functionTestKeyNum);
		ArrayList<FunctionTest> functionTest = new ArrayList<>(functionTestService.getFunctionTestOne(functionTestKeyNum));
		
		List<FunctionTestSetting> functionTestSettingFormTOSMS = functionTestSettingService.functionTestForm("TOSMS", functionTestType);
		List<FunctionTestSetting> functionTestSettingFormAgent = functionTestSettingService.functionTestForm("Agent", functionTestType);
		List<FunctionTestSetting> functionTestSettingCategory = functionTestSettingService.functionTestCategory(functionTestType);
		List<FunctionTestSetting> functionTestSettingSubCategory = functionTestSettingService.functionTestSubCategory(functionTestType);
		List<Integer> functionTestFunctionTestSettingSubCategoryKeyNum = functionTestService.functionTestFunctionTestSettingSubCategoryKeyNum(functionTestKeyNum);
		
		model.addAttribute("functionTestSettingFormTOSMS",functionTestSettingFormTOSMS);
		model.addAttribute("functionTestSettingFormAgent",functionTestSettingFormAgent);
		model.addAttribute("functionTestSettingCategory",functionTestSettingCategory);
		model.addAttribute("functionTestSettingSubCategory",functionTestSettingSubCategory);
		model.addAttribute("viewType", "update");
		model.addAttribute("functionTestTitle", functionTestTitle);
		model.addAttribute("functionTest",functionTest);
		model.addAttribute("functionTestFunctionTestSettingSubCategoryKeyNum", functionTestFunctionTestSettingSubCategoryKeyNum);
		model.addAttribute("functionTestType",functionTestType);
		model.addAttribute("functionTestSettingFormKeyNumMin", functionTestSettingService.getFunctionTestSettingFormKeyNumMin());
		return "functionTest/FunctionTestView";
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTest/delete")
	public String FunctionTestDelete(@RequestParam int[] chkList) {
		return functionTestService.delFunctionTest(chkList);
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTest/update")
	public Map FunctionTestUpdate(FunctionTest functionTest, Principal principal) {
		functionTest.setFunctionTestModifier(principal.getName());
		functionTest.setFunctionTestModifiedDate(functionTestService.nowDate());
		
		Map result = functionTestService.updateFunctionTest(functionTest, principal);
		return result;
	}
}
