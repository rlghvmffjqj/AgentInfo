package com.secuve.agentInfo.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.SeleniumGroupService;
import com.secuve.agentInfo.vo.Employee;
import com.secuve.agentInfo.vo.Selenium;
import com.secuve.agentInfo.vo.SeleniumGroup;

@Controller
public class SeleniumGroupController {
	
	@Autowired SeleniumGroupService seleniumGroupService;

	/**
	 * 부서 정보 가져오기
	 * @param parentPath
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/seleniumGroup/list")
	public Object SeleniumGroupList(@RequestParam String parentPath) {
		return seleniumGroupService.getSeleniumGroupList(parentPath);
	}
	
	/**
	 * 부서 추가 Modal
	 * @param model
	 * @param seleniumGroupFullPath
	 * @return
	 */
	@PostMapping(value = "/seleniumGroup/insertView")
	public String InsertEmployeeView(Model model, @RequestParam String seleniumGroupFullPath) {
		model.addAttribute("viewType","insert").addAttribute("seleniumGroupFullPath", seleniumGroupFullPath);
		return "/seleniumGroup/SeleniumGroupView";
	}
	
	/**
	 * 부서 추가
	 * @param seleniumGroup
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/seleniumGroup/insert")
	public Map<String,String> InsertEmployee(SeleniumGroup seleniumGroup) {
		Map<String,String> map = new HashMap<String,String>();
		String result = seleniumGroupService.insertSeleniumGroup(seleniumGroup);
		map.put("result", result);
		return map;
	}
	
	/**
	 * 부서 삭제
	 * @param seleniumGroup
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/seleniumGroup/delete")
	public Map<String,String> DeleteSeleniumGroup(SeleniumGroup seleniumGroup) {
		Map<String,String> map = new HashMap<String,String>();
		String result = seleniumGroupService.deleteSeleniumGroup(seleniumGroup);
		map.put("result", result);
		return map;
	}
	
	/**
	 * 부서 수정 Modal
	 * @param model
	 * @param seleniumGroupFullPath
	 * @return
	 */
	@PostMapping(value = "/seleniumGroup/updateView")
	public String UpdateEmployeeView(Model model, @RequestParam String seleniumGroupFullPath) {
		model.addAttribute("viewType","update").addAttribute("seleniumGroupFullPath", seleniumGroupFullPath);
		return "/seleniumGroup/SeleniumGroupView";
	}
	
	/**
	 * 부서 수정
	 * @param seleniumGroup
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/seleniumGroup/update")
	public Map<String,String> updateEmployee(SeleniumGroup seleniumGroup) {
		Map<String,String> map = new HashMap<String,String>();
		String result = seleniumGroupService.updateSeleniumGroup(seleniumGroup);
		map.put("result", result);
		return map;
	}
	
	/**
	 * 부서 이동
	 * @return
	 */
	@PostMapping(value = "/seleniumGroup/seleniumGroupCopyView")
	public String SeleniumGroupCopyView() {
		return "/seleniumGroup/SeleniumGroupCopyView";
	}
	
}
