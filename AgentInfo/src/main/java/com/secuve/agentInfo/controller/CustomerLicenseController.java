package com.secuve.agentInfo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class CustomerLicenseController {

	@GetMapping(value = "/customerLicense/customerLicenseManagement/list")
	public String CustomerList(Model model) {
		
		return "/customerLicense/CustomerLicenseManagementList";
	}
	
	@PostMapping(value = "/customerLicense/insertView")
	public String InsertCustomerView(Model model) {
		model.addAttribute("viewType", "insert");
		return "/customerLicense/CustomerLicenseManagementView";
	}
	
	@PostMapping(value = "/customerLicense/updateView")
	public String UpdateCustomerView(Model model) {
		model.addAttribute("viewType", "update");
		return "/customerLicense/CustomerLicenseManagementView";
	}
	
	@GetMapping(value = "/customerLicense/engineerUnassigned/list")
	public String engineerUnassignedList(Model model) {
		
		return "/customerLicense/EngineerUnassignedList";
	}
	
	@PostMapping(value = "/customerLicense/engineerUnassigned/insertView")
	public String InsertEngineerUnassignedView(Model model) {
		model.addAttribute("viewType", "insert");
		return "/customerLicense/EngineerUnassignedView";
	}
	
	@GetMapping(value = "/customerLicense/unissuedLicense/list")
	public String unissuedLicenseList(Model model) {
		
		return "/customerLicense/UnissuedLicenseList";
	}
	
	@PostMapping(value = "/customerLicense/unissuedLicense/insertView")
	public String InsertUnissuedLicenseView(Model model) {
		model.addAttribute("viewType", "insert");
		return "/customerLicense/UnissuedLicenseView";
	}
}
