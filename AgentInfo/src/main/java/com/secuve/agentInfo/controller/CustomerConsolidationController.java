package com.secuve.agentInfo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.CustomerConsolidationService;
import com.secuve.agentInfo.vo.Packages;

@Controller
public class CustomerConsolidationController {
	@Autowired CustomerConsolidationService customerConsolidationService;

	@GetMapping(value = "/customerConsolidation/list")
	public String customerConsolidationList(Model model) {

		return "customerConsolidation/CustomerConsolidationList";
	}
	
	@ResponseBody
	@PostMapping(value = "/customerConsolidation")
	public Map<String, Object> customerConsolidation(Packages search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<Packages> list = new ArrayList<>(customerConsolidationService.getCustomerConsolidationList(search));

		int totalCount = customerConsolidationService.getCustomerConsolidationListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
}
