package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.Issue;
import com.secuve.agentInfo.vo.IssueRelay;

@Repository
public class IssueRelayDao {
	@Autowired SqlSessionTemplate sqlSession;

	public int insertIssueRelay(IssueRelay issueRelay) {
		return sqlSession.insert("issueRelay.insertIssueRelay", issueRelay);
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

	public IssueRelay getIssueRelayOne(int issueRelayKeyNum) {
		return sqlSession.selectOne("issueRelay.getIssueRelayOne", issueRelayKeyNum);
	}

	public int updateIssueRelay(IssueRelay issueRelay) {
		return sqlSession.update("issueRelay.updateIssueRelay", issueRelay);
	}

	public int delIssueRelay(int issueRelayKeyNum) {
		return sqlSession.delete("issueRelay.delIssueRelay", issueRelayKeyNum);
	}

	public int getFinedNumUp(int issuePrimaryKeyNum) {
		return sqlSession.selectOne("issueRelay.getFinedNumUp", issuePrimaryKeyNum);
	}

	public List<IssueRelay> getIssueRelayIssuePrimaryKeyNumList(int issuePrimaryKeyNum) {
		return sqlSession.selectList("issueRelay.getIssueRelayIssuePrimaryKeyNumList", issuePrimaryKeyNum);
	}

	public List<IssueRelay> getUrlDuplication(String issueRelayUrl) {
		return sqlSession.selectList("issueRelay.getUrlDuplication", issueRelayUrl);
	}

	public List<Integer> getIssuePrimaryKeyNumList(int issueKeyNum) {
		return sqlSession.selectList("issueRelay.getIssuePrimaryKeyNumList", issueKeyNum);
	}

	public List<String> getIssueRelayImprovements() {
		return sqlSession.selectList("issueRelay.getIssueRelayImprovements");
	}

	public List<IssueRelay> getIssueRelayImprovementsItem(int issueKeyNum) {
		return sqlSession.selectList("issueRelay.getIssueRelayImprovementsItem", issueKeyNum);
	}

	public void updateImprovementsRelay(IssueRelay issueRelay) {
		sqlSession.update("issueRelay.updateImprovementsRelay", issueRelay);
	}

	public IssueRelay getIssuePrimaryKeyNumOne(int issuePrimaryKeyNum) {
		return sqlSession.selectOne("issueRelay.getIssuePrimaryKeyNumOne", issuePrimaryKeyNum);
	}

}
