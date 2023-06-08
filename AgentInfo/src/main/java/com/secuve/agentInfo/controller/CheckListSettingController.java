package com.secuve.agentInfo.controller;

import java.security.Principal;
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
		List<CheckListSetting> checkListSettingFormTOSMS = checkListSettingService.checkListSettingForm(checkListSettingType, "TOSMS");
		List<CheckListSetting> checkListSettingFormAgent = checkListSettingService.checkListSettingForm(checkListSettingType, "Agent");
		List<CheckListSetting> checkListSettingCategory = checkListSettingService.checkListSettingCategory();
		List<CheckListSetting> checkListSettingSubCategory = checkListSettingService.checkListSettingSubCategory();
		model.addAttribute("checkListSettingType", checkListSettingType);
		model.addAttribute("checkListSettingFormTOSMS",checkListSettingFormTOSMS);
		model.addAttribute("checkListSettingFormAgent",checkListSettingFormAgent);
		model.addAttribute("checkListSettingCategory",checkListSettingCategory);
		model.addAttribute("checkListSettingSubCategory",checkListSettingSubCategory);
		return "/checkListSetting/CheckListSetting";
	}
	
	@ResponseBody
	@PostMapping(value = "/checkListSetting/formPlus")
	public int formPlus(CheckListSetting checkListSetting, Principal principal) {
		checkListSetting.setCheckListSettingFormRegistrant(principal.getName());
		checkListSetting.setCheckListSettingFormRegistrationDate(checkListSettingService.nowDate());
		return checkListSettingService.formPlus(checkListSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/checkListSetting/formChange")
	public String formChange(CheckListSetting checkListSetting, Principal principal) {
		checkListSetting.setCheckListSettingFormModifier(principal.getName());
		checkListSetting.setCheckListSettingFormModifiedDate(checkListSettingService.nowDate());
		return checkListSettingService.formChange(checkListSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/checkListSetting/formMinus")
	public String formMinus(Integer checkListSettingFormKeyNum) {
		return checkListSettingService.formMinus(checkListSettingFormKeyNum);
	}
	
	@ResponseBody
	@PostMapping(value = "/checkListSetting/categoryPlus")
	public int categoryPlus(CheckListSetting checkListSetting, Principal principal) {
		checkListSetting.setCheckListSettingCategoryRegistrant(principal.getName());
		checkListSetting.setCheckListSettingCategoryRegistrationDate(checkListSettingService.nowDate());
		return checkListSettingService.categoryPlus(checkListSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/checkListSetting/subCategoryPlus")
	public int subCategoryPlus(CheckListSetting checkListSetting, Principal principal) {
		checkListSetting.setCheckListSettingSubCategoryRegistrant(principal.getName());
		checkListSetting.setCheckListSettingSubCategoryRegistrationDate(checkListSettingService.nowDate());
		return checkListSettingService.subCategoryPlus(checkListSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/checkListSetting/categorySave")
	public String categorySave(CheckListSetting checkListSetting, Principal principal) {
		checkListSetting.setCheckListSettingCategoryModifier(principal.getName());
		checkListSetting.setCheckListSettingCategoryModifiedDate(checkListSettingService.nowDate());
		return checkListSettingService.categorySave(checkListSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/checkListSetting/subCategorySave")
	public String subCategorySave(CheckListSetting checkListSetting, Principal principal) {
		checkListSetting.setCheckListSettingSubCategoryModifier(principal.getName());
		checkListSetting.setCheckListSettingSubCategoryModifiedDate(checkListSettingService.nowDate());
		return checkListSettingService.subCategorySave(checkListSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/checkListSetting/categoryMinus")
	public String categoryMinus(CheckListSetting checkListSetting) {
		return checkListSettingService.categoryMinus(checkListSetting);
	}
	
	@ResponseBody
	@PostMapping(value = "/checkListSetting/subCategoryMinus")
	public String subCategoryMinus(CheckListSetting checkListSetting) {
		return checkListSettingService.subCategoryMinus(checkListSetting);
	}
	
	@GetMapping(value = "/checkListSetting/detailView")
	public String detailView(CheckListSetting checkListSetting, Model model) {
		CheckListSetting checkListSettingDetail = checkListSettingService.checkListSettingDetail(checkListSetting.getCheckListSettingSubCategoryKeyNum());
		model.addAttribute("checkListSetting", checkListSetting);
		model.addAttribute("checkListSettingDetail", checkListSettingDetail);
		return "/checkListSetting/CheckListSettingDetail";
	}
	
	@ResponseBody
	@PostMapping(value = "/checkListSetting/detailSave")
	public String detailSave(CheckListSetting checkListSetting, Principal principal) {
		checkListSetting.setCheckListSettingDetailRegistrant(principal.getName());
		checkListSetting.setCheckListSettingDetailRegistrationDate(checkListSettingService.nowDate());
		checkListSetting.setCheckListSettingDetailModifier(principal.getName());
		checkListSetting.setCheckListSettingDetailModifiedDate(checkListSettingService.nowDate());
		return checkListSettingService.checkListSettingDetailSave(checkListSetting);
	}
}
