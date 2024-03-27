package com.secuve.agentInfo.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

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
		String url = "https://qa.secuve.kro.kr:8443/AgentInfo/issueRelay/"+issueRelayService.createKey();
		issueRelay.setIssueRelayUrl(url);
		issueRelayService.insertIssueRelay(issueRelay);
		model.addAttribute("url", url);
		return "/issue/IssueUrlView";
	}
	
	@GetMapping(value = "/issueRelay/{issueRelayRandomUrl}")
	public String IssueRelayView(Model model, @PathVariable String issueRelayRandomUrl) {
		IssueRelay issueRelay = issueRelayService.getIssueRelayUrlOne(issueRelayRandomUrl);
		Issue issueTitle = issueService.getIssueOneTitle(issueRelay.getIssueKeyNum());
		ArrayList<Issue> issue = new ArrayList<>(issueService.getIssueOne(issueRelay.getIssueKeyNum()));
		
		model.addAttribute("viewType", "update");
		model.addAttribute("issueTitle", issueTitle);
		model.addAttribute("issue",issue);
		return "/issueRelay/issueRelayView";
	}

}
