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

import com.secuve.agentInfo.service.LicenseUidLogService;
import com.secuve.agentInfo.vo.LicenseUidLog;

@Controller
public class LicenseUidLogController {
	@Autowired LicenseUidLogService licenseUidLogService;
	
	/**
	 * 라이선스 발급 로그 페이지 이동
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/licenseUidLog/list")
	public String LicenseUidLogList(Model model) {
		List<String> licenseUidLogCustomerName = licenseUidLogService.getSelectInput("licenseUidLogCustomerName");
		List<String> licenseUidLogBusinessName = licenseUidLogService.getSelectInput("licenseUidLogBusinessName");
		List<String> licenseUidLogRequester = licenseUidLogService.getSelectInput("licenseUidLogRequester");
		List<String> licenseUidLogPartners = licenseUidLogService.getSelectInput("licenseUidLogPartners");
		List<String> licenseUidLogOsVersion = licenseUidLogService.getSelectInput("licenseUidLogOsVersion");
		List<String> licenseUidLogKernelVersion = licenseUidLogService.getSelectInput("licenseUidLogKernelVersion");
		List<String> licenseUidLogTosVersion = licenseUidLogService.getSelectInput("licenseUidLogTosVersion");
		List<String> licenseUidLogPeriod = licenseUidLogService.getSelectInput("licenseUidLogPeriod");
		List<String> licenseUidLogMacUmlHostId = licenseUidLogService.getSelectInput("licenseUidLogMacUmlHostId");
		
		model.addAttribute("licenseUidLogCustomerName", licenseUidLogCustomerName);
		model.addAttribute("licenseUidLogBusinessName", licenseUidLogBusinessName);
		model.addAttribute("licenseUidLogRequester", licenseUidLogRequester);
		model.addAttribute("licenseUidLogPartners", licenseUidLogPartners);
		model.addAttribute("licenseUidLogOsVersion", licenseUidLogOsVersion);
		model.addAttribute("licenseUidLogKernelVersion", licenseUidLogKernelVersion);
		model.addAttribute("licenseUidLogTosVersion", licenseUidLogTosVersion);
		model.addAttribute("licenseUidLogPeriod", licenseUidLogPeriod);
		model.addAttribute("licenseUidLogMacUmlHostId", licenseUidLogMacUmlHostId);
		
		return "licenseUidLog/LicenseUidLogList";
	}
	
	/**
	 * 테이블 내 라이선스 발급 키 컬럼 버튼
	 * @param licenseUidLogKeyNum
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/licenseUidLog/issueKey")
	public String IssueKey(int licenseUidLogKeyNum) {
		return licenseUidLogService.getLicenseIssueKey(licenseUidLogKeyNum);
	}
	
	/**
	 * 라이선스 발급 로그 테이블 정보 조회
	 * @param search
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/licenseUidLog")
	public Map<String, Object> LicenseUidLog(@ModelAttribute("search") LicenseUidLog search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<LicenseUidLog> list = new ArrayList<>(licenseUidLogService.getLicenseUidLogList(search));
		
		int totalCount = licenseUidLogService.getLicenseUidLogListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float)totalCount/search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
}
