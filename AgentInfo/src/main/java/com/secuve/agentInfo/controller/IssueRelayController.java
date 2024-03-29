package com.secuve.agentInfo.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.IssueRelayService;
import com.secuve.agentInfo.service.IssueService;
import com.secuve.agentInfo.vo.Issue;
import com.secuve.agentInfo.vo.IssueRelay;

@Controller
public class IssueRelayController {
	@Autowired IssueRelayService issueRelayService;
	@Autowired IssueService issueService;
	
	@PostMapping(value = "/issueRelay/urlExport")
	public String InsertPackagesView(Model model, IssueRelay issueRelay) {
		IssueRelay issueRelayExis = issueRelayService.getIssueRelayIssueOne(issueRelay.getIssueKeyNum());
		String url = "";
		if(issueRelayExis != null) {
			url = issueRelayExis.getIssueRelayUrl();
		} else {
			//url = "https://qa.secuve.kro.kr:8443/AgentInfo/issueRelay/"+issueRelayService.createKey();
			url = "https://172.16.100.90:8443/AgentInfo/issueRelay/"+issueRelayService.createKey();
			issueRelay.setIssueRelayUrl(url);
			issueRelay.setIssueRelayDate(issueRelayService.nowDate());
			issueRelayService.insertIssueRelay(issueRelay);
		}
		model.addAttribute("url", url);
		return "/issue/IssueUrlView";
	}
	
	@GetMapping(value = "/issueRelay/{issueRelayRandomUrl}")
	public String IssueRelayView(Model model, @PathVariable String issueRelayRandomUrl) {
		IssueRelay issueRelay = issueRelayService.getIssueRelayUrlOne(issueRelayRandomUrl);
		ArrayList<Issue> issue = new ArrayList<>(issueService.getIssueOne(issueRelay.getIssueKeyNum()));
		ArrayList<IssueRelay> issueRelayList = new ArrayList<>(issueRelayService.getIssueRelayList(issueRelay.getIssueKeyNum()));
		Issue issueTitle = issueService.getIssueOneTitle(issueRelay.getIssueKeyNum());
		
		model.addAttribute("issue",issue);
		model.addAttribute("issueRelayList", issueRelayList);
		model.addAttribute("issueTitle", issueTitle);
		return "/issueRelay/issueRelayView";
	}
	
	@PostMapping(value = "/issueRelay/relayModal")
	public String IssueRelayModal(Model model, int issuePrimaryKeyNum, int issueKeyNum, String issueRelayType) {
		Issue issue = issueService.getIssuePrimaryOne(issuePrimaryKeyNum);
			
		model.addAttribute("issueConfirm", issue.getIssueConfirm());
		model.addAttribute("issuePrimaryKeyNum", issue.getIssuePrimaryKeyNum());
		model.addAttribute("issueKeyNum", issueKeyNum);
		model.addAttribute("issueRelayType", issueRelayType);
		model.addAttribute("viewType","insert");
		return "/issueRelay/issueRelayModal";
	}
	
	@PostMapping(value = "/issueRelay/relayUpdateModal")
	public String IssueRelayUpdateModal(Model model, int issueRelayKeyNum) {
		IssueRelay issueRelay = issueRelayService.getIssueRelayOne(issueRelayKeyNum);
		Issue issue = issueService.getIssuePrimaryOne(issueRelay.getIssuePrimaryKeyNum());
			
		model.addAttribute("issueConfirm", issue.getIssueConfirm());
		model.addAttribute("issueRelayKeyNum", issueRelayKeyNum);
		model.addAttribute("issueRelayDetail", issueRelay.getIssueRelayDetail());
		model.addAttribute("viewType","update");
		return "/issueRelay/issueRelayModal";
	}
	
	@ResponseBody
	@PostMapping(value = "/issueRelay/relay")
	public String Relay(IssueRelay issueRelay) {
		IssueRelay issueRelayOne = issueRelayService.getIssueRelayIssueOne(issueRelay.getIssueKeyNum());
		issueRelayOne.setIssuePrimaryKeyNum(issueRelay.getIssuePrimaryKeyNum());
		issueRelayOne.setIssueRelayDetail(issueRelay.getIssueRelayDetail());
		issueRelayOne.setIssueRelayType(issueRelay.getIssueRelayType());
		issueRelayOne.setIssueRelayDate(issueRelayService.nowDate());
		return issueRelayService.insertIssueRelay(issueRelayOne);
	}
	
	@ResponseBody
	@PostMapping(value = "/issueRelay/relayUpdate")
	public String RelayUpdate(IssueRelay issueRelay) {
		issueRelay.setIssueRelayDate(issueRelayService.nowDate());
		return issueRelayService.updateIssueRelay(issueRelay);
	}
	
	@ResponseBody
	@PostMapping(value = "/issueRelay/delete")
	public String IssueRelayDelete(int issueRelayKeyNum) {
		return issueRelayService.delIssueRelay(issueRelayKeyNum);
	}

}
