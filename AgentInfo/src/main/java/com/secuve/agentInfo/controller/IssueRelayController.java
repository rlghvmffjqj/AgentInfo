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

import com.secuve.agentInfo.core.XssConfig;
import com.secuve.agentInfo.service.IssueRelayService;
import com.secuve.agentInfo.service.IssueService;
import com.secuve.agentInfo.vo.Issue;
import com.secuve.agentInfo.vo.IssueRelay;

@Controller
public class IssueRelayController {
	@Autowired IssueRelayService issueRelayService;
	@Autowired IssueService issueService;
	@Autowired XssConfig xssConfig;
	
	@PostMapping(value = "/issueRelay/urlExport")
	public String InsertPackagesView(Model model, IssueRelay issueRelay, String issueCustomer, String issueTitle) throws UnknownHostException {
		IssueRelay issueRelayExis = issueRelayService.getIssueRelayIssueOne(issueRelay.getIssueKeyNum());
		String url = "";
		if(issueRelayExis != null) {
			url = issueRelayExis.getIssueRelayUrl();
		} else {
			String localIp = InetAddress.getLocalHost().getHostAddress();
			if(localIp.equals("172.16.100.90")) {
				url = "https://172.16.100.90/AgentInfo/issueRelay/"+issueRelayService.createKey();
			} else {
				url = "https://qa.secuve.com/AgentInfo/issueRelay/"+issueRelayService.createKey();
			}
			issueRelay.setIssueRelayUrl(url);
			issueRelay.setIssueRelayDate(issueRelayService.nowDate());
			issueRelayService.insertIssueRelay(issueRelay);
		}
		model.addAttribute("url", url);
		model.addAttribute("issueCustomer", issueCustomer);
		model.addAttribute("issueTitle", issueTitle);
		return "/issue/IssueUrlView";
	}
	
	@GetMapping(value = "/issueRelayA/{issueRelayRandomUrl}")
	public String IssueRelayAView(Model model, @PathVariable String issueRelayRandomUrl) {
		try {
			IssueRelay issueRelay = issueRelayService.getIssueRelayUrlOne(issueRelayRandomUrl);
			ArrayList<Issue> issue = new ArrayList<>(issueService.getIssueOneIssueApplyYn(issueRelay.getIssueKeyNum()));
			
			if(issue.size() == 0) {
				return "/issueRelay/issueRelayComplete";
			}
			
			ArrayList<IssueRelay> issueRelayList = new ArrayList<>(issueRelayService.getIssueRelayList(issueRelay.getIssueKeyNum()));
			Issue issueTitle = issueService.getIssueOneTitle(issueRelay.getIssueKeyNum());
			
			model.addAttribute("issue",issue);
			model.addAttribute("issueRelayList", issueRelayList);
			model.addAttribute("issueTitle", issueTitle);
		} catch (Exception e) {
			return "/issueRelay/issueRelayFail";
		}
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
	
	@PostMapping(value = "/issueRelay/relayImprovementsModal")
	public String IssueImprovementsRelayModal(Model model, int issuePrimaryKeyNum, int issueKeyNum, String issueRelayType) {
		Issue issue = issueService.getIssuePrimaryOne(issuePrimaryKeyNum);
			
		model.addAttribute("issueConfirm", issue.getIssueConfirm());
		model.addAttribute("issuePrimaryKeyNum", issue.getIssuePrimaryKeyNum());
		model.addAttribute("issueKeyNum", issueKeyNum);
		model.addAttribute("issueRelayType", issueRelayType);
		model.addAttribute("viewType","insert");
		return "/issueRelay/issueRelayImprovementsModal";
	}
	
	@PostMapping(value = "/issueRelay/relayUpdateModal")
	public String IssueRelayUpdateModal(Model model, int issueRelayKeyNum, int issuePrimaryKeyNum) {
		IssueRelay issueRelay = issueRelayService.getIssueRelayOne(issueRelayKeyNum);
		Issue issue = issueService.getIssuePrimaryOne(issueRelay.getIssuePrimaryKeyNum());
			
		model.addAttribute("issueConfirm", issue.getIssueConfirm());
		model.addAttribute("issueRelayKeyNum", issueRelayKeyNum);
		model.addAttribute("issuePrimaryKeyNum", issuePrimaryKeyNum);
		model.addAttribute("issueRelayDetail", issueRelay.getIssueRelayDetail());
		model.addAttribute("issueRelayStatus", issueRelay.getIssueRelayStatus());
		model.addAttribute("issueRelayType", issueRelay.getIssueRelayType());
		model.addAttribute("viewType","update");
		return "/issueRelay/issueRelayModal";
	}
	
	@ResponseBody
	@PostMapping(value = "/issueRelay/relay")
	public Map Relay(IssueRelay issueRelay) {
		Map resultMap = new HashMap();
		issueRelay.setIssueRelayDetail(xssConfig.sanitize(issueRelay.getIssueRelayDetail()));
		IssueRelay issueRelayOne = issueRelayService.getIssueRelayIssueOne(issueRelay.getIssueKeyNum());
		if(!issueRelay.getIssueRelayType().equals("QA")) {
			issueRelayOne.setIssueRelayStatus(issueRelay.getIssueRelayStatus());
		}
		
		if(issueRelayOne == null) {
			resultMap.put("result", "UrlExport");
			return resultMap;
		}
		if(issueRelay.getIssueRelayDetail().equals("해당 이슈를 수정완료 하였습니다.")) {
			issueRelayOne.setIssueRelayStatus("해결");
		} else if(issueRelay.getIssueRelayDetail().equals("해당 이슈는 오탐입니다.")) {
			issueRelayOne.setIssueRelayStatus("오탐");
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
	@PostMapping(value = "/issueRelay/improvementsRelay")
	public Map improvementsRelay(IssueRelay issueRelay) {
		Map resultMap = new HashMap();
		IssueRelay issueRelayOne = issueRelayService.getIssueRelayIssueOne(issueRelay.getIssueKeyNum());
		issueRelayOne.setIssueRelayStatus(issueRelay.getIssueRelayStatus());
		if(issueRelayOne == null) {
			resultMap.put("result", "UrlExport");
			return resultMap;
		}
		issueRelayOne.setIssueRelayStatus(issueRelay.getIssueRelayStatus());
		issueRelayOne.setIssuePrimaryKeyNum(issueRelay.getIssuePrimaryKeyNum());
		issueRelayOne.setIssueRelayDetail(issueRelay.getIssueRelayDetail());
		issueRelayOne.setIssueRelayType(issueRelay.getIssueRelayType());
		issueRelayOne.setIssueRelayDate(issueRelayService.nowDate());
		Issue issue = issueService.getIssuePrimaryOne(issueRelay.getIssuePrimaryKeyNum());
		issueRelayService.insertUseralarm(issue);
		issue.setIssueAnswerStatus("complete");
		issueService.updateIssueAnswerStatus(issue);
		issueRelayService.updateImprovementsRelay(issueRelay);
		return issueRelayService.insertIssueRelay(issueRelayOne);
	}
	
	@ResponseBody
	@PostMapping(value = "/issueRelay/deleteImprovements")
	public Map deleteImprovements(IssueRelay issueRelay) {
		Map resultMap = new HashMap();
		IssueRelay issueRelayOne = issueRelayService.getIssuePrimaryKeyNumOne(issueRelay.getIssuePrimaryKeyNum());
		issueRelayOne.setIssueRelayStatus(issueRelay.getIssueRelayStatus());
		if(issueRelayOne == null) {
			resultMap.put("result", "UrlExport");
			return resultMap;
		}
		issueRelayOne.setIssueRelayStatus("대기");
		issueRelayOne.setIssuePrimaryKeyNum(issueRelay.getIssuePrimaryKeyNum());
		issueRelayOne.setIssueRelayDetail(issueRelay.getIssueRelayDetail());
		issueRelayOne.setIssueRelayType(issueRelay.getIssueRelayType());
		issueRelayOne.setIssueRelayDate(issueRelayService.nowDate());
		Issue issue = issueService.getIssuePrimaryOne(issueRelay.getIssuePrimaryKeyNum());
		issueRelayService.insertUseralarm(issue);
		issue.setIssueAnswerStatus("complete");
		issueService.updateIssueAnswerStatus(issue);
		issueRelay.setIssueRelayStatus("대기");
		issueRelayService.updateImprovementsRelay(issueRelay);
		return issueRelayService.insertIssueRelay(issueRelayOne);
	}
	
	@ResponseBody
	@PostMapping(value = "/issueRelay/relayUpdate")
	public String RelayUpdate(IssueRelay issueRelay) {
		issueRelay.setIssueRelayDetail(xssConfig.sanitize(issueRelay.getIssueRelayDetail()));
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
	public String IssueList(Model model, Principal principal, HttpServletRequest req, String target) {
		Map<String, String> targetMap = issueService.targetDivision(target);
		
		
		
		model.addAttribute("issueCustomer", issueService.getSelectInputTarget("issueCustomer", targetMap.get("issueTarget"), targetMap.get("issueSubTarget")));
		model.addAttribute("issueTitle", issueService.getSelectInputTarget("issueTitle", targetMap.get("issueTarget"), targetMap.get("issueSubTarget")));
		model.addAttribute("issueTosms", issueService.getSelectInputTarget("issueTosms", targetMap.get("issueTarget"), targetMap.get("issueSubTarget")));
		model.addAttribute("issueTosrf", issueService.getSelectInputTarget("issueTosrf", targetMap.get("issueTarget"), targetMap.get("issueSubTarget")));
		model.addAttribute("issuePortal", issueService.getSelectInputTarget("issuePortal", targetMap.get("issueTarget"), targetMap.get("issueSubTarget")));
		model.addAttribute("issueJava", issueService.getSelectInputTarget("issueJava", targetMap.get("issueTarget"), targetMap.get("issueSubTarget")));
		model.addAttribute("issueWas", issueService.getSelectInputTarget("issueWas", targetMap.get("issueTarget"), targetMap.get("issueSubTarget")));
		model.addAttribute("issueTarget", targetMap.get("issueTarget"));
		model.addAttribute("issueSubTarget", targetMap.get("issueSubTarget"));
		model.addAttribute("issueFirstWriter", issueService.getSelectInputTarget("issueFirstWriter", targetMap.get("issueTarget"), targetMap.get("issueSubTarget")));
		model.addAttribute("target", target);
		
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
	
	
	/*  ---------------------- IssueRelay B -----------------------------  */
	
	
	@GetMapping(value = "/issueRelay/{issueRelayRandomUrl}")
	public String IssueRelayView(Model model, @PathVariable String issueRelayRandomUrl) {
		try {
			IssueRelay issueRelay = issueRelayService.getIssueRelayUrlOne(issueRelayRandomUrl);
			ArrayList<Issue> issue = new ArrayList<>(issueService.getIssueOneIssueApplyYnItem(issueRelay.getIssueKeyNum()));
			
			if(issue.size() == 0) {
				return "/issueRelay/issueRelayComplete";
			}
			
			//ArrayList<IssueRelay> issueRelayList = new ArrayList<>(issueRelayService.getIssueRelayList(issueRelay.getIssueKeyNum()));
			Issue issueTitle = issueService.getIssueOneTitle(issueRelay.getIssueKeyNum());
			
			long remainingTimeInSeconds = issueService.getRemainingTimeInSeconds(issueTitle.getIssueManagerServerTimmer());
			
			model.addAttribute("remainingTimeInSeconds", remainingTimeInSeconds);
			model.addAttribute("issue",issue);
			//model.addAttribute("issueRelayList", issueRelayList);
			model.addAttribute("issueTitle", issueTitle);
			model.addAttribute("issueRelayRandomUrl",issueRelayRandomUrl);
		} catch (Exception e) {
			return "/issueRelay/issueRelayFail";
		}
		return "/issueRelay/issueRelayItemView";
	}
	
	@ResponseBody
	@PostMapping(value = "/issueRelay/item")
	public Map IssueRelayItem(String issueRelayRandomUrl, int issuePrimaryKeyNum) {
		IssueRelay issueRelay = issueRelayService.getIssueRelayUrlOne(issueRelayRandomUrl);
		ArrayList<IssueRelay> issueRelayList = new ArrayList<>(issueRelayService.getIssueRelayList(issueRelay.getIssueKeyNum()));
		Issue issue = issueService.getIssuePrimaryOne(issuePrimaryKeyNum);
		Map map = new HashMap();
		map.put("issueRelayList", issueRelayList);
		map.put("issue", issue);
		return map;
	}
	
	@GetMapping(value = "/issueRelay/improvementsList")
	public String ImprovementsList(Model model, String target) {
		ArrayList<String> issuePrimaryKeyNumList = new ArrayList<>(issueRelayService.getIssueRelayImprovements());
		ArrayList<Issue> issue = new ArrayList<>(issueService.getIssueOneImprovements(issuePrimaryKeyNumList, target));
		
		if(issue.size() == 0) {
			return "/issueRelay/issueRelayImprovements";
		}
		model.addAttribute("issue",issue);
		return "/issueRelay/improvementsList";
	}
	
	@ResponseBody
	@PostMapping(value = "/issueRelay/improvementsitem")
	public Map IssueRelayImprovementsItem(int issuePrimaryKeyNum) {
		Issue issue = issueService.getIssuePrimaryOne(issuePrimaryKeyNum);
		ArrayList<IssueRelay> issueRelayList = new ArrayList<>(issueRelayService.getIssueRelayImprovementsItem(issue.getIssueKeyNum()));
		
		Map map = new HashMap();
		map.put("issueRelayList", issueRelayList);
		map.put("issue", issue);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/issueRelay/managerStatusChange")
	public String ManagerStatusChange(Issue issue) {
		return issueService.updateManagerStatusChange(issue);
	}
	
	
}

