package com.secuve.agentInfo.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.locks.Lock;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.secuve.agentInfo.core.FileDownloadView;
import com.secuve.agentInfo.core.PDFDownlod;
import com.secuve.agentInfo.service.EmployeeService;
import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.IssueRelayService;
import com.secuve.agentInfo.service.IssueService;
import com.secuve.agentInfo.vo.Issue;
import com.secuve.agentInfo.vo.IssueRelay;



@Controller
public class IssueController {
	@Autowired IssueService issueService;
	@Autowired PDFDownlod pdfDownlod;
	@Autowired FavoritePageService favoritePageService;
	@Autowired IssueRelayService issueRelayService;
	@Autowired EmployeeService employeeService;
	
	@GetMapping(value = "/issue/issueList")
	public String IssueList(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "이슈 목록");
		
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
		//search.setIssueProceStatus(String.join(",",search.getIssueProceStatusMulti()));
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
	public String ExistingNew(Model model, Principal principal) {
		ArrayList<Issue> issueList = new ArrayList<Issue>();
		Issue issue = new Issue();
		issue.setIssueKeyNum(0);
		issueList.add(issue);
		model.addAttribute("issue",issueList);
		model.addAttribute("issueTitle", issue);
		model.addAttribute("viewType", "insert");
		model.addAttribute("issueWriter", employeeService.getEmployeeOne(principal.getName()).getEmployeeName());
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
	@PostMapping(value = "/issue/complete")
	public String IssueComplete(@RequestParam int[] chkList) {
		return issueService.proceStatusChange(chkList, "complete");
	}
	
	@ResponseBody
	@PostMapping(value = "/issue/update")
	public String IssueUpdate(Issue issue, Principal principal) {
		issue.setIssueModifier(principal.getName());
		issue.setIssueModifiedDate(issueService.nowDate());
		
		return issueService.updateIssue(issue, principal);
	}
	
	@ResponseBody
	@PostMapping(value = "/issue/copy")
	public Map IssueCopy(Issue issue, Principal principal) {
		issue.setIssueModifier(principal.getName());
		issue.setIssueModifiedDate(issueService.nowDate());
		
		Map result = issueService.copyIssue(issue, principal);
		return result;
	}
	
	@Autowired private Lock lock;
    @Autowired private Set<String> usersInUpdateView;
    Map<String, String> lockMap = new HashMap<String, String>();
    
	@GetMapping(value = "/issue/updateView")
	public String UpdateView(Model model, Principal principal, int issueKeyNum) {
		Issue issueTitle = issueService.getIssueOneTitle(issueKeyNum);
		ArrayList<Issue> issue = new ArrayList<>(issueService.getIssueOne(issueKeyNum));
		ArrayList<IssueRelay> issueRelayList = new ArrayList<>(issueRelayService.getIssueRelayList(issueKeyNum));
		ArrayList<Integer> alarmIndex = new ArrayList<>(employeeService.getAlarmIndex(issueKeyNum, principal.getName()));
		ArrayList<Integer> issuePrimaryKeyNumList = new ArrayList<>(issueRelayService.getIssuePrimaryKeyNumList(issueKeyNum));
		employeeService.updateAlarmY(issueKeyNum, principal.getName());
		
		model.addAttribute("viewType", "update");
		model.addAttribute("issueTitle", issueTitle);
		model.addAttribute("issue",issue);
		model.addAttribute("issueWriter", employeeService.getEmployeeOne(principal.getName()).getEmployeeName());
		model.addAttribute("issueRelayList", issueRelayList);
		model.addAttribute("issuePrimaryKeyNumList", issuePrimaryKeyNumList);
		model.addAttribute("alarmIndex", alarmIndex);
		lock.lock(); // Lock 획득
        try {
            if (usersInUpdateView.contains("issue_"+issueKeyNum)) {
            	System.out.println(usersInUpdateView.iterator());
                // 다른 사용자가 이미 해당 페이지에 접근 중이므로 읽기 전용 페이지를 반환
            	model.addAttribute("connecter", employeeService.getEmployeeOne(lockMap.get("issue_"+issueKeyNum)).getEmployeeName());
                return "issue/IssueReadView";
            } else {
                // 첫 번째 사용자가 해당 페이지에 접근한 경우 사용자 집합에 추가
                usersInUpdateView.add("issue_"+issueKeyNum);
                if(lockMap.get("issue_"+issueKeyNum) == "" || lockMap.get("issue_"+issueKeyNum) == null) {
                	lockMap.put("issue_"+issueKeyNum, principal.getName());
                }
            }
        } finally {
            lock.unlock(); // Lock 해제
        }
		return "issue/IssueView";
	}
	
	@ResponseBody
	@GetMapping("/issue/leaveView")
    public void leaveView(Principal principal, int issueKeyNum) {
		if(principal.getName().equals(lockMap.get("issue_"+issueKeyNum))) {
			lock.lock();
	        try {
	            usersInUpdateView.remove("issue_"+issueKeyNum);
	            lockMap.remove("issue_" + issueKeyNum);
	        } finally {
	            lock.unlock();
	        }
		}
    }
	
	@ResponseBody
	@GetMapping("/issue/checkUserStatus")
	public void checkUserStatus(Principal principal, int issueKeyNum) {
		if(principal.getName().equals(lockMap.get("issue_"+issueKeyNum))) {
		    lock.lock();
		    try {
		        usersInUpdateView.remove("issue_"+issueKeyNum);
		        lockMap.remove("issue_" + issueKeyNum);
		    } finally {
		        lock.unlock();
		    }
		}
	}
	
	@ResponseBody
	@GetMapping("/issue/leaveAndRedirectToList")
	public void leaveAndRedirectToList(int issueKeyNum) {
		lock.lock();
	    try {
	        usersInUpdateView.remove("issue_"+issueKeyNum);
	        lockMap.remove("issue_" + issueKeyNum);
	    } finally {
	        lock.unlock();
	    }
	}

	
	@GetMapping(value = "/issue/copyView")
	public String CopyView(Model model, Principal principal, int issueKeyNum) {
		Issue issueTitle = issueService.getIssueOneTitle(issueKeyNum);
		ArrayList<Issue> issue = new ArrayList<>(issueService.getIssueOne(issueKeyNum));
		
		model.addAttribute("viewType", "copy");
		model.addAttribute("issueTitle", issueTitle);
		model.addAttribute("issue",issue);
		model.addAttribute("issueWriter", principal.getName());
		return "issue/IssueView";
	}
	
	
	@RequestMapping(value = "/issue/pdfView", method = RequestMethod.POST)
	public String PdfView(Model model, int issueKeyNum, String[] chkSelectBox) {
		Issue issueTitle = issueService.getIssueOneTitle(issueKeyNum);
		ArrayList<Issue> issue = new ArrayList<>(issueService.getIssuePDFOne(issueKeyNum, chkSelectBox));
		ArrayList<IssueRelay> issueRelayList = new ArrayList<>(issueRelayService.getIssueRelayList(issueKeyNum));
		
		model.addAttribute("viewType", "download");
		model.addAttribute("issueTitle", issueTitle);
		model.addAttribute("issue",issue);
		model.addAttribute("issueRelayList", issueRelayList);
		return "issue/PdfView";
	}
	
	
	@RequestMapping(value = "/issue/pdfViewHistory", method = RequestMethod.POST)
	public String PdfViewHistory(Model model, int issueKeyNum) {
		Issue issueTitle = issueService.getIssueOneTitle(issueKeyNum);
		ArrayList<Issue> issue = new ArrayList<>(issueService.getIssueOne(issueKeyNum));
		
		model.addAttribute("viewType", "history");
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
			pdfDownlod.makepdf(BODY, filePath + "\\" + fileName);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "FALSE";
		}
		return "OK"; 
	}
	
	
	@ResponseBody
	@PostMapping(value = "/issue/pdfHistory")
	public String PDFHistory(String jsp, String issueCustomer, String issueTitle, String issueDate, Principal principal, Model model) {
		StringBuilder html = new StringBuilder();
		String body = jsp;
		
		html.append(body);
		String filePath = "C:\\AgentInfo\\IssueHistoryDownload";
		String fileName = issueCustomer + "_" + issueTitle + "_" + issueDate + ".pdf";

		String BODY = body.toString();

		// html to pdf
		try {
			pdfDownlod.makepdf(BODY, filePath + "\\" + fileName);
		} catch (Exception e) {
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
	
	@ResponseBody
	@PostMapping(value = "/issue/issuePlus")
	public int IssuePlus(Principal principal, Issue issue) {
		Issue issueOne = issueService.getIssuePrimaryOne(issue.getIssuePrimaryKeyNum());
		issueService.issueSortNumPlus(issueOne.getIssueSortNum());
		issue = issueService.getIssueKeyNumOne(issue.getIssueKeyNum());
		issue.setIssueSortNum(issueOne.getIssueSortNum()+1);
		issue.setIssueRegistrant(principal.getName());
		issue.setIssueRegistrationDate(issueService.nowDate());
		issue.setIssueWriter(employeeService.getEmployeeOne(principal.getName()).getEmployeeName());
		issue.setIssueTarget(issueOne.getIssueTarget());
		issue.setIssueSubTarget(issueOne.getIssueSubTarget());
		issue.setIssueFirstDate(issueOne.getIssueFirstDate());
		issue.setIssueFirstWriter(issueOne.getIssueFirstWriter());
		issue.setIssueTester(issueOne.getIssueTester());
		return issueService.insertIssuePlus(issue);
	}
	
	@ResponseBody
	@PostMapping(value = "/issue/issueMinus")
	public String IssueMinus(Principal principal, Issue issue) {
		return issueService.issueMinus(issue.getIssuePrimaryKeyNum());

	}
	
	@ResponseBody
	@PostMapping(value = "/issue/issueUp")
	public String IssueUp(int issueKeyNum, int issuePrimaryKeyNum) {
		Issue issue = issueService.getIssuePrimaryOne(issuePrimaryKeyNum);
		try {
			return issueService.getIssueSortNumUp(issueKeyNum, issue.getIssueSortNum(), issuePrimaryKeyNum);
		} catch (Exception e) {
			return "NoneUp";
		}
		
	}
	
	@ResponseBody
	@PostMapping(value = "/issue/issueDown")
	public String IssueDown(int issueKeyNum, int issuePrimaryKeyNum) {
		Issue issue = issueService.getIssuePrimaryOne(issuePrimaryKeyNum);
		Issue findIssue = issueService.getIssueSortNumDown(issueKeyNum, issue.getIssueSortNum());
		try {
			return issueService.changIssueSortNum(issue, findIssue);
		} catch (Exception e) {
			return "NoneDown";
		}
	}
	
	@ResponseBody
	@PostMapping(value = "/issue/alarmCheck")
	public String AlarmCheck(Principal principal, int userAlarmParameter) {
		return issueService.updateUserAlarm(principal.getName(), userAlarmParameter);
	}
	
	@ResponseBody
	@PostMapping(value = "/issue/checkPermissions")
	public String CheckPermissions(Principal principal, int issueKeyNum) {
		if(issueKeyNum == 0) {
			return "SavePlease";
		}
			
		if(!principal.getName().equals(lockMap.get("issue_"+issueKeyNum))) {
			return "NoAuthority";
		}
		return "OK";
	}
	
}

