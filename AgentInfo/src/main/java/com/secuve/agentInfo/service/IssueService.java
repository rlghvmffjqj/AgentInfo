package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.EmployeeDao;
import com.secuve.agentInfo.dao.IssueDao;
import com.secuve.agentInfo.vo.Issue;
import com.secuve.agentInfo.vo.UserAlarm;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class IssueService {
	@Autowired IssueDao issueDao;
	@Autowired IssueHistoryService issueHistoryService;
	@Autowired EmployeeDao employeeDao;
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public Map<String, Object> insertIssue(Issue issue, Principal principal) {
		Map<String, Object> map = new HashMap<>();
		issue.setIssueKeyNum(IssueKeyNum(issue.getIssueKeyNum()));
		map.put("issueKeyNum", issue.getIssueKeyNum());
		
		LocalDate currentDate = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		issue.setIssueFirstDate(currentDate.format(formatter));
		issue.setIssueFirstWriter(employeeDao.getEmployeeOne(principal.getName()).getEmployeeName());
		
		int success = 1;
		issue = oneDate(issue);
		for(int i=0; i < issue.getIssueOsList().size(); i++) {
			success *= issueDao.insertIssue(issue.getIssueKeyNum(), 
										issue.getIssueCustomer(), 
										issue.getIssueTitle(), 
										issue.getIssueManagerServer(), 
										issue.getIssueTarget(), 
										issue.getIssueSubTarget(), 
										issue.getIssueFirstWriter(), 
										issue.getIssueFirstDate(), 
										issue.getIssueDate(), 
										issue.getIssueTosms(), 
										issue.getIssueTosrf(), 
										issue.getIssuePortal(), 
										issue.getIssueJava(), 
										issue.getIssueWas(), 
										issue.getTotal(), 
										issue.getSolution(), 
										issue.getUnresolved(), 
										issue.getHold(), 
										issue.getIssueDivisionList().get(i), 
										issue.getIssueOsList().get(i), 
										issue.getIssueWriterList().get(i), 
										issue.getIssueAwardList().get(i), 
										issue.getIssueMiddleList().get(i), 
										issue.getIssueUnder1List().get(i), 
										issue.getIssueUnder2List().get(i), 
										issue.getIssueUnder3List().get(i), 
										issue.getIssueUnder4List().get(i), 
										issue.getIssueFlawNumList().get(i), 
										issue.getIssueEffectList().get(i), 
										issue.getIssueTextResultList().get(i), 
										issue.getIssueApplyYnList().get(i), 
										issue.getIssueConfirmList().get(i), 
										issue.getIssueObstacleList().get(i), 
										issue.getIssueNoteList().get(i), 
										issue.getIssueRegistrant(), 
										issue.getIssueRegistrationDate(), 
										issue.getIssueModifier(), 
										issue.getIssueModifiedDate());
		}
		map.put("result", success <= 0 ? "FALSE" : "OK");
	    if (success > 0) {
	        map.put("issueKeyNum", issue.getIssueKeyNum());
	    }

	    return map;
	}
	
	public Issue oneDate(Issue issue) {
		List<String> emptyList = Collections.singletonList("");  // List with one empty string element.

	    issue.setIssueDivisionList(issue.getIssueDivisionList().isEmpty() ? emptyList : issue.getIssueDivisionList());
	    issue.setIssueOsList(issue.getIssueOsList().isEmpty() ? emptyList : issue.getIssueOsList());
	    issue.setIssueWriterList(issue.getIssueWriterList().isEmpty() ? emptyList : issue.getIssueWriterList());
	    issue.setIssueAwardList(issue.getIssueAwardList().isEmpty() ? emptyList : issue.getIssueAwardList());
	    issue.setIssueMiddleList(issue.getIssueMiddleList().isEmpty() ? emptyList : issue.getIssueMiddleList());
	    issue.setIssueUnder1List(issue.getIssueUnder1List().isEmpty() ? emptyList : issue.getIssueUnder1List());
	    issue.setIssueUnder2List(issue.getIssueUnder2List().isEmpty() ? emptyList : issue.getIssueUnder2List());
	    issue.setIssueUnder3List(issue.getIssueUnder3List().isEmpty() ? emptyList : issue.getIssueUnder3List());
	    issue.setIssueUnder4List(issue.getIssueUnder4List().isEmpty() ? emptyList : issue.getIssueUnder4List());
	    issue.setIssueFlawNumList(issue.getIssueFlawNumList().isEmpty() ? emptyList : issue.getIssueFlawNumList());
	    issue.setIssueEffectList(issue.getIssueEffectList().isEmpty() ? emptyList : issue.getIssueEffectList());
	    issue.setIssueTextResultList(issue.getIssueTextResultList().isEmpty() ? emptyList : issue.getIssueTextResultList());
	    issue.setIssueApplyYnList(issue.getIssueApplyYnList().isEmpty() ? emptyList : issue.getIssueApplyYnList());
	    issue.setIssueConfirmList(issue.getIssueConfirmList().isEmpty() ? emptyList : issue.getIssueConfirmList());
	    issue.setIssueObstacleList(issue.getIssueObstacleList().isEmpty() ? emptyList : issue.getIssueObstacleList());
	    issue.setIssueNoteList(issue.getIssueNoteList().isEmpty() ? emptyList : issue.getIssueNoteList());

		return issue;
	}
	
	public List<Issue> getIssueList(Issue search) {
		return issueDao.getIssueList(issueSearch(search));
	}

	public int getIssueListCount(Issue search) {
		return issueDao.getIssueListCount(issueSearch(search));
	}
	
	public Issue issueSearch(Issue search) {
		search.setIssueCustomerArr(search.getIssueCustomer().split(","));
		search.setIssueTitleArr(search.getIssueTitle().split(","));
		search.setIssueTosmsArr(search.getIssueTosms().split(","));
		search.setIssueTosrfArr(search.getIssueTosrf().split(","));
		search.setIssuePortalArr(search.getIssuePortal().split(","));
		search.setIssueJavaArr(search.getIssueJava().split(","));
		search.setIssueWasArr(search.getIssueWas().split(","));
		search.setIssueProceStatusArr(search.getIssueProceStatus().split(","));
		
		return search;
	}
	
	public int IssueKeyNum(int issueKeyNum) {
		if(issueKeyNum == 0) {
			issueKeyNum = 1;
		} else {
			return issueKeyNum;
		}
		try {
			issueKeyNum = issueDao.getIssueKeyNum();
		} catch (Exception e) {
			return issueKeyNum;
		}
		return ++issueKeyNum;
	}

	public List<String> getSelectInput(String selectInput) {
		return issueDao.getSelectInput(selectInput);
	}

	public List<Issue> getIssueOne(int issueKeyNum) {
		return issueDao.getIssueOne(issueKeyNum);
	}

	public Issue getIssueOneTitle(int issueKeyNum) {
		return issueDao.getIssueOneTitle(issueKeyNum);
	}

	public String delIssue(int[] chkList) {
		for (int issueKeyNum : chkList) {
			int success = issueDao.delIssue(issueKeyNum);
			employeeDao.delUserAlarm(issueKeyNum);
			if (success <= 0)
				return "FALSE";
			
			issueHistoryService.issueDeleteHistory(issueKeyNum);
		}
		return "OK";
	}


	public String updateIssue(Issue issue, Principal principal) {
		Map<String, String> issueWriteMap = new HashMap<String, String>();
		for(int i=0; i < issue.getIssueOsList().size(); i++) {
			issueWriteMap.put(issue.getIssueWriterList().get(i), issue.getIssueWriterList().get(i));
		}
		
		StringBuilder issueTester = new StringBuilder();
        for (String value : issueWriteMap.values()) {
            if (issueTester.length() > 0) {
            	issueTester.append(", ");
            }
            issueTester.append(value);
        }
		int success = 1;
		issue = oneDate(issue);
		for(int i=0; i < issue.getIssueOsList().size(); i++) {
			success *= issueDao.updateIssue(issue.getIssuePrimaryKeyNumList().get(i), 
					issue.getIssueKeyNum(), 
					issue.getIssueCustomer(),
					issue.getIssueTitle(), 
					issue.getIssueManagerServer(), 
					issue.getIssueTarget(), 
					issue.getIssueSubTarget(), 
					issue.getIssueFirstWriter(), 
					issueTester.toString(), 
					issue.getIssueFirstDate(), 
					issue.getIssueDate(), 
					issue.getIssueTosms(), 
					issue.getIssueTosrf(), 
					issue.getIssuePortal(), 
					issue.getIssueJava(), 
					issue.getIssueWas(), 
					issue.getTotal(), 
					issue.getSolution(), 
					issue.getUnresolved(), 
					issue.getHold(), 
					issue.getIssueDivisionList().get(i), 
					issue.getIssueOsList().get(i), 
					issue.getIssueWriterList().get(i), 
					issue.getIssueAwardList().get(i), 
					issue.getIssueMiddleList().get(i), 
					issue.getIssueUnder1List().get(i), 
					issue.getIssueUnder2List().get(i), 
					issue.getIssueUnder3List().get(i), 
					issue.getIssueUnder4List().get(i), 
					issue.getIssueFlawNumList().get(i), 
					issue.getIssueEffectList().get(i), 
					issue.getIssueTextResultList().get(i), 
					issue.getIssueApplyYnList().get(i), 
					issue.getIssueConfirmList().get(i), 
					issue.getIssueObstacleList().get(i), 
					issue.getIssueNoteList().get(i), 
					issue.getIssueRegistrant(), 
					issue.getIssueRegistrationDate(), 
					issue.getIssueModifier(), 
					issue.getIssueModifiedDate()
			);
		}
		if (success <= 0) {
			return "FALSE";
		} 
		List<Issue> issueApplyList = issueDao.getIssueApplyYn(issue.getIssueKeyNum());
		if(issueApplyList.size() == 0) {
			issueDao.proceStatusChange(issue.getIssueKeyNum(), "complete");
			return "Complete";
		}
		return "OK";
	}

	public Map<String, Object> copyIssue(Issue issue, Principal principal) {
		issue.setIssueKeyNum(0);
		return insertIssue(issue, principal);
	}

	public String mergeIssue(int[] chkList) {
		int total = 0;
		int solution = 0;
		int unresolved = 0;
		int hold = 0;
		boolean check = false;
		int result = 1;
		List<Issue> issue = new ArrayList<Issue>(); 
		for (int issueKeyNum : chkList) {
			issue.add(issueDao.getIssueOneMerge(issueKeyNum));
		}
		
		for(int i=0; i<chkList.length; i++) {
			issue.get(i).setIssueKeyNum(0);
			total += Integer.parseInt(issue.get(i).getTotal());
			solution += Integer.parseInt(issue.get(i).getSolution());
			unresolved += Integer.parseInt(issue.get(i).getUnresolved());
			hold += Integer.parseInt(issue.get(i).getHold());
			
			issue.get(i).setTotal("");
			issue.get(i).setSolution("");
			issue.get(i).setUnresolved("");
			issue.get(i).setHold("");
		}
		
		if(chkList.length == 2) {
			check = Objects.equals(issue.get(0).toString(), issue.get(1).toString());
		} else if(chkList.length == 3) {
			check = Objects.equals(issue.get(0).toString(), issue.get(1).toString());
			if(check == true) {
				check = Objects.equals(issue.get(1).toString(), issue.get(2).toString());
			}
		} 
		if(check == false) {
			return "NotMatch";
		}
		
		int newKeyNum =  IssueKeyNum(0);
		for (int issueKeyNum : chkList) {
			result *= issueDao.setIssueKeyNum(issueKeyNum, newKeyNum, total, solution, unresolved, hold);
			issueHistoryService.setIssueKeyNumUpdate(issueKeyNum, newKeyNum);
		}
		
		return result >= 1 ? "OK" : "FALSE";
	}

	public List<Issue> getIssuePDFOne(int issueKeyNum, String[] chkSelectBox) {
		if(chkSelectBox == null) {
			List<Issue> issueList = new ArrayList<Issue>();
			return issueList;
		}
		return issueDao.getIssuePDFOne(issueKeyNum, chkSelectBox);
	}

	public Issue getIssuePrimaryOne(int issuePrimaryKeyNum) {
		return issueDao.getIssuePrimaryOne(issuePrimaryKeyNum);
	}

	public int insertIssuePlus(Issue issue) {
		issueDao.insertIssuePlus(issue);
		issueDao.totalPlus(issue.getIssueKeyNum());
		issueDao.unresolvedPlus(issue.getIssueKeyNum());
		return issue.getIssuePrimaryKeyNum();
	}

	public Issue getIssueKeyNumOne(int issueKeyNum) {
		return issueDao.getIssueKeyNumOne(issueKeyNum);
	}

	public String issueMinus(int issuePrimaryKeyNum) {
		int result = issueDao.issueMinus(issuePrimaryKeyNum);
		 return result >= 1 ? "OK" : "FALSE";
	}
	
	public String getIssueSortNumUp(int issueKeyNum, int issueSortNum, int issuePrimaryKeyNum) {
		int fineIssueSortNum = issueDao.getIssueSortNumUp(issueKeyNum, issueSortNum);
		int result = issueDao.upIssueSortNum(fineIssueSortNum);
		result *=  issueDao.changIssueSortNum(issuePrimaryKeyNum, fineIssueSortNum);
		if(result >= 1) {
			return "OK";
		}
		return "FALSE";
	}

	
	public Issue getIssueSortNumDown(int issueKeyNum, int issueSortNum) {
		return issueDao.getIssueSortNumDown(issueKeyNum, issueSortNum);
	}

	public String changIssueSortNum(Issue issue, Issue findIssue) {
		int result = issueDao.changIssueSortNum(findIssue.getIssuePrimaryKeyNum(), issue.getIssueSortNum());
		result *= issueDao.changIssueSortNum(issue.getIssuePrimaryKeyNum(), findIssue.getIssueSortNum());
		return result >= 1 ? "OK" : "FALSE";
	}

	public List<Issue> getIssueOneIssueApplyYn(int issueKeyNum) {
		return issueDao.getIssueOneIssueApplyYn(issueKeyNum);
	}
	
	public List<Issue> getIssueOneIssueApplyYnItem(int issueKeyNum) {
		return issueDao.getIssueOneIssueApplyYnItem(issueKeyNum);
	}

	public String  updateUserAlarm(String employeeId, int userAlarmParameter) {
		UserAlarm userAlarm = new UserAlarm();
		userAlarm.setUserAlarmEmployeeId(employeeId);
		userAlarm.setUserAlarmModifier(employeeId);
		userAlarm.setUserAlarmModifiedDate(nowDate());
		userAlarm.setUserAlarmParameter(userAlarmParameter);
		int result = employeeDao.updateUserAlarm(userAlarm);
		
		return result >= 1 ? "OK" : "FALSE";
	}

	public void issueSortNumPlus(int issueSortNum) {
		issueDao.issueSortNumPlus(issueSortNum);
		
	}

	public void updateIssueAnswerStatus(Issue issue) {
		issueDao.updateIssueAnswerStatus(issue);
	}

	public String proceStatusChange(int[] chkList, String issueProceStatus) {
		for (int issueKeyNum : chkList) {
			int success = issueDao.proceStatusChange(issueKeyNum, issueProceStatus);
			if (success <= 0)
				return "FALSE";
		}
		return "OK";
	}

	public List<String> getSelectInputTarget(String selectInput, String issueTarget, String issueSubTarget) {
		return issueDao.getSelectInputTarget(selectInput, issueTarget, issueSubTarget);
	}

	public Map<String, String> targetDivision(String target) {
		Map<String, String> map = new HashMap<String,String>();
		if(target.equals("Agent")) {
			map.put("issueTarget", "Agent");
			map.put("issueSubTarget", "linux");
		} else if(target.equals("AgentWin")) {
			map.put("issueTarget", "Agent");
			map.put("issueSubTarget", "windows");
		} else if(target.equals("TOSMS")) {
			map.put("issueTarget", "TOSMS");
			map.put("issueSubTarget", "");
		} else {
			map.put("issueTarget", "");
			map.put("issueSubTarget", "");
		}
		return map;
	}

	public List<Issue> getIssueOneImprovements(ArrayList<String> issuePrimaryKeyNumList, String target) {
		if(issuePrimaryKeyNumList.size() == 0) {
			issuePrimaryKeyNumList.add("0");
		}
		String issueTarget = "";
		String issueSubTarget = "";
		if(target.equals("Agent")) {
			issueTarget = "Agent";
			issueSubTarget = "linux";
		} else if(target.equals("AgentWin")) {
			issueTarget = "Agent";
			issueSubTarget = "windows";
		} else if(target.equals("TOSMS")) {
			issueTarget = "TOSMS";
			issueSubTarget = "";
		} else {
			issueTarget = "";
			issueSubTarget = "";
		}
		return issueDao.getIssueOneImprovements(issuePrimaryKeyNumList, issueTarget, issueSubTarget);
	}

	public String updateManagerStatusChange(Issue issue) {
		if(issue.getIssueManagerServerStatus().equals("use")) {
			issue.setIssueManagerServerTimmer(LocalDateTime.now());
		} else {
			issue.setIssueManagerServerTimmer(null);
		}
		int success = issueDao.updateManagerStatusChange(issue);
		
		return success <= 0 ? "OK" : "FALSE";

	}

	public long getRemainingTimeInSeconds(LocalDateTime issueManagerServerTimmer) {
		try {
			LocalDateTime now = LocalDateTime.now();
	
	        LocalDateTime deadline = issueManagerServerTimmer.plusHours(24);
	
	        long remainingTimeInSeconds = ChronoUnit.SECONDS.between(now, deadline);
	        return remainingTimeInSeconds > 0 ? remainingTimeInSeconds : 0;
		} catch (Exception e) {
			return 0;
		}
	}

	public List<Integer> getIssueTimeOutList() {
		return issueDao.getIssueTimeOutList();
	}

	public void updateTimeOut(Integer issueTimeOut) {
		issueDao.updateTimeOut(issueTimeOut);
	}

}
