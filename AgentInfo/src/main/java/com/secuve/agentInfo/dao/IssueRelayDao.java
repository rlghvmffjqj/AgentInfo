package com.secuve.agentInfo.dao;

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
	
}
