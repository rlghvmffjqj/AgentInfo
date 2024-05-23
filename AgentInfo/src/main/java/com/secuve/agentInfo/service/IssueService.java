package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
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

	public Map insertIssue(Issue issue, Principal principal) {
		Map map = new HashMap();
		issue.setIssueKeyNum(IssueKeyNum(issue.getIssueKeyNum()));
		map.put("issueKeyNum", issue.getIssueKeyNum());
		LocalDate currentDate = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		issue.setIssueFirstDate(currentDate.format(formatter));
		issue.setIssueFirstWriter(employeeDao.getEmployeeOne(principal.getName()).getEmployeeName());
		
		int sucess = 1;
		issue = oneDate(issue);
		for(int i=0; i < issue.getIssueOsList().size(); i++) {
			sucess *= issueDao.insertIssue(issue.getIssueKeyNum(), issue.getIssueCustomer(), issue.getIssueTitle(), issue.getIssueTarget(), issue.getIssueSubTarget(), issue.getIssueFirstWriter(), issue.getIssueFirstDate(), issue.getIssueDate(), issue.getIssueTosms(), issue.getIssueTosrf(), issue.getIssuePortal(), issue.getIssueJava(), issue.getIssueWas(), issue.getTotal(), issue.getSolution(), issue.getUnresolved(), issue.getHold(), issue.getIssueDivisionList().get(i), issue.getIssueOsList().get(i), issue.getIssueWriterList().get(i), issue.getIssueAwardList().get(i), issue.getIssueMiddleList().get(i), issue.getIssueUnder1List().get(i), issue.getIssueUnder2List().get(i), issue.getIssueUnder3List().get(i), issue.getIssueUnder4List().get(i), issue.getIssueFlawNumList().get(i), issue.getIssueEffectList().get(i), issue.getIssueTextResultList().get(i), issue.getIssueApplyYnList().get(i), issue.getIssueConfirmList().get(i), issue.getIssueObstacleList().get(i), issue.getIssueNoteList().get(i), issue.getIssueRegistrant(), issue.getIssueRegistrationDate(), issue.getIssueModifier(), issue.getIssueModifiedDate());
		}
		if (sucess <= 0) {
			map.put("result", "FALSE");
		} else {
			map.put("result", "OK");
			map.put("issueKeyNum", issue.getIssueKeyNum());
		}
		return map;
	}
	
	public Issue oneDate(Issue issue) {
		List<String> list = new ArrayList<String>();
		list.add("");
		if(issue.getIssueDivisionList().size() == 0) 
			issue.setIssueDivisionList(list);
		if(issue.getIssueOsList().size() == 0) 
			issue.setIssueOsList(list);
		if(issue.getIssueWriterList().size() == 0)
			issue.setIssueWriterList(list);
		if(issue.getIssueAwardList().size() == 0) 
			issue.setIssueAwardList(list);
		if(issue.getIssueMiddleList().size() == 0) 
			issue.setIssueMiddleList(list);
		if(issue.getIssueUnder1List().size() == 0) 
			issue.setIssueUnder1List(list);
		if(issue.getIssueUnder2List().size() == 0) 
			issue.setIssueUnder2List(list);
		if(issue.getIssueUnder3List().size() == 0) 
			issue.setIssueUnder3List(list);
		if(issue.getIssueUnder4List().size() == 0) 
			issue.setIssueUnder4List(list);
		if(issue.getIssueFlawNumList().size() == 0) 
			issue.setIssueFlawNumList(list);
		if(issue.getIssueEffectList().size() == 0) 
			issue.setIssueEffectList(list);
		if(issue.getIssueTextResultList().size() == 0) 
			issue.setIssueTextResultList(list);
		if(issue.getIssueApplyYnList().size() == 0) 
			issue.setIssueApplyYnList(list);
		if(issue.getIssueConfirmList().size() == 0) 
			issue.setIssueConfirmList(list);
		if(issue.getIssueObstacleList().size() == 0) 
			issue.setIssueObstacleList(list);
		if(issue.getIssueNoteList().size() == 0) 
			issue.setIssueNoteList(list);
		
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
			int sucess = issueDao.delIssue(issueKeyNum);
			employeeDao.delUserAlarm(issueKeyNum);
			if (sucess <= 0)
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
		int sucess = 1;
		issue = oneDate(issue);
		for(int i=0; i < issue.getIssueOsList().size(); i++) {
			sucess *= issueDao.updateIssue(issue.getIssuePrimaryKeyNumList().get(i), issue.getIssueKeyNum(), issue.getIssueCustomer(), issue.getIssueTitle(), issue.getIssueTarget(), issue.getIssueSubTarget(), issue.getIssueFirstWriter(), issueTester.toString(), issue.getIssueFirstDate(), issue.getIssueDate(), issue.getIssueTosms(), issue.getIssueTosrf(), issue.getIssuePortal(), issue.getIssueJava(), issue.getIssueWas(), issue.getTotal(), issue.getSolution(), issue.getUnresolved(), issue.getHold(), issue.getIssueDivisionList().get(i), issue.getIssueOsList().get(i), issue.getIssueWriterList().get(i), issue.getIssueAwardList().get(i), issue.getIssueMiddleList().get(i), issue.getIssueUnder1List().get(i), issue.getIssueUnder2List().get(i), issue.getIssueUnder3List().get(i), issue.getIssueUnder4List().get(i), issue.getIssueFlawNumList().get(i), issue.getIssueEffectList().get(i), issue.getIssueTextResultList().get(i), issue.getIssueApplyYnList().get(i), issue.getIssueConfirmList().get(i), issue.getIssueObstacleList().get(i), issue.getIssueNoteList().get(i), issue.getIssueRegistrant(), issue.getIssueRegistrationDate(), issue.getIssueModifier(), issue.getIssueModifiedDate());
		}
		if (sucess <= 0) {
			return "FALSE";
		} 
		List<Issue> issueApplyList = issueDao.getIssueApplyYn(issue.getIssueKeyNum());
		if(issueApplyList.size() == 0) {
			issueDao.proceStatusChange(issue.getIssueKeyNum(), "complete");
			return "Complete";
		}
		return "OK";
	}

	public Map copyIssue(Issue issue, Principal principal) {
		issue.setIssueKeyNum(0);
		return insertIssue(issue, principal);
	}

	public String mergeIssue(int[] chkList) {
		int total = 0;
		int solution = 0;
		int unresolved = 0;
		int hold = 0;
		boolean check = false;
		int resault = 1;
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
			resault *= issueDao.setIssueKeyNum(issueKeyNum, newKeyNum, total, solution, unresolved, hold);
			issueHistoryService.setIssueKeyNumUpdate(issueKeyNum, newKeyNum);
		}
		
		if(resault >= 1) {
			return "OK";
		}
		return "FALSE";
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
		int resault = issueDao.issueMinus(issuePrimaryKeyNum);
		if(resault >= 1) {
			return "OK";
		}
		return "FALSE";
	}
	
	public String getIssueSortNumUp(int issueKeyNum, int issueSortNum, int issuePrimaryKeyNum) {
		int fineIssueSortNum = issueDao.getIssueSortNumUp(issueKeyNum, issueSortNum);
		int resault = issueDao.upIssueSortNum(fineIssueSortNum);
		resault *=  issueDao.changIssueSortNum(issuePrimaryKeyNum, fineIssueSortNum);
		if(resault >= 1) {
			return "OK";
		}
		return "FALSE";
	}

	
	public Issue getIssueSortNumDown(int issueKeyNum, int issueSortNum) {
		return issueDao.getIssueSortNumDown(issueKeyNum, issueSortNum);
	}

	public String changIssueSortNum(Issue issue, Issue findIssue) {
		int resault = issueDao.changIssueSortNum(findIssue.getIssuePrimaryKeyNum(), issue.getIssueSortNum());
		resault *= issueDao.changIssueSortNum(issue.getIssuePrimaryKeyNum(), findIssue.getIssueSortNum());
		if(resault >= 1) {
			return "OK";
		}
		return "FALSE";
	}

	public List<Issue> getIssueOneIssueApplyYn(int issueKeyNum) {
		return issueDao.getIssueOneIssueApplyYn(issueKeyNum);
	}

	public String  updateUserAlarm(String employeeId, int userAlarmParameter) {
		UserAlarm userAlarm = new UserAlarm();
		userAlarm.setUserAlarmEmployeeId(employeeId);
		userAlarm.setUserAlarmModifier(employeeId);
		userAlarm.setUserAlarmModifiedDate(nowDate());
		userAlarm.setUserAlarmParameter(userAlarmParameter);
		int resault = employeeDao.updateUserAlarm(userAlarm);
		if(resault >= 1) {
			return "OK";
		}
		return "FALSE";
	}

	public void issueSortNumPlus(int issueSortNum) {
		issueDao.issueSortNumPlus(issueSortNum);
		
	}

	public void updateIssueAnswerStatus(Issue issue) {
		issueDao.updateIssueAnswerStatus(issue);
	}

	public String proceStatusChange(int[] chkList, String issueProceStatus) {
		for (int issueKeyNum : chkList) {
			int sucess = issueDao.proceStatusChange(issueKeyNum, issueProceStatus);
			if (sucess <= 0)
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
		} else {
			map.put("issueTarget", "TOSMS");
			map.put("issueSubTarget", "");
		}
		return map;
	}
	

}
