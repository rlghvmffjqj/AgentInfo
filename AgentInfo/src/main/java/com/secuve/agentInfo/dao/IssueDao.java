package com.secuve.agentInfo.dao;

import java.util.ArrayList;
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

	public int insertIssue(int issueKeyNum, String issueCustomer, String issueTitle, String issueTarget, String issueSubTarget, String issueFirstWriter, String issueFirstDate, String issueDate,
			String issueTosms, String issueTosrf, String issuePortal, String issueJava,
			String issueWas, String total, String solution, String unresolved, String hold, String issueDivision, String issueOs, String issueWriter,
			String issueAward, String issueMiddle, String issueUnder1, String issueUnder2, String issueUnder3, String issueUnder4,
			String issueFlawNum, String issueEffect, String issueTextResult, String issueApplyYn, String issueConfirm, String issueObstacle,
			String issueNote, String issueRegistrant, String issueRegistrationDate, String issueModifier, String issueModifiedDate) {
		
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("issueKeyNum", issueKeyNum);
		parameters.put("issueCustomer", issueCustomer);
		parameters.put("issueTitle", issueTitle);
		parameters.put("issueTarget", issueTarget);
		parameters.put("issueSubTarget", issueSubTarget);
		parameters.put("issueFirstWriter", issueFirstWriter);
		parameters.put("issueFirstDate", issueFirstDate);
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
		parameters.put("issueWriter", issueWriter);
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

	public Issue getIssueOneMerge(int issueKeyNum) {
		return sqlSession.selectOne("issue.getIssueOneMerge", issueKeyNum);
	}

	public int setIssueKeyNum(int issueKeyNum, int issueMergeKeyNum, int total, int solution, int unresolved, int hold) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("issueKeyNum", issueKeyNum);
		parameters.put("issueMergeKeyNum", issueMergeKeyNum);
		parameters.put("total", String.valueOf(total));
		parameters.put("solution", String.valueOf(solution));
		parameters.put("unresolved", String.valueOf(unresolved));
		parameters.put("hold", String.valueOf(hold));
		return sqlSession.update("issue.setIssueKeyNum", parameters);
	}

	public List<Issue> getIssuePDFOne(int issueKeyNum, String[] chkSelectBox) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("issueKeyNum", issueKeyNum);
		parameters.put("chkSelectBox", chkSelectBox);
		return sqlSession.selectList("issue.getIssuePDFOne", parameters);
	}

	public Issue getIssuePrimaryOne(int issuePrimaryKeyNum) {
		return sqlSession.selectOne("issue.getIssuePrimaryOne", issuePrimaryKeyNum);
	}

	public List<Integer> getIssuePrimaryKeyNumList(int issueKeyNum) {
		return sqlSession.selectList("issue.getIssuePrimaryKeyNumList", issueKeyNum);
	}

	public void insertIssuePlus(Issue issue) {
		sqlSession.insert("issue.insertIssuePlus", issue);
	}

	public void totalPlus(int issueKeyNum) {
		sqlSession.update("issue.totalPlus", issueKeyNum);
		
	}

	public void unresolvedPlus(int issueKeyNum) {
		sqlSession.update("issue.unresolvedPlus", issueKeyNum);
		
	}

	public Issue getIssueKeyNumOne(int issueKeyNum) {
		return sqlSession.selectOne("issue.getIssueKeyNumOne", issueKeyNum);
	}

	public int issueMinus(int issuePrimaryKeyNum) {
		return sqlSession.delete("issue.issueMinus", issuePrimaryKeyNum);
	}

	public int updateIssue(int issuePrimaryKeyNum, int issueKeyNum, String issueCustomer, String issueTitle, String issueTarget, String issueSubTarget, String issueFirstWriter, String issueTester, String issueFirstDate, String issueDate,
			String issueTosms, String issueTosrf, String issuePortal, String issueJava,
			String issueWas, String total, String solution, String unresolved, String hold, String issueDivision, String issueOs, String issueWriter,
			String issueAward, String issueMiddle, String issueUnder1, String issueUnder2, String issueUnder3, String issueUnder4,
			String issueFlawNum, String issueEffect, String issueTextResult, String issueApplyYn, String issueConfirm, String issueObstacle,
			String issueNote, String issueRegistrant, String issueRegistrationDate, String issueModifier, String issueModifiedDate) {
		
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("issuePrimaryKeyNum", issuePrimaryKeyNum);
		parameters.put("issueKeyNum", issueKeyNum);
		parameters.put("issueCustomer", issueCustomer);
		parameters.put("issueTitle", issueTitle);
		parameters.put("issueTarget", issueTarget);
		parameters.put("issueSubTarget", issueSubTarget);
		parameters.put("issueFirstWriter", issueFirstWriter);
		parameters.put("issueTester", issueTester);
		parameters.put("issueFirstDate", issueFirstDate);
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
		parameters.put("issueWriter", issueWriter);
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
		
		return sqlSession.update("issue.updateIssue", parameters);
	}

	public int getIssueSortNumUp(int issueKeyNum, int issueSortNum) {
		Map<String, Integer> parameters = new HashMap<String, Integer>();
		parameters.put("issueKeyNum", issueKeyNum);
		parameters.put("issueSortNum", issueSortNum);
		return sqlSession.selectOne("issue.getIssueSortNumUp", parameters);
	}

	public int upIssueSortNum(int fineIssueSortNum) {
		return sqlSession.update("issue.upIssueSortNum", fineIssueSortNum);
	}

	public int changIssueSortNum(int issuePrimaryKeyNum, int fineIssueSortNum) {
		Map<String, Integer> parameters = new HashMap<String, Integer>();
		parameters.put("issuePrimaryKeyNum", issuePrimaryKeyNum);
		parameters.put("fineIssueSortNum", fineIssueSortNum);
		return sqlSession.update("issue.changIssueSortNum", parameters);
	}

	public Issue getIssueSortNumDown(int issueKeyNum, int issueSortNum) {
		Map<String, Integer> parameters = new HashMap<String, Integer>();
		parameters.put("issueKeyNum", issueKeyNum);
		parameters.put("issueSortNum", issueSortNum);
		return sqlSession.selectOne("issue.getIssueSortNumDown", parameters);
	}

	public List<Issue> getIssueOneIssueApplyYn(int issueKeyNum) {
		return sqlSession.selectList("issue.getIssueOneIssueApplyYn", issueKeyNum);
	}
	
	public List<Issue> getIssueOneIssueApplyYnItem(int issueKeyNum) {
		return sqlSession.selectList("issue.getIssueOneIssueApplyYnItem", issueKeyNum);
	}

	public void issueSortNumPlus(int issueSortNum) {
		sqlSession.update("issue.issueSortNumPlus", issueSortNum);
	}

	public void updateIssueAnswerStatus(Issue issue) {
		sqlSession.update("issue.updateIssueAnswerStatus", issue);
	}

	public int proceStatusChange(int issueKeyNum, String issueProceStatus) {
		Map parameters = new HashMap();
		parameters.put("issueKeyNum", issueKeyNum);
		parameters.put("issueProceStatus", issueProceStatus);
		return sqlSession.update("issue.proceStatusChange", parameters);
	}

	public List<Issue> getIssueApplyYn(int issueKeyNum) {
		return sqlSession.selectList("issue.getIssueApplyYn", issueKeyNum);
	}

	public List<String> getSelectInputTarget(String selectInput, String issueTarget, String issueSubTarget) {
		Map<String, String> parameters = new HashMap<String, String>();
		parameters.put("selectInput", selectInput);
		parameters.put("issueTarget", issueTarget);
		parameters.put("issueSubTarget", issueSubTarget);
		return sqlSession.selectList("issue.getSelectInputTarget", parameters);
	}

	public List<Issue> getIssueOneImprovements(ArrayList<String> issuePrimaryKeyNumList, String issueTarget, String issueSubTarget) {
		Map parameters = new HashMap();
		parameters.put("issuePrimaryKeyNumList", issuePrimaryKeyNumList);
		parameters.put("issueTarget", issueTarget);
		parameters.put("issueSubTarget", issueSubTarget);
		return sqlSession.selectList("issue.getIssueOneImprovements", parameters);
	}

}


