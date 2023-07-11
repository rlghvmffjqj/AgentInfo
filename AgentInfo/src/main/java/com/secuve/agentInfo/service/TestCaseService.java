package com.secuve.agentInfo.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.TestCaseDao;
import com.secuve.agentInfo.vo.TestCase;

@Service
public class TestCaseService {
	@Autowired TestCaseDao testCaseDao;

	public List<String> getTestCaseForm() {
		return testCaseDao.getTestCaseForm();
	}
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String insertTestCaseForm(TestCase testCase) {
		if(testCaseDao.testCaseFormNameDuplication(testCase.getTestCaseFormName()) > 0) 
			return "Duplication";
		int sucess = testCaseDao.insertTestCaseForm(testCase);
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public String delTestCaseForm(TestCase testCase) {
		int sucess = testCaseDao.delTestCaseForm(testCase);
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public String updateTestCaseForm(TestCase testCase) {
		if(testCaseDao.testCaseFormNameDuplication(testCase.getTestCaseFormName()) > 0) 
			return "Duplication";
		int sucess = testCaseDao.updateTestCaseForm(testCase);
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}
	
	

	public List<TestCase> getRouteList(TestCase testCase) {
		List<TestCase> testCaseRoute = testCaseDao.getRouteList(testCase);
		return testCaseRoute;
	}
	
	public String insertRoute(TestCase testCase) {
		int sucess = 0;
		if(testCase.getTestCaseRouteParentPath().equals("/")) {
			testCase.setTestCaseRouteFullPath("/"+testCase.getTestCaseRouteName());
		} else {
			testCase.setTestCaseRouteFullPath(testCase.getTestCaseRouteParentPath() + "/"+testCase.getTestCaseRouteName());
		}
		TestCase overlap = testCaseDao.getTestCaseRouteFullPath(testCase);
		if(testCase.getTestCaseRouteName() == "" || testCase.getTestCaseRouteName() == null) {
			return "Empty";
		}
		if(overlap == null) {
			sucess = testCaseDao.insertRoute(testCase);
			testCaseDao.updateRouteDate(testCase);
		} else {
			return "Overlap";
		}
		return resultReturn(sucess);
	}

	public String deleteRoute(TestCase testCase) {
		int sucess = 0;
		List<TestCase> subTestCase = testCaseDao.getTestCaseRouteParentPath(testCase.getTestCaseRouteFullPath());
		if(subTestCase.size() == 0) {
			sucess = testCaseDao.deleteRoute(testCase);
		} else {
			return "SubTestCase";
		}
		return resultReturn(sucess);
	}
	
	public String updateRoute(TestCase testCase) {
		if(testCase.getNewTestCaseRouteName() == "" || testCase.getNewTestCaseRouteName() == null) {
			return "Empty";
		}
		TestCase ordTestCase = (TestCase) testCaseDao.getTestCaseRouteFullPath(testCase);
		if(ordTestCase.getTestCaseRouteParentPath().equals("/")) {
			testCase.setNewTestCaseRouteFullPath("/"+testCase.getNewTestCaseRouteName());
		} else {
			testCase.setNewTestCaseRouteFullPath(ordTestCase.getTestCaseRouteParentPath()+"/"+testCase.getNewTestCaseRouteName());
		}
		
		TestCase overlap = testCaseDao.getTestCaseRouteFullPath(testCase);
		if(overlap == null) {
			ArrayList<TestCase> testCaseFullPathList = new ArrayList<>(testCaseDao.getTestCaseRouteFullPathList(ordTestCase.getTestCaseRouteFullPath()));
			for (TestCase newTestCase : testCaseFullPathList) {
				String ordTestCaseFullPath = newTestCase.getTestCaseRouteFullPath();
				String newTestCaseFullPath = ordTestCaseFullPath.replaceFirst(testCase.getTestCaseRouteFullPath(), testCase.getNewTestCaseRouteFullPath());
				ordTestCase = parseFullPath(newTestCaseFullPath, ordTestCase);
				
				// 경로 테이블 변경
				testCaseDao.updateRoute(ordTestCaseFullPath, ordTestCase.getTestCaseRouteFullPath(), ordTestCase.getTestCaseRouteParentPath(), ordTestCase.getTestCaseRouteName());

				// 해당 부서의 사원정보 모두 변경
				//employeeDao.updateDept(ordTestCaseFullPath, ordTestCase.getTestCaseRouteFullPath(), ordTestCase.getTestCaseRouteParentPath(), ordTestCase.getTestCaseRouteName());
			}
			
		} else {
			return "Overlap";
		}
		testCaseDao.updateRouteDate(testCase);
		return "OK";
	}
	
	public TestCase parseFullPath(String newTestCaseFullPath, TestCase ordTestCase) {
		if (newTestCaseFullPath.startsWith("/")) {
			ordTestCase.setTestCaseRouteFullPath(newTestCaseFullPath);
			int pos = newTestCaseFullPath.lastIndexOf('/');
			if (pos > 0) {
				ordTestCase.setTestCaseRouteParentPath(newTestCaseFullPath.substring(0, pos));
				ordTestCase.setTestCaseRouteName(newTestCaseFullPath.substring(pos + 1));
			} else {
				ordTestCase.setTestCaseRouteParentPath("/");
				ordTestCase.setTestCaseRouteName(newTestCaseFullPath.substring(pos + 1));
			}
		} else {
		}
		return ordTestCase;
	}
	
	public String resultReturn(int sucess) {
		if(sucess > 0) {
			return "OK";
		}
		return "FAIL";
	}

	public List<TestCase> getTestCaseList(TestCase search) {
		return testCaseDao.getTestCaseList(testCaseSearch(search));
	}
	
	public int getTestCaseListCount(TestCase search) {
		return testCaseDao.getTestCaseListCount(testCaseSearch(search));
	}
	
	public TestCase testCaseSearch(TestCase search) {
		search.setTestCaseRouteCustomerArr(search.getTestCaseRouteCustomer().split(","));
		search.setTestCaseRouteNoteArr(search.getTestCaseRouteNote().split(","));
		
		return search;
	}

	public String testCaseConfirmed(TestCase testCase) {
		int count = testCaseDao.testCaseConfirmed(testCase);
		if(count > 0)
			return "FALSE";
		return "OK";
	}

	public List<String> getSearchValue(String searchValue) {
		return testCaseDao.getSearchValue(searchValue);
	}

	public TestCase getTestCaseContents(int testCaseRouteKeyNum) {
		return testCaseDao.getTestCaseContents(testCaseRouteKeyNum);
	}

	public Map testCaseContentsInsert(TestCase testCase) {
		Map map = new HashMap();
		int sucess = testCaseDao.testCaseDoubleCheck(testCase.getTestCaseRouteKeyNum());
		if(sucess > 0) {
			map.put("result", "FALSE");
			return map;
		}
		testCaseDao.testCaseContentsInsert(testCase);
		map.put("result", "OK");
		map.put("testCase", testCase);
		return map;
	}

	public String testCaseContentsUpdate(TestCase testCase) {
		int sucess = testCaseDao.testCaseContentsUpdate(testCase);
		if(sucess > 0) {
			return "OK";
		}
		return "FALSE";
	}

	public String testCaseContentsDelete(int testCaseRouteKeyNum) {
		int sucess = testCaseDao.testCaseContentsDelete(testCaseRouteKeyNum);
		if(sucess > 0) {
			return "OK";
		}
		return "FALSE";
	}

	
}
