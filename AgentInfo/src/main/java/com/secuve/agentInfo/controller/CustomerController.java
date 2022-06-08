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

import com.secuve.agentInfo.service.CategoryService;
import com.secuve.agentInfo.service.CustomerService;
import com.secuve.agentInfo.vo.Customer;

@Controller
public class CustomerController {
	@Autowired CustomerService customerService;
	@Autowired CategoryService categoryService;
	
	/**
	 * 고객사 리스트 페이지 이동
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/customer/list")
	public String CustomerList(Model model) {
		List<String> customerName = categoryService.getCategoryValue("customerName");
		List<String> businessName = categoryService.getCategoryValue("businessName");
		
		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", businessName);
		
		return "/customer/CustomerList";
	}
	
	/**
	 * 고객사 데이터 조회 및 검색
	 * @param search
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/customer")
	public Map<String, Object> Customer(Customer search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<Customer> list = new ArrayList<>(customerService.getCustomerList(search));

		int totalCount = customerService.getCustomerListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	/**
	 * 고객사 추가 Modal
	 * @param model
	 * @param customer
	 * @return
	 */
	@PostMapping(value = "/customer/insertView")
	public String InsertCustomerView(Model model, Customer customer) {
		List<String> customerName = categoryService.getCategoryValue("customerName");

		model.addAttribute("customerName", customerName);
		model.addAttribute("viewType", "insert").addAttribute("customer", customer);
		return "/customer/CustomerView";
	}
	
	/**
	 * 고객사 추가
	 * @param customer
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/customer/insert")
	public Map<String, String> InsertCustomer(Customer customer, Principal principal) {
		customer.setCustomerRegistrant(principal.getName());
		customer.setCustomerRegistrationDate(customerService.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		String result = customerService.insertCustomer(customer, principal);
		map.put("result", result);
		return map;
	}
	
	/**
	 * 고객사 삭제
	 * @param chkList
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/customer/delete")
	public String CustomerDelete(@RequestParam int[] chkList, Principal principal) {
		return customerService.delCustomer(chkList, principal);
	}
	
	/**
	 * 고객사 수정 Modal
	 * @param model
	 * @param customerKeyNum
	 * @return
	 */
	@PostMapping(value = "/customer/updateView")
	public String UpdateCustomerView(Model model, int customerKeyNum) {
		Customer customer = customerService.getCustomerOne(customerKeyNum);

		List<String> customerName = categoryService.getCategoryValue("customerName");
		List<String> businessName = categoryService.getCategoryValue("businessName", customer.getCustomerName());

		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", businessName);
		model.addAttribute("viewType", "update").addAttribute("customer", customer);
		return "/customer/CustomerView";
	}
	
	/**
	 * 고객사 수정
	 * @param customer
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/customer/update")
	public Map<String, String> UpdateEmployee(Customer customer, Principal principal) {
		customer.setCustomerModifier(principal.getName());
		customer.setCustomerModifiedDate(customerService.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		String result = customerService.updateCustomer(customer, principal);
		map.put("result", result);
		return map;
	}
}