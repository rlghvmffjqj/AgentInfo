package com.secuve.agentInfo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.EmployeeUidLogService;
import com.secuve.agentInfo.vo.EmployeeUidLog;

@Controller
public class EmployeeUidLogController {
	@Autowired EmployeeUidLogService employeeUidLogService;

	/**
	 * 사용자 접속 로그 페이지 호출
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/employeeUidLog/list")
	public String EmployeeUidLogList(Model model) {
		List<String> employeeId = employeeUidLogService.getEmployeeId();
		
		model.addAttribute("employeeId", employeeId);
		return "employeeUidLog/EmployeeUidLogList";
	}
	
	/**
	 * 사용자 접속 로그 데이터 출력
	 * @param search
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/employeeUidLog")
	public Map<String, Object> EmployeeUidLog(@ModelAttribute("search") EmployeeUidLog search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<EmployeeUidLog> list = new ArrayList<>(employeeUidLogService.getEmployeeUidLogList(search));
		
		int totalCount = employeeUidLogService.getEmployeeUidLogListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float)totalCount/search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
}
