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

import com.secuve.agentInfo.service.CategoryService;
import com.secuve.agentInfo.service.CustomerUidLogService;
import com.secuve.agentInfo.vo.CustomerUidLog;

@Controller
public class CustomerUidLogController {
	@Autowired CustomerUidLogService customerUidLogService;
	@Autowired CategoryService categoryService;
	
	/**
	 * 고객사 정보 로그 페이지 이동
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/customerUidLog/list")
	public String CustomerUidLogList(Model model) {
		List<String> customerName = categoryService.getCategoryValue("customerName");
		List<String> categoryBusinessName = categoryService.getCategoryBusinessNameList();
		
		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", categoryBusinessName);
		return "customerUidLog/CustomerUidLogList";
	}
	
	/**
	 * 고객사 정보 로그 데이터 조회
	 * @param search
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/customerUidLog")
	public Map<String, Object> CustomerUidLog(@ModelAttribute("search") CustomerUidLog search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<CustomerUidLog> list = new ArrayList<>(customerUidLogService.getCustomerUidLogList(search));
		
		int totalCount = customerUidLogService.getCustomerUidLogListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float)totalCount/search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
}
