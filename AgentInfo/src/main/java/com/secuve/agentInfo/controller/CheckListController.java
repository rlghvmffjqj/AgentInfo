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

import com.secuve.agentInfo.service.CheckListService;
import com.secuve.agentInfo.service.CheckListSettingService;
import com.secuve.agentInfo.vo.CheckList;
import com.secuve.agentInfo.vo.CheckListSetting;

@Controller
public class CheckListController {
	@Autowired CheckListService checkListService;
	@Autowired CheckListSettingService checkListSettingService;
	
	@GetMapping(value = "/checkList/list")
	public String checkListList(Model model) {
		
		return "checkList/CheckList";
	}
	
	@ResponseBody
	@PostMapping(value = "/checkList")
	public Map<String, Object> checkList(CheckList search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<CheckList> list = new ArrayList<>(checkListService.getCheckList(search));

		int totalCount = checkListService.getCheckListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@GetMapping(value = "/checkList/view")
	public String ExistingNew(Model model) {
		List<CheckListSetting> checkListSettingFormTOSMS = checkListSettingService.checkListSettingForm("TOSMS");
		List<CheckListSetting> checkListSettingFormAgent = checkListSettingService.checkListSettingForm("Agent");
		List<CheckListSetting> checkListSettingCategory = checkListSettingService.checkListSettingCategory();
		List<CheckListSetting> checkListSettingSubCategory = checkListSettingService.checkListSettingSubCategory();
		CheckList checkList = new CheckList();
		checkList.setCheckListKeyNum(0);
		
		model.addAttribute("checkListSettingFormTOSMS",checkListSettingFormTOSMS);
		model.addAttribute("checkListSettingFormAgent",checkListSettingFormAgent);
		model.addAttribute("checkListSettingCategory",checkListSettingCategory);
		model.addAttribute("checkListSettingSubCategory",checkListSettingSubCategory);
		model.addAttribute("viewType","insert");
		model.addAttribute("checkListTitle",checkList);
		return "/checkList/CheckListView";
	}
	
	@GetMapping(value = "/checkList/detailView")
	public String detailView(CheckListSetting checkListSetting, Model model) {
		CheckListSetting checkListSettingDetail = checkListSettingService.checkListSettingDetail(checkListSetting.getCheckListSettingSubCategoryKeyNum());
		model.addAttribute("checkListSettingDetail", checkListSettingDetail);
		return "/checkList/CheckListDetail";
	}
	
	@ResponseBody
	@PostMapping(value = "/checkList/checkListSave")
	public Map CheckListSave(CheckList checkList, Principal principal) {
		checkList.setCheckListRegistrant(principal.getName());
		checkList.setCheckListRegistrationDate(checkListService.nowDate());
		
		Map result = checkListService.insertCheckList(checkList, principal);
		return result;
	}
	
	@GetMapping(value = "/checkList/updateView")
	public String UpdateView(Model model, Principal principal, int checkListKeyNum) {
		CheckList checkListTitle = checkListService.getCheckListOneTitle(checkListKeyNum);
		ArrayList<CheckList> checkList = new ArrayList<>(checkListService.getCheckListOne(checkListKeyNum));
		
		List<CheckListSetting> checkListSettingFormTOSMS = checkListSettingService.checkListSettingForm("TOSMS");
		List<CheckListSetting> checkListSettingFormAgent = checkListSettingService.checkListSettingForm("Agent");
		List<CheckListSetting> checkListSettingCategory = checkListSettingService.checkListSettingCategory();
		List<CheckListSetting> checkListSettingSubCategory = checkListSettingService.checkListSettingSubCategory();
		List<Integer> checkListCheckListSettingSubCategoryKeyNum = checkListService.checkListCheckListSettingSubCategoryKeyNum(checkListKeyNum);
		
		model.addAttribute("checkListSettingFormTOSMS",checkListSettingFormTOSMS);
		model.addAttribute("checkListSettingFormAgent",checkListSettingFormAgent);
		model.addAttribute("checkListSettingCategory",checkListSettingCategory);
		model.addAttribute("checkListSettingSubCategory",checkListSettingSubCategory);
		model.addAttribute("viewType", "update");
		model.addAttribute("checkListTitle", checkListTitle);
		model.addAttribute("checkList",checkList);
		model.addAttribute("checkListCheckListSettingSubCategoryKeyNum", checkListCheckListSettingSubCategoryKeyNum);
		return "checkList/CheckListView";
	}
	
	@ResponseBody
	@PostMapping(value = "/checkList/delete")
	public String CheckListDelete(@RequestParam int[] chkList) {
		return checkListService.delCheckList(chkList);
	}
	
	@ResponseBody
	@PostMapping(value = "/checkList/update")
	public Map CheckListUpdate(CheckList checkList, Principal principal) {
		checkList.setCheckListModifier(principal.getName());
		checkList.setCheckListModifiedDate(checkListService.nowDate());
		
		Map result = checkListService.updateCheckList(checkList, principal);
		return result;
	}
	
}
