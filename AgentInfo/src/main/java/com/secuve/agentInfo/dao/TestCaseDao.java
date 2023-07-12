package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.TestCase;

@Repository
public class TestCaseDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<TestCase> getTestCaseForm() {
		return sqlSession.selectList("testCase.getTestCaseForm");
	}

	public int insertTestCaseForm(TestCase testCase) {
		return sqlSession.insert("testCase.insertTestCaseForm",testCase);
	}

	public int testCaseFormNameDuplication(String testCaseFormName) {
		return sqlSession.selectOne("testCase.testCaseFormNameDuplication",testCaseFormName);
	}

	public int delTestCaseForm(TestCase testCase) {
		return sqlSession.delete("testCase.delTestCaseForm",testCase);
	}

	public int updateTestCaseForm(TestCase testCase) {
		return sqlSession.insert("testCase.updateTestCaseForm",testCase);
	}
	
	

	public List<TestCase> getRouteList(TestCase testCase) {
		return sqlSession.selectList("testCase.getRouteList", testCase);
	}
	
	public int insertRoute(TestCase testCase) {
		return sqlSession.insert("testCase.insertRoute", testCase);
	}

	public TestCase getTestCaseRouteFullPath(TestCase testCase) {
		return sqlSession.selectOne("testCase.getTestCaseRouteFullPath",testCase);
	}

	public List<TestCase> getTestCaseRouteParentPath(String testCaseRouteFullPath) {
		return sqlSession.selectList("testCase.getTestCaseRouteParentPath",testCaseRouteFullPath);
	}

	public int deleteRoute(TestCase testCase) {
		return sqlSession.delete("testCase.deleteRoute",testCase);
	}

	public List<TestCase> getTestCaseRouteFullPathList(String testCaseRouteFullPath) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("testCaseRouteFullPath", testCaseRouteFullPath);
		parameters.put("testCaseRouteParentPath", testCaseRouteFullPath + "/%");
		return sqlSession.selectList("testCase.getTestCaseRouteFullPathList", parameters);
	}

	public int updateRoute(String ordTestCaseFullPath, String testCaseRouteFullPath, String testCaseRouteParentPath, String testCaseRouteName) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("ordTestCaseFullPath", ordTestCaseFullPath);
		parameters.put("testCaseRouteFullPath", testCaseRouteFullPath);
		parameters.put("testCaseRouteParentPath", testCaseRouteParentPath);
		parameters.put("testCaseRouteName", testCaseRouteName);
		return sqlSession.insert("testCase.updateRoute", parameters);
	}

	public List<TestCase> getTestCaseList(TestCase search) {
		return sqlSession.selectList("testCase.getTestCaseList", search);
	}

	public int getTestCaseListCount(TestCase search) {
		return sqlSession.selectOne("testCase.getTestCaseListCount", search);
	}

	public void updateRouteDate(TestCase testCase) {
		sqlSession.update("testCase.updateRouteDate", testCase);
	}

	public int testCaseConfirmed(TestCase testCase) {
		return sqlSession.selectOne("testCase.testCaseConfirmed", testCase);
	}

	public List<String> getSearchValue(String searchValue) {
		return sqlSession.selectList("testCase.getSearchValue", searchValue);
	}

	public TestCase getTestCaseContents(int testCaseRouteKeyNum) {
		return sqlSession.selectOne("testCase.getTestCaseContents", testCaseRouteKeyNum);
	}

	public int testCaseDoubleCheck(int testCaseRouteKeyNum) {
		return sqlSession.selectOne("testCase.testCaseDoubleCheck", testCaseRouteKeyNum);
	}

	public void testCaseContentsInsert(TestCase testCase) {
		sqlSession.insert("testCase.testCaseContentsInsert", testCase);
	}

	public int testCaseContentsUpdate(TestCase testCase) {
		return sqlSession.update("testCase.testCaseContentsUpdate", testCase);
	}

	public int testCaseContentsDelete(int testCaseRouteKeyNum) {
		return sqlSession.delete("testCase.testCaseContentsDelete", testCaseRouteKeyNum);
	}

	public TestCase getTestCaseFormOne(TestCase testCase) {
		return sqlSession.selectOne("testCase.getTestCaseFormOne", testCase);
	}

	public TestCase getTestCaseRouteOne(TestCase testCase) {
		return sqlSession.selectOne("testCase.getTestCaseRouteOne", testCase);
	}

	public void delTestCaseFormRoute(TestCase testCase) {
		sqlSession.delete("testCase.delTestCaseFormRoute", testCase);
	}

	public void delTestCaseFormContents(TestCase testCase) {
		sqlSession.delete("testCase.delTestCaseFormContents", testCase);		
	}

	public void updateTestCaseFormRoute(TestCase testCase) {
		sqlSession.update("testCase.updateTestCaseFormRoute", testCase);
	}

	public int getMaxTestCaseRouteKeyNum() {
		return sqlSession.selectOne("testCase.getMaxTestCaseRouteKeyNum");
	}

}
