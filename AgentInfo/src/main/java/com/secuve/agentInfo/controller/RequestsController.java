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
	
	/**
	 * 요청 사항 리스트 이동
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/requests/list")
	public String ReqestsList(Model model) {
		List<String> employeeId = employeeService.getEmployeeId();
		List<String> employeeName = employeeService.getEmployeeName();
		
		model.addAttribute("employeeId", employeeId);
		model.addAttribute("employeeName", employeeName);
		return "requests/RequestsList";
	}
	
	/**
	 * 요청 사항 테이블 정보 조회 및 검색
	 * @param search
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/requests")
	public Map<String, Object> Requests(@ModelAttribute("search") Requests search, Principal principal) {
		String role = employeeService.getUsersRole(principal.getName());
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(!role.equals("ADMIN")) {
			search.setUsersId(principal.getName());
		} 
		ArrayList<Requests> list = new ArrayList<>(requestsService.getRequestsList(search));
		int totalCount = requestsService.getRequestsListCount();
		
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float)totalCount/search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	/**
	 * 요청 페이지 이동
	 * @return
	 */
	@GetMapping(value = "/requestsWrite/list")
	public String RequestsWriteList() {
		return "requests/RequestsWrite";
	}
	
	/**
	 * 요청서 작성
	 * @param requests
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/requestsWrite/write")
	public String InsertRequests(Requests requests, Principal principal) {
		requests.setEmployeeId(principal.getName());
		requests.setRequestsRegistrant(principal.getName());
		requests.setRequestsDate(requestsService.nowDate());
		requests.setRequestsRegistrationDate(requestsService.nowDate());
		requests.setRequestsState("요청");
		return requestsService.insertRequests(requests);
	}
	
	/**
	 * 요청 사항 수정 Modal
	 * @param model
	 * @param requestsKeyNum
	 * @return
	 */
	@PostMapping(value ="/requests/updateView")
	public String UpdateRequestsView(Model model, int requestsKeyNum) {
		Requests requests = requestsService.getRequestsOne(requestsKeyNum);
		model.addAttribute("requests", requests);
		return "/requests/RequestsView";
	}
	
	/**
	 * 요청 사항 상태 수정
	 * @param requests
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/requests/update")
	public String UpdateEmployee(Requests requests, Principal principal) {
		requests.setRequestsModifier(principal.getName());
		requests.setRequestsModifiedDate(requestsService.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		return requestsService.updateRequests(requests, principal);
	}
	
	/**
	 * 일괄 상태 변경(확인)
	 * @param chkList
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/requests/confirm")
	public String RequestsConfirm(@RequestParam int[] chkList, Principal principal) {
		return requestsService.setRequestsState(chkList, "확인", principal);
	}
	
	/**
	 * 일괄 상태 변경(대기)
	 * @param chkList
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/requests/wait")
	public String RequestsWait(@RequestParam int[] chkList, Principal principal) {
		return requestsService.setRequestsState(chkList, "대기", principal);
	}
	
	/**
	 * 요청 사항 요청 카운터 공지
	 * @param model
	 * @return
	 */
	@PostMapping(value ="/requests/notice")
	public String RequestsNotice(Model model) {
		model.addAttribute("request", requestsService.getRequestsCount());
		return "/requests/Notice";
	}
}