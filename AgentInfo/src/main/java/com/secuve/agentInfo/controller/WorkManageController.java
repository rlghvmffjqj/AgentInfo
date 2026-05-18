package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.CategoryService;
import com.secuve.agentInfo.service.EmployeeService;
import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.WorkManageService;
import com.secuve.agentInfo.vo.WorkManage;

@Controller
public class WorkManageController {
	@Autowired WorkManageService workManageService;
	@Autowired EmployeeService employeeService;
	@Autowired FavoritePageService favoritePageService;
	@Autowired CategoryService categoryService;

	@GetMapping(value = "/workManage/list")
	public String WorkManageList(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "업무 관리");
		
		return "workManage/WorkManageList";
	}
	
	@ResponseBody
	@PostMapping(value = "/workManage")
	public Map<String, Object> WorkManage(WorkManage search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<WorkManage> list = new ArrayList<>(workManageService.getWorkManageList(search));
		
		int totalCount = workManageService.getWorkManageListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@PostMapping(value = "/workManage/insertView")
	public String InsertWorkManageView(Model model, WorkManage workManage, Principal principal) {
		List<String> workManageCustomer = categoryService.getCategoryValue("managementServer");
		
		workManage.setWorkManageRequestDate(workManageService.nowDate());
		workManage.setWorkManageTestScheduleStart(workManageService.nowDate());
		workManage.setWorkManageTestScheduleEnd(workManageService.nowDate());
		workManage.setWorkManageAuthor(employeeService.getEmployeeOne(principal.getName()).getEmployeeName());
		
		model.addAttribute("viewType", "insert").addAttribute("workManage", workManage).addAttribute("workManageCustomer", workManageCustomer);;
		return "/workManage/WorkManageView";
	}
	
	@ResponseBody
	@PostMapping(value = "/workManage/insert")
	public Map InsertWorkManage(WorkManage workManage, Principal principal) {
		workManage.setWorkManageRegistrant(principal.getName());
		workManage.setWorkManageRegistrationDate(workManageService.nowDateDetail());

		Map<String, Object> map = new HashMap<>();
		String result = workManageService.insertWorkManage(workManage);
		
		map.put("workManageKeyNum", workManage.getWorkManageKeyNum());
		map.put("result", result);
		return map;
	}
}
