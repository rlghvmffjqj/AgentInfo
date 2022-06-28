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
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.CategoryService;
import com.secuve.agentInfo.service.CustomerBusinessMappingService;
import com.secuve.agentInfo.service.CustomerInfoService;
import com.secuve.agentInfo.vo.CustomerBusinessMapping;
import com.secuve.agentInfo.vo.CustomerInfo;

@Controller
public class CustomerInfoController {
	@Autowired CustomerInfoService customerInfoService;
	@Autowired CategoryService categoryService;
	@Autowired CustomerBusinessMappingService customerBusinessMappingService;
	
	@GetMapping(value = "/customerInfo/search")
	public String CustomerInfoSearch(Model model) {
		List<String> customerName = categoryService.getCategoryValue("customerName");
		model.addAttribute("customerName", customerName);
		return "/customerInfo/CustomerSearch";
	}
	
	@ResponseBody
	@PostMapping(value = "/customerInfo")
	public Map<String, Object> CustomerInfo(String customerName) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<CustomerBusinessMapping> list = new ArrayList<>(customerBusinessMappingService.getCustomerBusinessList(customerName));
		map.put("list", list);
		return map;
	}
	
	@PostMapping(value = "/customerInfo/updateView")
	public String UpdateCustomerInfoView(Model model, String customerName, String businessName) {
		CustomerInfo customerInfo = customerInfoService.getCustomerInfoOne(customerName, businessName);
		
		List<String> customerNameCategory = categoryService.getCategoryValue("customerName");
		List<String> businessNameCategory = categoryService.getCategoryValue("businessName", customerName);

		model.addAttribute("customerName", customerNameCategory);
		model.addAttribute("businessName", businessNameCategory);
		model.addAttribute("viewType", "update").addAttribute("customerInfo", customerInfo);
		return "/customerInfo/CustomerInfoView";
	}
	
	@PostMapping(value = "/customerInfo/insertView")
	public String InsertCustomerInfoView(Model model) {
		List<String> customerName = categoryService.getCategoryValue("customerName");

		model.addAttribute("customerName", customerName);
		model.addAttribute("viewType", "insert");
		return "/customerInfo/CustomerInfoView";
	}
	
	@ResponseBody
	@PostMapping(value = "/customerInfo/insert")
	public Map<String, String> InsertCustomerInfo(CustomerInfo customerInfo, Principal principal) {
		customerInfo.setCustomerInfoRegistrant(principal.getName());
		customerInfo.setCustomerInfoRegistrationDate(customerInfoService.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		String result = customerInfoService.insertCustomerInfo(customerInfo, principal);
		map.put("result", result);
		return map;
	}
}
