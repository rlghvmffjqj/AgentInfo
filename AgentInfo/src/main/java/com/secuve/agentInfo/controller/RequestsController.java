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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.EmployeeService;
import com.secuve.agentInfo.service.RequestsService;
import com.secuve.agentInfo.vo.Requests;

@Controller
public class RequestsController {
	@Autowired RequestsService requestsService;
	@Autowired EmployeeService employeeService;
	
	@GetMapping(value = "/requests/list")
	public String ReqestsList(Model model) {
		List<String> employeeId = employeeService.getEmployeeId();
		List<String> employeeName = employeeService.getEmployeeName();
		
		model.addAttribute("employeeId", employeeId);
		model.addAttribute("employeeName", employeeName);
		return "requests/RequestsList";
	}
	
	@ResponseBody
	@PostMapping(value = "/requests")
	public Map<String, Object> Requests(@ModelAttribute("search") Requests search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<Requests> list = new ArrayList<>(requestsService.getRequestsList(search));
		
		int totalCount = requestsService.getRequestsListCount();
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float)totalCount/search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@GetMapping(value = "/requestsWrite/list")
	public String RequestsWriteList() {
		return "requests/RequestsWrite";
	}
	
	@ResponseBody
	@PostMapping(value = "/requests/write")
	public String InsertRequests(Requests requests, Principal principal) {
		requests.setEmployeeId(principal.getName());
		requests.setRequestsRegistrant(principal.getName());
		requests.setRequestsDate(requestsService.nowDate());
		requests.setRequestsRegistrationDate(requestsService.nowDate());
		requests.setRequestsState("요청");
		return requestsService.insertRequests(requests);
	}
	
	@PostMapping(value ="/requests/updateView")
	public String UpdateRequestsView(Model model, int requestsKeyNum) {
		Requests requests = requestsService.getRequestsOne(requestsKeyNum);
		model.addAttribute("requests", requests);
		return "/requests/RequestsView";
	}
	
	@ResponseBody
	@PostMapping(value = "/requests/update")
	public String UpdateEmployee(Requests requests, Principal principal) {
		requests.setRequestsModifier(principal.getName());
		requests.setRequestsModifiedDate(requestsService.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		return requestsService.updateRequests(requests, principal);
	}
	
	@ResponseBody
	@PostMapping(value = "/requests/confirm")
	public String RequestsConfirm(@RequestParam int[] chkList, Principal principal) {
		return requestsService.setRequestsState(chkList, "확인", principal);
	}
	
	@ResponseBody
	@PostMapping(value = "/requests/wait")
	public String RequestsWait(@RequestParam int[] chkList, Principal principal) {
		return requestsService.setRequestsState(chkList, "대기", principal);
	}
	
	@PostMapping(value ="/requests/notice")
	public String RequestsNotice(Model model) {
		model.addAttribute("request", requestsService.getRequestsCount());
		return "/requests/Notice";
	}
}
