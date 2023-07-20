package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.CustomerConsolidationService;
import com.secuve.agentInfo.vo.CustomerConsolidation;

@Controller
public class CustomerConsolidationController {
	@Autowired CustomerConsolidationService customerConsolidationService;

	@GetMapping(value = "/customerConsolidation/list")
	public String customerConsolidationList(Model model) {

		return "customerConsolidation/CustomerConsolidationList";
	}
	
	@ResponseBody
	@PostMapping(value = "/customerConsolidation")
	public Map<String, Object> customerConsolidation(CustomerConsolidation search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<CustomerConsolidation> list = new ArrayList<>(customerConsolidationService.getCustomerConsolidationList(search));

		int totalCount = customerConsolidationService.getCustomerConsolidationListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@PostMapping(value = "/customerConsolidation/insertSalesView")
	public String insertSalesView(Model model) {
		model.addAttribute("viewType", "insert");
		model.addAttribute("role", "Sales");
		return "/customerConsolidation/CustomerConsolidationView";
	}
	
	@ResponseBody
	@PostMapping(value = "/customerConsolidation/insertSales")
	public String insertSales(CustomerConsolidation customerConsolidation, Principal principal) {
		customerConsolidation.setCustomerConsolidationRegistrant(principal.getName());
		customerConsolidation.setCustomerConsolidationRegistrationDate(customerConsolidationService.nowDate());

		return customerConsolidationService.insertSales(customerConsolidation, principal);
	}
	
	
	@ResponseBody
	@PostMapping(value = "/customerConsolidation/delete")
	public String customerConsolidationDelete(@RequestParam int[] chkList, Authentication authorities) {
		return customerConsolidationService.delCustomerConsolidation(chkList, authorities);
	}
	
	@PostMapping(value = "/customerConsolidation/updateView")
	public String updateView(int customerConsolidationKeyNum, Authentication authorities, Model model) {
		CustomerConsolidation customerConsolidation = customerConsolidationService.getCustomerConsolidationOne(customerConsolidationKeyNum);
		model.addAttribute("viewType", "update");
		model.addAttribute("customerConsolidation",customerConsolidation);
		model.addAttribute("role", customerConsolidationService.getRole(authorities));
		return "/customerConsolidation/CustomerConsolidationView";
	}
	
	@ResponseBody
	@PostMapping(value = "/customerConsolidation/updateSales")
	public String updateSales(CustomerConsolidation customerConsolidation, Principal principal) {
		customerConsolidation.setCustomerConsolidationModifier(principal.getName());
		customerConsolidation.setCustomerConsolidationModifiedDate(customerConsolidationService.nowDate());

		return customerConsolidationService.updateSales(customerConsolidation);
	}
	
	
	
	
	@PostMapping(value = "/customerConsolidation/insertEngineerLeaderView")
	public String insertEngineerLeaderView(int customerConsolidationKeyNum, Model model) {
		CustomerConsolidation customerConsolidation = customerConsolidationService.getCustomerConsolidationOne(customerConsolidationKeyNum);
		model.addAttribute("viewType", "insert");
		model.addAttribute("customerConsolidation", customerConsolidation);
		model.addAttribute("role", "EngineerLeader");
		return "/customerConsolidation/CustomerConsolidationView";
	}
	
	@ResponseBody
	@PostMapping(value = "/customerConsolidation/insertSecurityInfo")
	public String insertSecurityInfo(CustomerConsolidation customerConsolidation, Principal principal) {
		customerConsolidation.setCustomerConsolidationRegistrant(principal.getName());
		customerConsolidation.setCustomerConsolidationRegistrationDate(customerConsolidationService.nowDate());

		return customerConsolidationService.insertSecurityInfo(customerConsolidation);
	}
	
	@ResponseBody
	@PostMapping(value = "/customerConsolidation/updateSecurityInfo")
	public String updateSecurityInfo(CustomerConsolidation customerConsolidation, Principal principal) {
		customerConsolidation.setCustomerConsolidationModifier(principal.getName());
		customerConsolidation.setCustomerConsolidationModifiedDate(customerConsolidationService.nowDate());

		return customerConsolidationService.updateSecurityInfo(customerConsolidation);
	}
	
	@PostMapping(value = "/customerConsolidation/engineerSearchView")
	public String engineerSearchView(CustomerConsolidation customerConsolidation, String viewType, Model model) {
		model.addAttribute("customerConsolidation", customerConsolidation);
		model.addAttribute("viewType", viewType);
		return "/customerConsolidation/EngineerSearchView";
	}
	
	@ResponseBody
	@PostMapping(value = "/engineerList")
	public Map<String, Object> engineerList(CustomerConsolidation search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<CustomerConsolidation> list = new ArrayList<>(customerConsolidationService.getEngineerList(search));

		int totalCount = customerConsolidationService.getEngineerCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@PostMapping(value = "/customerConsolidation/insertEngineerLeaderSearchView")
	public String insertEngineerLeaderSearchView(CustomerConsolidation customerConsolidation, Model model) {
		CustomerConsolidation customerConsolidationOne = customerConsolidationService.getCustomerConsolidationOne(customerConsolidation.getCustomerConsolidationKeyNum());
		customerConsolidationOne.setCustomerConsolidationLocation(customerConsolidation.getCustomerConsolidationLocationView());
		customerConsolidationOne.setCustomerConsolidationEngineer(customerConsolidation.getCustomerConsolidationEngineerView());
		customerConsolidationOne.setCustomerConsolidationEngineerId(customerConsolidation.getCustomerConsolidationEngineerIdView());
		customerConsolidationOne.setCustomerConsolidationCustomerManager(customerConsolidation.getCustomerConsolidationCustomerManagerView());
		customerConsolidationOne.setCustomerConsolidationEmail(customerConsolidation.getCustomerConsolidationEmailView());
		customerConsolidationOne.setCustomerConsolidationContact(customerConsolidation.getCustomerConsolidationContactView());
		model.addAttribute("viewType", "insert");
		model.addAttribute("customerConsolidation", customerConsolidationOne);
		model.addAttribute("role", "EngineerLeader");
		return "/customerConsolidation/CustomerConsolidationView";
	}
	
	@PostMapping(value = "/customerConsolidation/updateEngineerLeaderSearchView")
	public String updateEngineerLeaderSearchView(CustomerConsolidation customerConsolidation, Authentication authorities, Model model) {
		CustomerConsolidation customerConsolidationOne = customerConsolidationService.getCustomerConsolidationOne(customerConsolidation.getCustomerConsolidationKeyNum());
		customerConsolidationOne.setCustomerConsolidationLocation(customerConsolidation.getCustomerConsolidationLocationView());
		customerConsolidationOne.setCustomerConsolidationEngineer(customerConsolidation.getCustomerConsolidationEngineerView());
		customerConsolidationOne.setCustomerConsolidationEngineerId(customerConsolidation.getCustomerConsolidationEngineerIdView());
		customerConsolidationOne.setCustomerConsolidationCustomerManager(customerConsolidation.getCustomerConsolidationCustomerManagerView());
		customerConsolidationOne.setCustomerConsolidationEmail(customerConsolidation.getCustomerConsolidationEmailView());
		customerConsolidationOne.setCustomerConsolidationContact(customerConsolidation.getCustomerConsolidationContactView());
		model.addAttribute("viewType", "update");
		model.addAttribute("customerConsolidation",customerConsolidationOne);
		model.addAttribute("role", customerConsolidationService.getRole(authorities));
		return "/customerConsolidation/CustomerConsolidationView";
	}
	
	@PostMapping(value = "/customerConsolidation/insertEngineerView")
	public String insertEngineerView(int customerConsolidationKeyNum, Model model) {
		CustomerConsolidation customerConsolidation = customerConsolidationService.getCustomerConsolidationOne(customerConsolidationKeyNum);
		model.addAttribute("viewType", "insert");
		model.addAttribute("customerConsolidation", customerConsolidation);
		model.addAttribute("role", "Engineer");
		return "/customerConsolidation/CustomerConsolidationView";
	}
	
	
	
}
