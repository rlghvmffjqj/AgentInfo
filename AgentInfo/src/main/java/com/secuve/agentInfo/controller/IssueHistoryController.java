package com.secuve.agentInfo.controller;

import java.io.File;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import com.secuve.agentInfo.core.FileDownloadView;
import com.secuve.agentInfo.service.IssueHistoryService;
import com.secuve.agentInfo.vo.Issue;
import com.secuve.agentInfo.vo.IssueHistory;

@Controller
public class IssueHistoryController {
	@Autowired IssueHistoryService issueHistoryService;
	
	@ResponseBody
	@PostMapping(value = "/issueHistory")
	public Map<String, Object> IssueHistory(Issue issue) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<IssueHistory> list = new ArrayList<>(issueHistoryService.getIssueHistoryList(issue.getIssueKeyNum()));

		int totalCount = issueHistoryService.getIssueHistoryListCount(issue.getIssueKeyNum());
		map.put("page", 1);
		map.put("total", 1);
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/issueHistory/issueHistoryInsert")
	public Map<String, String> IssueSave(Issue issue, String issueHistoryDate, Principal principal) {
		issue.setIssueRegistrant(principal.getName());
		issue.setIssueRegistrationDate(issueHistoryService.nowDate());
		
		Map<String, String> result = issueHistoryService.insertIssueHistory(issue, issueHistoryDate);
		return result;
	}
	
	@GetMapping(value = "/issueHistory/fileDownload")
	public View FileDownload(@RequestParam String fileName, Model model) throws Exception {
		String filePath = "C:\\AgentInfo\\IssueHistoryDownload";
		model.addAttribute("fileUploadPath", filePath);          // 파일 경로    
		model.addAttribute("filePhysicalName", "/"+fileName);    // 파일 이름    
		model.addAttribute("fileLogicalName", fileName);  		 // 출력할 파일 이름
	
		return new FileDownloadView();
	}
	
	@ResponseBody
	@PostMapping(value = "/issueHistory/issueHistoryDelete")
	public Map<String, String> IssueHistoryDelete(String issueHistoryPdf, Principal principal) {
		Map<String, String> result = issueHistoryService.deleteIssueHistory(issueHistoryPdf);
		return result;
	}
	
	@ResponseBody
	@PostMapping(value = "/issueHistory/fileDelete")
	public String FileDelete(String fileName, Principal principal, Model model) {
		//파일 경로 지정
		String path = "C:\\AgentInfo\\IssueHistoryDownload";
				
		//현재 게시판에 존재하는 파일객체를 만듬
		File file = new File(path + "\\" + fileName);
			
		if(file.exists()) { // 파일이 존재하면
			file.delete(); // 파일 삭제
			return "OK"; 
		}
		return "NotFile";
	}

}
