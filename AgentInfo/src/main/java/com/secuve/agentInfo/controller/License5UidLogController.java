package com.secuve.agentInfo.controller;

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

import com.secuve.agentInfo.service.License5UidLogService;
import com.secuve.agentInfo.vo.License5UidLog;

@Controller
public class License5UidLogController {
	@Autowired License5UidLogService license5UidLogService;
	
	@GetMapping(value = "/license5UidLog/list")
	public String License5UidLogList(Model model) {
		List<String> customerName = license5UidLogService.getSelectInput("customerName");
		List<String> businessName = license5UidLogService.getSelectInput("businessName");
		List<String> additionalInformation = license5UidLogService.getSelectInput("additionalInformation");
		List<String> productType = license5UidLogService.getSelectInput("productType");
		List<String> macAddress = license5UidLogService.getSelectInput("macAddress");
		List<String> managerOsType = license5UidLogService.getSelectInput("managerOsType");
		List<String> managerDbmsType = license5UidLogService.getSelectInput("managerDbmsType");
		List<String> productVersion = license5UidLogService.getSelectInput("productVersion");
		List<String> licenseFilePath = license5UidLogService.getSelectInput("licenseFilePath");
		List<String> serialNumber = license5UidLogService.getSelectInput("serialNumber");
		List<String> country = license5UidLogService.getSelectInput("country");
		List<String> requester = license5UidLogService.getSelectInput("requester");
		
		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", businessName);
		model.addAttribute("additionalInformation", additionalInformation);
		model.addAttribute("productType", productType);
		model.addAttribute("macAddress", macAddress);
		model.addAttribute("managerOsType", managerOsType);
		model.addAttribute("managerDbmsType", managerDbmsType);
		model.addAttribute("productVersion", productVersion);
		model.addAttribute("licenseFilePath", licenseFilePath);
		model.addAttribute("serialNumber", serialNumber);
		model.addAttribute("country", country);
		model.addAttribute("requester", requester);
		return "/license5UidLog/LicenseUidLogList";
	}
	
	@ResponseBody
	@PostMapping(value = "/license5UidLog")
	public Map<String, Object> License5UidLog(License5UidLog search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<License5UidLog> list = new ArrayList<>(license5UidLogService.getLicenseList(search));

		int totalCount = license5UidLogService.getLicenseListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}

}
