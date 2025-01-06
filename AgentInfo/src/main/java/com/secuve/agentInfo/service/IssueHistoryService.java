package com.secuve.agentInfo.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.IssueHistoryDao;
import com.secuve.agentInfo.vo.Issue;
import com.secuve.agentInfo.vo.IssueHistory;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
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
		issueHistory.setIssueHistoryRegistrant(issue.getIssueRegistrant());
		issueHistory.setIssueHistoryRegistrationDate(issue.getIssueRegistrationDate());
		
		int success = issueHistoryDao.insertIssueHistory(issueHistory);
		if (success <= 0) {
			map.put("result", "FALSE");
		} else {
			map.put("result", "OK");
		}
		return map;
	}

	public Map<String, String> deleteIssueHistory(String issueHistoryPdf) {
		Map<String, String> map = new HashMap<>();
		int success = issueHistoryDao.deleteIssueHistory(issueHistoryPdf);
		if (success <= 0) {
			map.put("result", "FALSE");
		} else {
			map.put("result", "OK");
		}
		return map;
	}

	public void issueDeleteHistory(int issueKeyNum) {
		List<String> fileNameList = issueHistoryDao.getIssueHistoryPdfFileName(issueKeyNum);
		for (String fileName : fileNameList) {
			ileDelete(fileName);
		}
		issueHistoryDao.issueDeleteHistory(issueKeyNum);
	}
	
	public void ileDelete(String fileName) {
		//파일 경로 지정
		String path = "C:\\AgentInfo\\IssueHistoryDownload";
				
		//현재 게시판에 존재하는 파일객체를 만듬
		File file = new File(path + "\\" + fileName);
			
		if(file.exists()) { // 파일이 존재하면
			file.delete(); // 파일 삭제
		}
	}

	public void setIssueKeyNumUpdate(int issueKeyNum, int newKeyNum) {
		issueHistoryDao.setIssueKeyNumUpdate(issueKeyNum, newKeyNum);
	}
}
