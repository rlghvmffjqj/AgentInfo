package com.secuve.agentInfo.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.EmployeeDao;
import com.secuve.agentInfo.dao.IssueDao;
import com.secuve.agentInfo.dao.IssueRelayDao;
import com.secuve.agentInfo.vo.Issue;
import com.secuve.agentInfo.vo.IssueRelay;
import com.secuve.agentInfo.vo.UserAlarms;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class IssueRelayService {
	@Autowired IssueRelayDao issueRelayDao;
	@Autowired EmployeeDao employeeDao;
	@Autowired IssueDao issueDao;
	
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
	    if(issueRelayDao.getUrlDuplication(key.toString()).size() != 0) {
	    	createKey();
	    }
	    return key.toString();
	}

	public Map insertIssueRelay(IssueRelay issueRelay) {
		Map resultMap = new HashMap();
		int success = issueRelayDao.insertIssueRelay(issueRelay);
		if (success <= 0) {
			resultMap.put("result", "FALSE"); 
			return resultMap;
		}
		resultMap.put("result", "OK"); 
		resultMap.put("issueRelayKeyNum", issueRelay.getIssueRelayKeyNum());
		return resultMap;
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
		int success = issueRelayDao.updateIssueRelay(issueRelay);
		if (success <= 0)
			return "FALSE";
		return "OK";
	}

	public String delIssueRelay(int issueRelayKeyNum, int issuePrimaryKeyNum) {
		int success = issueRelayDao.delIssueRelay(issueRelayKeyNum);
		if (success <= 0)
			return "FALSE";
		List<IssueRelay> issueRelayList = issueRelayDao.getIssueRelayIssuePrimaryKeyNumList(issuePrimaryKeyNum);
		Issue issue = new Issue();
		if(issueRelayList.size() == 0) {
			issue.setIssueAnswerStatus("atmosphere");
			issue.setIssuePrimaryKeyNum(issuePrimaryKeyNum);
			issueDao.updateIssueAnswerStatus(issue);
		} else if(issueRelayList.get(issueRelayList.size()-1).getIssueRelayType().equals("QA")) {
			issue.setIssueAnswerStatus("reRequest");
			issue.setIssuePrimaryKeyNum(issuePrimaryKeyNum);
			issueDao.updateIssueAnswerStatus(issue);
		}
		return "OK";
	}

		UserAlarms userAlarms = new UserAlarms();
		public void insertUseralarm(Issue issue) {
		userAlarms.setUserAlarmsTitle(issue.getIssueCustomer()+"_"+issue.getIssueTitle()+"_"+issue.getIssueDate());
		userAlarms.setUserAlarmsDate(nowDate());
		userAlarms.setUserAlarmsState("N");
		userAlarms.setUserAlarmsRegistrationDate(nowDate());
		userAlarms.setUserAlarmsURL("/AgentInfo/issue/updateView");
		userAlarms.setUserAlarmsParameter(issue.getIssueKeyNum());
		userAlarms.setUserAlarmsParameterSub(issue.getIssuePrimaryKeyNum());
		
		List<String> qaList = employeeDao.getQaEmployeeId();
		for(String qa : qaList) {
			userAlarms.setUserAlarmsEmployeeId(qa);
			employeeDao.setUserAlarms(userAlarms);
		}
		
	}

	public List<Integer> getIssuePrimaryKeyNumList(int issueKeyNum) {
		return issueRelayDao.getIssuePrimaryKeyNumList(issueKeyNum);
	}

	public List<String> getIssueRelayImprovements() {
		return issueRelayDao.getIssueRelayImprovements();
	}

	public List<IssueRelay> getIssueRelayImprovementsItem(int issueKeyNum) {
		return issueRelayDao.getIssueRelayImprovementsItem(issueKeyNum);
	}

	public void updateImprovementsRelay(IssueRelay issueRelay) {
		if("해결".equals(issueRelay.getIssueRelayStatus())) {
			issueRelay.setIssueRelayStatus("개선 완료");
		} else if("향후 개선".equals(issueRelay.getIssueRelayStatus()) || "대기".equals(issueRelay.getIssueRelayStatus())) {
			return;
		}
		issueRelayDao.updateImprovementsRelay(issueRelay);
	}

	public IssueRelay getIssuePrimaryKeyNumOne(int issuePrimaryKeyNum) {
		return issueRelayDao.getIssuePrimaryKeyNumOne(issuePrimaryKeyNum);
	}

}
