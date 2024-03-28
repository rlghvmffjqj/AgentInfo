package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.IssueRelay;

@Repository
public class IssueRelayDao {
	@Autowired SqlSessionTemplate sqlSession;

	public void insertIssueRelay(IssueRelay issueRelay) {
		sqlSession.insert("issueRelay.insertIssueRelay", issueRelay);
	}

	public IssueRelay getIssueRelayUrlOne(String issueRelayRandomUrl) {
		return sqlSession.selectOne("issueRelay.getIssueRelayUrlOne", issueRelayRandomUrl);
	}

	public IssueRelay getIssueRelayIssueOne(int issueKeyNum) {
		return sqlSession.selectOne("issueRelay.getIssueRelayIssueOne", issueKeyNum);
	}

	public List<IssueRelay> getIssueRelayList(int issueKeyNum) {
		return sqlSession.selectList("issueRelay.getIssueRelayList", issueKeyNum);
	}
	
}
