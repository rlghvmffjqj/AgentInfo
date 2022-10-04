package com.secuve.agentInfo.controller;

import java.io.File;
import java.io.IOException;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import com.secuve.agentInfo.core.FileDownloadView;
import com.secuve.agentInfo.service.IssueService;
import com.secuve.agentInfo.vo.Issue;

@Controller
public class IssueController {
	@Autowired IssueService issueService;
	
	@GetMapping(value = "/issue/issueList")
	public String IssueList(Model model) {
		List<String> issueCustomer = issueService.getSelectInput("issueCustomer");
		List<String> issueTitle = issueService.getSelectInput("issueTitle");
		List<String> issueTosms = issueService.getSelectInput("issueTosms");
		List<String> issueTosrf = issueService.getSelectInput("issueTosrf");
		List<String> issuePortal = issueService.getSelectInput("issuePortal");
		List<String> issueJava = issueService.getSelectInput("issueJava");
		List<String> issueWas = issueService.getSelectInput("issueWas");
		
		model.addAttribute("issueCustomer", issueCustomer);
		model.addAttribute("issueTitle", issueTitle);
		model.addAttribute("issueTosms", issueTosms);
		model.addAttribute("issueTosrf", issueTosrf);
		model.addAttribute("issuePortal", issuePortal);
		model.addAttribute("issueJava", issueJava);
		model.addAttribute("issueWas", issueWas);
		
		return "issue/IssueList";
	}
	
	@ResponseBody
	@PostMapping(value = "/issue")
	public Map<String, Object> Issue(Issue search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<Issue> list = new ArrayList<>(issueService.getIssueList(search));

		int totalCount = issueService.getIssueListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@GetMapping(value = "/issue/issueWrite")
	public String ExistingNew(Model model) {
		ArrayList<Issue> issueList = new ArrayList<Issue>();
		Issue issue = new Issue();
		issue.setIssueKeyNum(0);
		issueList.add(issue);
		model.addAttribute("issue",issueList);
		model.addAttribute("issueTitle", issue);
		model.addAttribute("viewType", "insert");
		return "issue/IssueView";
	}
	
	@ResponseBody
	@PostMapping(value = "/issue/issueSave")
	public Map IssueSave(Issue issue, Principal principal) {
		issue.setIssueRegistrant(principal.getName());
		issue.setIssueRegistrationDate(issueService.nowDate());
		
		Map result = issueService.insertIssue(issue, principal);
		return result;
	}
	
	@ResponseBody
	@PostMapping(value = "/issue/delete")
	public String IssueDelete(@RequestParam int[] chkList) {
		return issueService.delIssue(chkList);
	}
	
	@ResponseBody
	@PostMapping(value = "/issue/update")
	public Map IssueUpdate(Issue issue, Principal principal) {
		issue.setIssueModifier(principal.getName());
		issue.setIssueModifiedDate(issueService.nowDate());
		
		Map result = issueService.updateIssue(issue, principal);
		return result;
	}
	
	@ResponseBody
	@PostMapping(value = "/issue/copy")
	public Map IssueCopy(Issue issue, Principal principal) {
		issue.setIssueModifier(principal.getName());
		issue.setIssueModifiedDate(issueService.nowDate());
		
		Map result = issueService.copyIssue(issue, principal);
		return result;
	}
	
	@GetMapping(value = "/issue/updateView")
	public String UpdateView(Model model, int issueKeyNum) {
		Issue issueTitle = issueService.getIssueOneTitle(issueKeyNum);
		ArrayList<Issue> issue = new ArrayList<>(issueService.getIssueOne(issueKeyNum));
		
		model.addAttribute("viewType", "update");
		model.addAttribute("issueTitle", issueTitle);
		model.addAttribute("issue",issue);
		return "issue/IssueView";
	}
	
	@GetMapping(value = "/issue/copyView")
	public String CopyView(Model model, int issueKeyNum) {
		Issue issueTitle = issueService.getIssueOneTitle(issueKeyNum);
		ArrayList<Issue> issue = new ArrayList<>(issueService.getIssueOne(issueKeyNum));
		
		model.addAttribute("viewType", "copy");
		model.addAttribute("issueTitle", issueTitle);
		model.addAttribute("issue",issue);
		return "issue/IssueView";
	}
	
	
	@RequestMapping(value = "/issue/pdfView", method = RequestMethod.POST)
	public String PdfView(Model model, int issueKeyNum) {
		Issue issueTitle = issueService.getIssueOneTitle(issueKeyNum);
		ArrayList<Issue> issue = new ArrayList<>(issueService.getIssueOne(issueKeyNum));
		
		model.addAttribute("viewType", "update");
		model.addAttribute("issueTitle", issueTitle);
		model.addAttribute("issue",issue);
		return "issue/PdfView";
	}
	
	@ResponseBody
	@PostMapping(value = "/issue/pdf")
	public String PDF(String jsp, String issueCustomer, String issueTitle, String issueDate, Principal principal, Model model) {
		StringBuilder html = new StringBuilder();
		String body = jsp;
		
		html.append(body);
		String filePath = "C:\\AgentInfo\\IssueDownload";
		String fileName = issueCustomer + "_" + issueTitle + "_" + issueDate + ".pdf";

		String BODY = body.toString();

		// html to pdf
		try {
			issueService.makepdf(BODY, filePath + "\\" + fileName);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "FALSE";
		}
		return "OK"; 
	}
	
	@GetMapping(value = "/issue/fileDownload")
	public View FileDownload(@RequestParam String fileName, Model model) throws Exception {
		String filePath = "C:\\AgentInfo\\IssueDownload";
		model.addAttribute("fileUploadPath", filePath);          // 파일 경로    
		model.addAttribute("filePhysicalName", "/"+fileName);    // 파일 이름    
		model.addAttribute("fileLogicalName", fileName);  		 // 출력할 파일 이름
	
		return new FileDownloadView();
	}
	
	@ResponseBody
	@PostMapping(value = "/issue/fileDelete")
	public String FileDelete(String fileName, Principal principal, Model model) {
		//파일 경로 지정
		String path = "C:\\AgentInfo\\IssueDownload";
				
		//현재 게시판에 존재하는 파일객체를 만듬
		File file = new File(path + "\\" + fileName);
			
		if(file.exists()) { // 파일이 존재하면
			file.delete(); // 파일 삭제
			return "OK"; 
		}
		return "NotFile";
	}
	
	@ResponseBody
	@PostMapping(value = "/issue/merge")
	public String IssueMerge(@RequestParam int[] chkList) {
		return issueService.mergeIssue(chkList);
	}
}
