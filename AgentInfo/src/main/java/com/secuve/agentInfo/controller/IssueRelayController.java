package com.secuve.agentInfo.controller;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
	public String InsertPackagesView(Model model, IssueRelay issueRelay) throws UnknownHostException {
		IssueRelay issueRelayExis = issueRelayService.getIssueRelayIssueOne(issueRelay.getIssueKeyNum());
		String url = "";
		if(issueRelayExis != null) {
			url = issueRelayExis.getIssueRelayUrl();
		} else {
			String localIp = InetAddress.getLocalHost().getHostAddress();
			if(localIp.equals("172.16.100.90")) {
				url = "https://172.16.100.90:8443/AgentInfo/issueRelay/"+issueRelayService.createKey();
			} else {
				url = "https://qa.secuve.kro.kr:8443/AgentInfo/issueRelay/"+issueRelayService.createKey();
			}
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
		ArrayList<Issue> issue = new ArrayList<>(issueService.getIssueOneIssueApplyYn(issueRelay.getIssueKeyNum()));
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
	public String IssueRelayUpdateModal(Model model, int issueRelayKeyNum, int issuePrimaryKeyNum) {
		IssueRelay issueRelay = issueRelayService.getIssueRelayOne(issueRelayKeyNum);
		Issue issue = issueService.getIssuePrimaryOne(issueRelay.getIssuePrimaryKeyNum());
			
		model.addAttribute("issueConfirm", issue.getIssueConfirm());
		model.addAttribute("issueRelayKeyNum", issueRelayKeyNum);
		model.addAttribute("issuePrimaryKeyNum", issuePrimaryKeyNum);
		model.addAttribute("issueRelayDetail", issueRelay.getIssueRelayDetail());
		model.addAttribute("viewType","update");
		return "/issueRelay/issueRelayModal";
	}
	
	@ResponseBody
	@PostMapping(value = "/issueRelay/relay")
	public Map Relay(IssueRelay issueRelay) {
		Map resultMap = new HashMap();
		IssueRelay issueRelayOne = issueRelayService.getIssueRelayIssueOne(issueRelay.getIssueKeyNum());
		if(issueRelayOne == null) {
			resultMap.put("result", "UrlExport");
			return resultMap;
		}
		issueRelayOne.setIssuePrimaryKeyNum(issueRelay.getIssuePrimaryKeyNum());
		issueRelayOne.setIssueRelayDetail(issueRelay.getIssueRelayDetail());
		issueRelayOne.setIssueRelayType(issueRelay.getIssueRelayType());
		issueRelayOne.setIssueRelayDate(issueRelayService.nowDate());
		Issue issue = issueService.getIssuePrimaryOne(issueRelay.getIssuePrimaryKeyNum());
		if(issueRelay.getIssueRelayType().equals("개발")) {
			issueRelayService.insertUseralarm(issue);
			issue.setIssueAnswerStatus("complete");
			issueService.updateIssueAnswerStatus(issue);
		} else {
			issue.setIssueAnswerStatus("reRequest");
			issueService.updateIssueAnswerStatus(issue);
		}
		return issueRelayService.insertIssueRelay(issueRelayOne);
	}
	
	@ResponseBody
	@PostMapping(value = "/issueRelay/relayUpdate")
	public String RelayUpdate(IssueRelay issueRelay) {
		issueRelay.setIssueRelayDate(issueRelayService.nowDate());
		Issue issue = issueService.getIssuePrimaryOne(issueRelay.getIssuePrimaryKeyNum());
		if(issueRelay.getIssueRelayType().equals("개발"))
			issueRelayService.insertUseralarm(issue);
		return issueRelayService.updateIssueRelay(issueRelay);
	}
	
	@ResponseBody
	@PostMapping(value = "/issueRelay/delete")
	public String IssueRelayDelete(int issueRelayKeyNum, int issuePrimaryKeyNum) {
		return issueRelayService.delIssueRelay(issueRelayKeyNum, issuePrimaryKeyNum);
	}
	
	
	@GetMapping(value = "/issueRelay/issueRelayList") 
	public String IssueList(Model model, Principal principal, HttpServletRequest req) {
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
		
		return "/issueRelay/IssueRelayList";
	}
	
	@ResponseBody
	@PostMapping(value = "/issueRelay")
	public Map<String, Object> Issue(Issue search) {
		search.setRequestType("development");
		search.setIssueProceStatus(String.join(",",search.getIssueProceStatusMulti()));
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<Issue> list = new ArrayList<>(issueService.getIssueList(search));

		int totalCount = issueService.getIssueListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/issue/completeRequest")
	public String IssueComplete(@RequestParam int[] chkList) {
		return issueService.proceStatusChange(chkList, "request");
	}
}
