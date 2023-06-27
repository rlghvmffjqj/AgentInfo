package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.TestCase;

@Repository
public class TestCaseDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<String> getTestCaseForm() {
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
	
}
