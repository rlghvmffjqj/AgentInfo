package com.secuve.agentInfo.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.IssueHistoryDao;
import com.secuve.agentInfo.vo.Issue;
import com.secuve.agentInfo.vo.IssueHistory;

@Service
public class IssueHistoryService {
	@Autowired IssueHistoryDao issueHistoryDao;

	public List<IssueHistory> getIssueHistoryList(int issueKeyNum) {
		return issueHistoryDao.getIssueHistoryList(issueKeyNum);
	}

	public int getIssueHistoryListCount(int issueKeyNum) {
		return issueHistoryDao.getIssueHistoryListCount(issueKeyNum);
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public Map<String, String> insertIssueHistory(Issue issue, String issueHistoryDate) {
		Map<String, String> map = new HashMap<>();
		IssueHistory issueHistory = new IssueHistory();
		issueHistory.setIssueHistoryKeyNum(IssueHistoryKeyNum());
		issueHistory.setIssueKeyNum(issue.getIssueKeyNum());
		issueHistory.setIssueHistoryCustomer(issue.getIssueCustomer());
		issueHistory.setIssueHistoryTitle(issue.getIssueTitle());
		issueHistory.setIssueHistoryDate(issue.getIssueDate());
		issueHistory.setIssueHistoryTosms(issue.getIssueTosms());
		issueHistory.setIssueHistoryTosrf(issue.getIssueTosrf());
		issueHistory.setIssueHistoryPortal(issue.getIssuePortal());
		issueHistory.setIssueHistoryJava(issue.getIssueJava());
		issueHistory.setIssueHistoryWas(issue.getIssueWas());
		issueHistory.setIssueHistoryTotal("전체:"+issue.getTotal()+"(해결:"+issue.getSolution()+",미해결:"+issue.getUnresolved()+",보류:"+issue.getHold()+")");
		issueHistory.setIssueHistoryPdf(issue.getIssueCustomer()+"_"+issue.getIssueTitle()+"_"+issueHistoryDate+".pdf");
		
		int sucess = issueHistoryDao.insertIssueHistory(issueHistory);
		if (sucess <= 0) {
			map.put("result", "FALSE");
		} else {
			map.put("result", "OK");
		}
		return map;
	}
	
	public int IssueHistoryKeyNum() {
		int issueHistoryKeyNum = 1;
		try {
			issueHistoryKeyNum = issueHistoryDao.getIssueHistoryKeyNum();
		} catch (Exception e) {
			return issueHistoryKeyNum;
		}
		return ++issueHistoryKeyNum;
	}

	public Map<String, String> deleteIssueHistory(String issueHistoryPdf) {
		Map<String, String> map = new HashMap<>();
		int sucess = issueHistoryDao.deleteIssueHistory(issueHistoryPdf);
		if (sucess <= 0) {
			map.put("result", "FALSE");
		} else {
			map.put("result", "OK");
		}
		return map;
	}

}
