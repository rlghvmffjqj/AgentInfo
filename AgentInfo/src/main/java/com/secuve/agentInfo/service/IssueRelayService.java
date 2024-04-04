package com.secuve.agentInfo.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.EmployeeDao;
import com.secuve.agentInfo.dao.IssueRelayDao;
import com.secuve.agentInfo.vo.Issue;
import com.secuve.agentInfo.vo.IssueRelay;
import com.secuve.agentInfo.vo.UserAlarm;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class IssueRelayService {
	@Autowired IssueRelayDao issueRelayDao;
	@Autowired EmployeeDao employeeDao;
	@Autowired IssueService issueService;
	
	public String createKey() {
	    StringBuffer key = new StringBuffer();
	    Random rnd = new Random();
	
	    for (int i = 0; i < 8; i++) { // 인증코드 8자리
	        int index = rnd.nextInt(3); // 0~2 까지 랜덤
	
	        switch (index) {
	            case 0:
	                key.append((char) ((int) (rnd.nextInt(26)) + 97));
	                //  a~z  (ex. 1+97=98 => (char)98 = 'b')
	                break;
	            case 1:
	                key.append((char) ((int) (rnd.nextInt(26)) + 65));
	                //  A~Z
	                break;
	            case 2:
	                key.append((rnd.nextInt(10)));
	                // 0~9
	                break;
	        }
	    }
	    return key.toString();
	}

	public String insertIssueRelay(IssueRelay issueRelay) {
		int sucess = issueRelayDao.insertIssueRelay(issueRelay);
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public IssueRelay getIssueRelayUrlOne(String issueRelayRandomUrl) {
		return issueRelayDao.getIssueRelayUrlOne(issueRelayRandomUrl);
	}

	public IssueRelay getIssueRelayIssueOne(int issueKeyNum) {
		return issueRelayDao.getIssueRelayIssueOne(issueKeyNum);
	}
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public List<IssueRelay> getIssueRelayList(int issueKeyNum) {
		return issueRelayDao.getIssueRelayList(issueKeyNum);
	}

	public IssueRelay getIssueRelayOne(int issueRelayKeyNum) {
		return issueRelayDao.getIssueRelayOne(issueRelayKeyNum);
	}

	public String updateIssueRelay(IssueRelay issueRelay) {
		int sucess = issueRelayDao.updateIssueRelay(issueRelay);
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public String delIssueRelay(int issueRelayKeyNum, int issuePrimaryKeyNum) {
		int sucess = issueRelayDao.delIssueRelay(issueRelayKeyNum);
		if (sucess <= 0)
			return "FALSE";
		List<IssueRelay> issueRelayList = issueRelayDao.getIssueRelayIssuePrimaryKeyNumList(issuePrimaryKeyNum);
		Issue issue = new Issue();
		if(issueRelayList.size() == 0) {
			issue.setIssueAnswerStatus("atmosphere");
			issue.setIssuePrimaryKeyNum(issuePrimaryKeyNum);
			issueService.updateIssueAnswerStatus(issue);
		} else if(issueRelayList.get(issueRelayList.size()-1).getIssueRelayType().equals("QA")) {
			issue.setIssueAnswerStatus("reRequest");
			issue.setIssuePrimaryKeyNum(issuePrimaryKeyNum);
			issueService.updateIssueAnswerStatus(issue);
		}
		return "OK";
	}

	public void insertUseralarm(Issue issue) {
		UserAlarm userAlarm = new UserAlarm();
		userAlarm.setUserAlarmTitle(issue.getIssueCustomer()+"_"+issue.getIssueTitle()+"_"+issue.getIssueDate());
		userAlarm.setUserAlarmDate(nowDate());
		userAlarm.setUserAlarmState("N");
		userAlarm.setUserAlarmRegistrationDate(nowDate());
		userAlarm.setUserAlarmURL("/AgentInfo/issue/updateView");
		userAlarm.setUserAlarmParameter(issue.getIssueKeyNum());
		
		List<String> qaList = employeeDao.getQaEmployeeId();
		for(String qa : qaList) {
			userAlarm.setUserAlarmEmployeeId(qa);
			employeeDao.setUserAlarm(userAlarm);
		}
		
	}
	
}
