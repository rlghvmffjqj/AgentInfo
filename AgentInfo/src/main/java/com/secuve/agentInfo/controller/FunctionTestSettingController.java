package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.FunctionTestSettingService;
import com.secuve.agentInfo.vo.FunctionTestSetting;

@Controller
public class FunctionTestSettingController {
	@Autowired FunctionTestSettingService functionTestSettingService;
	@Autowired FavoritePageService favoritePageService;
	
	@GetMapping(value = "/functionTestSetting/setting")
	public String CustomerList(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "설정 - 기능 테스트 설정");
		
		List<FunctionTestSetting> functionTestSettingFormTOSMS = functionTestSettingService.functionTestSettingForm("TOSMS");
		List<FunctionTestSetting> functionTestSettingFormAgent = functionTestSettingService.functionTestSettingForm("Agent");
		List<FunctionTestSetting> functionTestSettingCategory = functionTestSettingService.functionTestSettingCategory();
		List<FunctionTestSetting> functionTestSettingSubCategory = functionTestSettingService.functionTestSettingSubCategory();
		model.addAttribute("functionTestSettingFormTOSMS",functionTestSettingFormTOSMS);
		model.addAttribute("functionTestSettingFormAgent",functionTestSettingFormAgent);
		model.addAttribute("functionTestSettingCategory",functionTestSettingCategory);
		model.addAttribute("functionTestSettingSubCategory",functionTestSettingSubCategory);
		try {
			model.addAttribute("functionTestSettingFormKeyNumMin", functionTestSettingService.getFunctionTestSettingFormKeyNumMin("TOSMS"));
		} catch (Exception e) {
			model.addAttribute("functionTestSettingFormKeyNumMin", 0);
		}
		return "/functionTestSetting/FunctionTestSetting";
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTestSetting/formPlus")
	public int formPlus(FunctionTestSetting functionTestSetting, Principal principal) {
		functionTestSetting.setFunctionTestSettingFormRegistrant(principal.getName());
		functionTestSetting.setFunctionTestSettingFormRegistrationDate(functionTestSettingService.nowDate());
		return functionTestSettingService.formPlus(functionTestSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTestSetting/formChange")
	public String formChange(FunctionTestSetting functionTestSetting, Principal principal) {
		functionTestSetting.setFunctionTestSettingFormModifier(principal.getName());
		functionTestSetting.setFunctionTestSettingFormModifiedDate(functionTestSettingService.nowDate());
		return functionTestSettingService.formChange(functionTestSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTestSetting/formMinus")
	public String formMinus(Integer functionTestSettingFormKeyNum) {
		return functionTestSettingService.formMinus(functionTestSettingFormKeyNum);
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTestSetting/categoryPlus")
	public int categoryPlus(FunctionTestSetting functionTestSetting, Principal principal) {
		functionTestSetting.setFunctionTestSettingCategoryRegistrant(principal.getName());
		functionTestSetting.setFunctionTestSettingCategoryRegistrationDate(functionTestSettingService.nowDate());
		return functionTestSettingService.categoryPlus(functionTestSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTestSetting/subCategoryPlus")
	public int subCategoryPlus(FunctionTestSetting functionTestSetting, Principal principal) {
		functionTestSetting.setFunctionTestSettingSubCategoryRegistrant(principal.getName());
		functionTestSetting.setFunctionTestSettingSubCategoryRegistrationDate(functionTestSettingService.nowDate());
		return functionTestSettingService.subCategoryPlus(functionTestSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTestSetting/categorySave")
	public String categorySave(FunctionTestSetting functionTestSetting, Principal principal) {
		functionTestSetting.setFunctionTestSettingCategoryModifier(principal.getName());
		functionTestSetting.setFunctionTestSettingCategoryModifiedDate(functionTestSettingService.nowDate());
		return functionTestSettingService.categorySave(functionTestSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTestSetting/subCategorySave")
	public String subCategorySave(FunctionTestSetting functionTestSetting, Principal principal) {
		functionTestSetting.setFunctionTestSettingSubCategoryModifier(principal.getName());
		functionTestSetting.setFunctionTestSettingSubCategoryModifiedDate(functionTestSettingService.nowDate());
		return functionTestSettingService.subCategorySave(functionTestSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTestSetting/categoryMinus")
	public String categoryMinus(FunctionTestSetting functionTestSetting) {
		return functionTestSettingService.categoryMinus(functionTestSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTestSetting/subCategoryMinus")
	public String subCategoryMinus(FunctionTestSetting functionTestSetting) {
		return functionTestSettingService.subCategoryMinus(functionTestSetting);
	}
	
	@GetMapping(value = "/functionTestSetting/detailView")
	public String detailView(FunctionTestSetting functionTestSetting, Model model) {
		FunctionTestSetting functionTestSettingDetail = functionTestSettingService.functionTestSettingDetail(functionTestSetting.getFunctionTestSettingSubCategoryKeyNum());
		model.addAttribute("functionTestSetting", functionTestSetting);
		model.addAttribute("functionTestSettingDetail", functionTestSettingDetail);
		return "/functionTestSetting/FunctionTestSettingDetail";
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTestSetting/detailSave")
	public String detailSave(FunctionTestSetting functionTestSetting, Principal principal) {
		functionTestSetting.setFunctionTestSettingDetailRegistrant(principal.getName());
		functionTestSetting.setFunctionTestSettingDetailRegistrationDate(functionTestSettingService.nowDate());
		functionTestSetting.setFunctionTestSettingDetailModifier(principal.getName());
		functionTestSetting.setFunctionTestSettingDetailModifiedDate(functionTestSettingService.nowDate());
		return functionTestSettingService.functionTestSettingDetailSave(functionTestSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTestSetting/check")
	public void FunctionTestCheck(FunctionTestSetting functionTestSetting) {
		functionTestSettingService.updateFunctionTestSettingCheck(functionTestSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTestSetting/division")
	public int Division(String functionTestSettingDivision) {
		try {
			return functionTestSettingService.getFunctionTestSettingFormKeyNumMin(functionTestSettingDivision);
		} catch (Exception e) {
			return 0;
		}
	}
	
}
