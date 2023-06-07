package com.secuve.agentInfo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.CheckListSettingService;
import com.secuve.agentInfo.vo.CheckListSetting;

@Controller
public class CheckListSettingController {
	@Autowired CheckListSettingService checkListSettingService;
	
	@GetMapping(value = "/checkListSetting/setting")
	public String CustomerList(Model model, String checkListSettingType) {
		List<CheckListSetting> checkListSettingForm = checkListSettingService.checkListSettingForm(checkListSettingType);
		List<CheckListSetting> checkListSettingCategory = checkListSettingService.checkListSettingCategory();
		List<CheckListSetting> checkListSettingSubCategory = checkListSettingService.checkListSettingSubCategory();
		model.addAttribute("checkListSettingType", checkListSettingType);
		model.addAttribute("checkListSettingForm",checkListSettingForm);
		model.addAttribute("checkListSettingCategory",checkListSettingCategory);
		model.addAttribute("checkListSettingSubCategory",checkListSettingSubCategory);
		return "/checkListSetting/CheckListSetting";
	}
	
	@ResponseBody
	@PostMapping(value = "/checkListSetting/formPlus")
	public int formPlus(CheckListSetting checkListSetting) {
		return checkListSettingService.formPlus(checkListSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/checkListSetting/formChange")
	public String formChange(CheckListSetting checkListSetting) {
		return checkListSettingService.formChange(checkListSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/checkListSetting/formMinus")
	public String formMinus(Integer checkListSettingFormKeyNum) {
		return checkListSettingService.formMinus(checkListSettingFormKeyNum);
	}
	
	@ResponseBody
	@PostMapping(value = "/checkListSetting/categoryPlus")
	public int categoryPlus(CheckListSetting checkListSetting) {
		return checkListSettingService.categoryPlus(checkListSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/checkListSetting/subCategoryPlus")
	public int subCategoryPlus(CheckListSetting checkListSetting) {
		return checkListSettingService.subCategoryPlus(checkListSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/checkListSetting/categorySave")
	public String categorySave(CheckListSetting checkListSetting) {
		return checkListSettingService.categorySave(checkListSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/checkListSetting/subCategorySave")
	public String subCategorySave(CheckListSetting checkListSetting) {
		return checkListSettingService.subCategorySave(checkListSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/checkListSetting/categoryMinus")
	public String categoryMinus(CheckListSetting checkListSetting) {
		return checkListSettingService.categoryMinus(checkListSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/checkListSetting/categorySubCategoryMinus")
	public void categorySubCategoryMinus(CheckListSetting checkListSetting) {
		checkListSettingService.categorySubCategoryMinus(checkListSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/checkListSetting/subCategoryMinus")
	public String subCategoryMinus(CheckListSetting checkListSetting) {
		return checkListSettingService.subCategoryMinus(checkListSetting);
	}
	
	
}
