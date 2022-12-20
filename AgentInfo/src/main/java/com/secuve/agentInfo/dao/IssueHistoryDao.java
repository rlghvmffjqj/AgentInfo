package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.IssueHistory;

@Repository
public class IssueHistoryDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<IssueHistory> getIssueHistoryList(int issueKeyNum) {
		return sqlSession.selectList("issueHistory.getIssueHistory", issueKeyNum);
	}

	public int getIssueHistoryListCount(int issueKeyNum) {
		return sqlSession.selectOne("issueHistory.getIssueHistoryCount", issueKeyNum);
	}

	public int insertIssueHistory(IssueHistory issueHistory) {
		return sqlSession.insert("issueHistory.insertIssueHistory", issueHistory);
	}

	public int deleteIssueHistory(String issueHistoryPdf) {
		return sqlSession.delete("issueHistory.deleteIssueHistory", issueHistoryPdf);
	}

	public void issueDeleteHistory(int issueKeyNum) {
		sqlSession.delete("issueHistory.issueDeleteHistory", issueKeyNum);
	}

	public List<String> getIssueHistoryPdfFileName(int issueKeyNum) {
		return sqlSession.selectList("issueHistory.getIssueHistoryPdfFileName", issueKeyNum);
	}

	public void setIssueKeyNumUpdate(int issueKeyNum, int newKeyNum) {
		Map<String, Integer> parameters = new HashMap<>();
		parameters.put("issueKeyNum", issueKeyNum);
		parameters.put("newKeyNum", newKeyNum);
		sqlSession.update("issueHistory.setIssueKeyNumUpdate", parameters);
		
	}

}
