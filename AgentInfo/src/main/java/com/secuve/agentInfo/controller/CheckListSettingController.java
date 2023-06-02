package com.secuve.agentInfo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.secuve.agentInfo.service.CheckListSettingService;
import com.secuve.agentInfo.vo.CheckListSetting;

@Controller
public class CheckListSettingController {
	@Autowired CheckListSettingService checkListSettingService;
	
	@GetMapping(value = "/checkListSetting/setting")
	public String CustomerList(Model model, String checkListSettingType) {
		List<CheckListSetting> checkListSettingForm = checkListSettingService.checkListSettingForm();
		model.addAttribute("checkListSettingType", checkListSettingType);
		model.addAttribute("checkListSettingForm",checkListSettingForm);
		return "/checkListSetting/CheckListSetting";
	}
}
