package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.Issue;

@Repository
public class IssueDao {
	@Autowired SqlSessionTemplate sqlSession;

	public int getIssueKeyNum() {
		return sqlSession.selectOne("issue.getIssueKeyNum");
	}

	public int insertIssue(int issueKeyNum, String issueCustomer, String issueTitle, String issueDate,
			String issueTosms, String issueTosrf, String issuePortal, String issueJava,
			String issueWas, String total, String solution, String unresolved, String hold, String issueDivision, String issueOs, 
			String issueAward, String issueMiddle, String issueUnder1, String issueUnder2, String issueUnder3, String issueUnder4,
			String issueFlawNum, String issueEffect, String issueTextResult, String issueApplyYn, String issueConfirm, String issueObstacle,
			String issueNote, String issueRegistrant, String issueRegistrationDate, String issueModifier, String issueModifiedDate) {
		
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("issueKeyNum", issueKeyNum);
		parameters.put("issueCustomer", issueCustomer);
		parameters.put("issueTitle", issueTitle);
		parameters.put("issueDate", issueDate);
		parameters.put("issueTosms", issueTosms);
		parameters.put("issueTosrf", issueTosrf);
		parameters.put("issuePortal", issuePortal);
		parameters.put("issueJava", issueJava);
		parameters.put("issueWas", issueWas);
		parameters.put("total", total);
		parameters.put("solution", solution);
		parameters.put("unresolved", unresolved);
		parameters.put("hold", hold);
		parameters.put("issueDivision", issueDivision);
		parameters.put("issueOs", issueOs);
		parameters.put("issueAward", issueAward);
		parameters.put("issueMiddle", issueMiddle);
		parameters.put("issueUnder1", issueUnder1);
		parameters.put("issueUnder2", issueUnder2);
		parameters.put("issueUnder3", issueUnder3);
		parameters.put("issueUnder4", issueUnder4);
		parameters.put("issueFlawNum", issueFlawNum);
		parameters.put("issueEffect", issueEffect);
		parameters.put("issueTextResult", issueTextResult);
		parameters.put("issueApplyYn", issueApplyYn);
		parameters.put("issueConfirm", issueConfirm);
		parameters.put("issueObstacle", issueObstacle);
		parameters.put("issueNote", issueNote);
		parameters.put("issueRegistrant", issueRegistrant);
		parameters.put("issueRegistrationDate", issueRegistrationDate);
		parameters.put("issueModifier", issueModifier);
		parameters.put("issueModifiedDate", issueModifiedDate);

		return sqlSession.insert("issue.insertIssue", parameters);
	}

	public List<Issue> getIssueList(Issue search) {
		return sqlSession.selectList("issue.getIssueList", search);
	}

	public int getIssueListCount(Issue search) {
		return sqlSession.selectOne("issue.getIssueListCount", search);
	}

	public List<String> getSelectInput(String selectInput) {
		return sqlSession.selectList("issue.getSelectInput", selectInput);
	}

	public List<Issue> getIssueOne(int issueKeyNum) {
		return sqlSession.selectList("issue.getIssueOne", issueKeyNum);
	}

	public Issue getIssueOneTitle(int issueKeyNum) {
		return sqlSession.selectOne("issue.getIssueOneTitle", issueKeyNum);
	}

	public int delIssue(int issueKeyNum) {
		return sqlSession.delete("issue.delIssue", issueKeyNum);
	}

}

