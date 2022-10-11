package com.secuve.agentInfo.dao;

import java.util.List;

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

	public int getIssueHistoryKeyNum() {
		return sqlSession.selectOne("issueHistory.getIssueHistoryKeyNum");
	}

	public int deleteIssueHistory(String issueHistoryPdf) {
		return sqlSession.delete("issueHistory.deleteIssueHistory", issueHistoryPdf);
	}

}
