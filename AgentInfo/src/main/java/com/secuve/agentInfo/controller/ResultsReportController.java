package com.secuve.agentInfo.controller;

import java.io.File;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import com.secuve.agentInfo.core.FileDownloadView;
import com.secuve.agentInfo.core.PDFDownlod;
import com.secuve.agentInfo.service.EmployeeService;
import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.ResultsReportService;
import com.secuve.agentInfo.vo.ResultsReport;

@Controller
public class ResultsReportController {
	@Autowired ResultsReportService resultsReportService;
	@Autowired FavoritePageService favoritePageService;
	@Autowired EmployeeService employeeService;
	@Autowired PDFDownlod pdfDownlod;
	
	@GetMapping(value = "/resultsReport/list")
	public String ResultsReportList(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "결과 보고서");

		return "resultsReport/ResultsReportList";
	}
	
	@ResponseBody
	@PostMapping(value = "/resultsReport")
	public Map<String, Object> ResultsReport(ResultsReport search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<ResultsReport> list = new ArrayList<>(resultsReportService.getResultsReportList(search));

		int totalCount = resultsReportService.getResultsReportListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float)totalCount/search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@GetMapping(value = "/resultsReport/insertView")
	public String ExistingNew(Model model, Principal principal) {
		model.addAttribute("username", employeeService.getEmployeeOne(principal.getName()).getEmployeeName());
		model.addAttribute("viewType","insert");
		model.addAttribute("yearDate", resultsReportService.yearDate());
		model.addAttribute("maxNumber", resultsReportService.resultsReportKeyNumMax());
		return "/resultsReport/ResultsReportView";
	}
	
	@ResponseBody
	@PostMapping(value = "/resultsReport/pdf")
	public String PDF(StringBuffer jsp, String resultsReportKeyNum, String resultsReportCustomerName, String resultsReportDate, Principal principal, Model model) {
		String filePath = "C:\\AgentInfo\\resultsReport";
		String fileName = resultsReportKeyNum + "_테스트_결과보고서_" + resultsReportCustomerName + "_" + resultsReportDate + ".pdf";
		try {
			pdfDownlod.makepdf(jsp.toString(), filePath + "\\" + fileName);
		} catch (Exception e) {
			e.printStackTrace();
			return "FALSE";
		}
		return "OK"; 
	}
	
	@GetMapping(value = "/resultsReport/fileDownload")
	public View FileDownload(@RequestParam String fileName, Model model) throws Exception {
		String filePath = "C:\\AgentInfo\\resultsReport";
		model.addAttribute("fileUploadPath", filePath);          // 파일 경로    
		model.addAttribute("filePhysicalName", "/"+fileName);    // 파일 이름    
		model.addAttribute("fileLogicalName", fileName);  		 // 출력할 파일 이름
	
		return new FileDownloadView();
	}
	
	@ResponseBody
	@PostMapping(value = "/resultsReport/fileDelete")
	public String FileDelete(String fileName, Principal principal, Model model) {
		//파일 경로 지정
		String path = "C:\\AgentInfo\\resultsReport";
				
		//현재 게시판에 존재하는 파일객체를 만듬
		File file = new File(path + "\\" + fileName);
			
		if(file.exists()) { // 파일이 존재하면
			file.delete(); // 파일 삭제
			return "OK"; 
		}
		return "NotFile";
	}
	
	@ResponseBody
	@PostMapping(value = "/resultsReport/resultsReportSave")
	public String resultsReportSave(ResultsReport resultsReport, Principal principal) {
		resultsReport.setResultsReportRegistrant(principal.getName());
		resultsReport.setResultsReportRegistrationDate(resultsReportService.nowDate());
		return resultsReportService.insertResultsReport(resultsReport);
	}
}
