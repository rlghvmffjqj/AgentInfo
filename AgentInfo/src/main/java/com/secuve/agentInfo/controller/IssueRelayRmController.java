package com.secuve.agentInfo.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.secuve.agentInfo.service.IssueRelayRmService;
import com.secuve.agentInfo.service.IssueRelayService;
import com.secuve.agentInfo.service.IssueService;
import com.secuve.agentInfo.vo.Issue;
import com.secuve.agentInfo.vo.IssueRelay;

@Controller
public class IssueRelayRmController {
	@Autowired IssueService issueService;
	@Autowired IssueRelayRmService issueRelayRmService;
	@Autowired IssueRelayService issueRelayService;
	
	@GetMapping(value = "/issueRelayRm/{issueRelayRandomUrl}")
	public String IssueRelayRmList(Model model, @PathVariable String issueRelayRandomUrl) {
		IssueRelay issueRelay = issueRelayService.getIssueRelayUrlOne(issueRelayRandomUrl);
		ArrayList<Issue> issue = new ArrayList<>(issueService.getIssueOneIssueApplyYn(issueRelay.getIssueKeyNum()));
		ArrayList<IssueRelay> issueRelayList = new ArrayList<>(issueRelayService.getIssueRelayList(issueRelay.getIssueKeyNum()));
		Issue issueTitle = issueService.getIssueOneTitle(issueRelay.getIssueKeyNum());
		
		model.addAttribute("issue",issue);
		model.addAttribute("issueRelayList", issueRelayList);
		model.addAttribute("issueTitle", issueTitle);
		return "/issueRelayRm/issueRelayRmList";
	}
}
