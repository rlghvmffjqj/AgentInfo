package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.FunctionTestDao;
import com.secuve.agentInfo.vo.FunctionTest;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class FunctionTestService {
	@Autowired FunctionTestDao functionTestDao;

	public List<FunctionTest> getFunctionTest(FunctionTest search) {
		return functionTestDao.getFunctionTest(functionTestSearch(search));
	}

	public int getFunctionTestCount(FunctionTest search) {
		return functionTestDao.getFunctionTestCount(functionTestSearch(search));
	}
	
	public FunctionTest functionTestSearch(FunctionTest search) {
		search.setFunctionTestCustomerArr(search.getFunctionTestCustomer().split(","));
		search.setFunctionTestTitleArr(search.getFunctionTestTitle().split(","));
		
		return search;
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public Map insertFunctionTest(FunctionTest functionTest, Principal principal) {
		Map map = new HashMap();
		functionTest.setFunctionTestKeyNum(FunctionTestKeyNum(functionTest.getFunctionTestKeyNum()));
		map.put("functionTestKeyNum", functionTest.getFunctionTestKeyNum());
		
		int sucess = 1;
		functionTest = oneDate(functionTest);
		for(int i=0; i < functionTest.getFunctionTestSubCategoryStateList().size(); i++) {
			sucess *= functionTestDao.insertFunctionTest(functionTest.getFunctionTestKeyNum(), functionTest.getFunctionTestCustomer(), functionTest.getFunctionTestTitle(), functionTest.getFunctionTestDate(), functionTest.getFunctionTestSettingSubCategoryKeyNumList().get(i), functionTest.getFunctionTestSubCategoryStateList().get(i), functionTest.getFunctionTestSubCategoryFailReasonList().get(i), functionTest.getFunctionTestType(), functionTest.getFunctionTestRegistrant(), functionTest.getFunctionTestRegistrationDate(), functionTest.getFunctionTestModifier(), functionTest.getFunctionTestModifiedDate());
		}
		if (sucess <= 0) {
			map.put("result", "FALSE");
		} else {
			map.put("result", "OK");
			map.put("functionTestKeyNum", functionTest.getFunctionTestKeyNum());
		}
		return map;
	}
	
	public FunctionTest oneDate(FunctionTest functionTest) {
		List<String> list = new ArrayList<String>();
		List<Integer> list2 = new ArrayList<Integer>();
		list.add("");
		list2.add(0);
		if(functionTest.getFunctionTestSettingSubCategoryKeyNumList().size() == 0) 
			functionTest.setFunctionTestSettingSubCategoryKeyNumList(list2);
		if(functionTest.getFunctionTestSubCategoryStateList().size() == 0) 
			functionTest.setFunctionTestSubCategoryStateList(list);
		if(functionTest.getFunctionTestSubCategoryFailReasonList().size() == 0) 
			functionTest.setFunctionTestSubCategoryFailReasonList(list);
		
		return functionTest;
	}
	
	public int FunctionTestKeyNum(int functionTestKeyNum) {
		if(functionTestKeyNum == 0) {
			functionTestKeyNum = 1;
		} else {
			return functionTestKeyNum;
		}
		try {
			functionTestKeyNum = functionTestDao.getFunctionTestKeyNum();
		} catch (Exception e) {
			return functionTestKeyNum;
		}
		return ++functionTestKeyNum;
	}

	public FunctionTest getFunctionTestOneTitle(int functionTestKeyNum) {
		return functionTestDao.getFunctionTestOneTitle(functionTestKeyNum);
	}

	public List<FunctionTest> getFunctionTestOne(int functionTestKeyNum) {
		return functionTestDao.getFunctionTestOne(functionTestKeyNum);
	}

	public String delFunctionTest(int[] chkList) {
		for (int functionTestKeyNum : chkList) {
			int sucess = functionTestDao.delFunctionTest(functionTestKeyNum);

			if (sucess <= 0)
				return "FALSE";
		}
		return "OK";
	}

	public Map updateFunctionTest(FunctionTest functionTest, Principal principal) {
		Map map = new HashMap();
		int count = functionTestDao.delFunctionTest(functionTest.getFunctionTestKeyNum());
		if(count == 0 && functionTest.getFunctionTestKeyNum() != 0) {
			map.put("result", "FALSE");
			return map;
		}
		return insertFunctionTest(functionTest, principal);
	}

	public List<Integer> functionTestFunctionTestSettingSubCategoryKeyNum(int functionTestKeyNum) {
		return functionTestDao.functionTestFunctionTestSettingSubCategoryKeyNum(functionTestKeyNum);
	}

}
