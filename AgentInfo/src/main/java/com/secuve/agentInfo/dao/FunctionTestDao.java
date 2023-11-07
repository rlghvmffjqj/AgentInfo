package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.FunctionTest;

@Repository
public class FunctionTestDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<FunctionTest> getFunctionTest(FunctionTest search) {
		return sqlSession.selectList("functionTest.getFunctionTest", search);
	}

	public int getFunctionTestCount(FunctionTest search) {
		return sqlSession.selectOne("functionTest.getFunctionTestCount", search);
	}

	public int getFunctionTestKeyNum() {
		return sqlSession.selectOne("functionTest.getFunctionTestKeyNum");
	}

	public int insertFunctionTest(Integer functionTestKeyNum, String functionTestCustomer, String functionTestTitle,
			String functionTestDate, Integer functionTestSettingSubCategoryKeyNum, String functionTestSubCategoryState, String functionTestSubCategoryFailReason, String functionTestResult, String functionTestType, String functionTestRegistrant,
			String functionTestRegistrationDate, String functionTestModifier, String functionTestModifiedDate) {

		FunctionTest functionTest = new FunctionTest();
		functionTest.setFunctionTestKeyNum(functionTestKeyNum);
		functionTest.setFunctionTestCustomer(functionTestCustomer);
		functionTest.setFunctionTestTitle(functionTestTitle);
		functionTest.setFunctionTestDate(functionTestDate);
		functionTest.setFunctionTestSettingSubCategoryKeyNum(functionTestSettingSubCategoryKeyNum);
		functionTest.setFunctionTestSubCategoryState(functionTestSubCategoryState);
		functionTest.setFunctionTestSubCategoryFailReason(functionTestSubCategoryFailReason);
		functionTest.setFunctionTestType(functionTestType);
		functionTest.setFunctionTestRegistrant(functionTestRegistrant);
		functionTest.setFunctionTestRegistrationDate(functionTestRegistrationDate);
		functionTest.setFunctionTestModifier(functionTestModifier);
		functionTest.setFunctionTestModifiedDate(functionTestModifiedDate);
		functionTest.setFunctionTestResult(functionTestResult);
		
		return sqlSession.insert("functionTest.insertFunctionTest", functionTest);
	}

	public FunctionTest getFunctionTestOneTitle(int functionTestKeyNum) {
		return sqlSession.selectOne("functionTest.getFunctionTestOneTitle", functionTestKeyNum);
	}

	public List<FunctionTest> getFunctionTestOne(int functionTestKeyNum) {
		return sqlSession.selectList("functionTest.getFunctionTestOne", functionTestKeyNum);
	}

	public int delFunctionTest(int functionTestKeyNum) {
		return sqlSession.delete("functionTest.delFunctionTest", functionTestKeyNum);
	}
	
	public List<Integer> functionTestFunctionTestSettingSubCategoryKeyNum(int functionTestKeyNum) {
		return sqlSession.selectList("functionTest.functionTestFunctionTestSettingSubCategoryKeyNum",functionTestKeyNum);
	}

	public FunctionTest getFunctionTestPDFTitle(FunctionTest functionTest) {
		return sqlSession.selectOne("functionTest.getFunctionTestPDFTitle",functionTest);
	}

	public int resultSave(FunctionTest functionTest) {
		return sqlSession.update("functionTest.resultSave",functionTest);
	}

	public FunctionTest getFunctionTestDelicacy(FunctionTest functionTest) {
		return sqlSession.selectOne("functionTest.getFunctionTestDelicacy",functionTest);
	}

	public List<String> getFunctionTestResult(Integer functionTestKeyNum) {
		return sqlSession.selectList("functionTest.getFunctionTestResult",functionTestKeyNum);
	}
}
