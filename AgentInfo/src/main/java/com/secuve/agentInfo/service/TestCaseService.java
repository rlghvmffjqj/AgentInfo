package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.TestCaseDao;
import com.secuve.agentInfo.vo.TestCase;

import jdk.internal.org.jline.terminal.TerminalBuilder.SystemOutput;

@Service
public class TestCaseService {
	@Autowired TestCaseDao testCaseDao;

	public List<TestCase> getTestCaseForm() {
		return testCaseDao.getTestCaseForm();
	}
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public Map insertTestCaseForm(TestCase testCase) {
		Map map = new HashMap();
		if(testCaseDao.testCaseFormNameDuplication(testCase.getTestCaseFormName()) > 0) {
			map.put("result", "Duplication");
			return map;
		}
		int sucess = testCaseDao.insertTestCaseForm(testCase);
		if (sucess <= 0) {
			map.put("result", "FALSE");
			return map;
		}
		map.put("result", "OK");
		map.put("testCaseFormKeyNum", testCase.getTestCaseFormKeyNum());
		return map;
	}

	public String delTestCaseForm(TestCase testCase) {
		int sucess = testCaseDao.delTestCaseForm(testCase);
		if (sucess <= 0)
			return "FALSE";
		testCaseDao.delTestCaseFormRoute(testCase);
		testCaseDao.delTestCaseFormContents(testCase);
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
		
		if(testCase.getTestCaseRouteGroupNum() == 0) {
			try { testCase.setTestCaseRouteGroupNum(testCaseDao.getMaxTestCaseRouteGroupNum()+1); } 
			catch (Exception e) { testCase.setTestCaseRouteGroupNum(1);	}
		}
		try { testCase.setTestCaseRouteSortNum(testCaseDao.getMaxTestCaseRouteSortNum()+1); } 
		catch (Exception e) { testCase.setTestCaseRouteSortNum(1);	}
		
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
		if(sucess > 0) {
			return "OK";
		}
		return "FAIL";
	}

	public String deleteRoute(TestCase testCase) {
		int sucess = 0;
		List<TestCase> subTestCase = testCaseDao.getTestCaseRouteParentPath(testCase.getTestCaseRouteFullPath());
		if(subTestCase.size() == 0) {
			sucess = testCaseDao.deleteRoute(testCase);
		} else {
			return "SubRoute";
		}
		if(sucess > 0) {
			testCaseDao.deleteTestCaseRouteContents(testCase.getTestCaseRouteKeyNum());
			return "OK";
		}
		return "FAIL";
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
		
		TestCase overlap = testCaseDao.getTestCaseRouteOverlap(testCase);
		if(overlap == null) {
			ArrayList<TestCase> testCaseFullPathList = new ArrayList<>(testCaseDao.getTestCaseRouteFullPathList(ordTestCase.getTestCaseRouteFullPath()));
			for (TestCase newTestCase : testCaseFullPathList) {
				String ordTestCaseFullPath = newTestCase.getTestCaseRouteFullPath();
				String newTestCaseFullPath = ordTestCaseFullPath.replaceFirst(testCase.getTestCaseRouteFullPath(), testCase.getNewTestCaseRouteFullPath());
				ordTestCase = parseFullPath(newTestCaseFullPath, ordTestCase);
				
				// 경로 테이블 변경
				testCaseDao.updateRoute(testCase.getTestCaseRouteKeyNum(), ordTestCaseFullPath, ordTestCase.getTestCaseRouteFullPath(), ordTestCase.getTestCaseRouteParentPath(), ordTestCase.getTestCaseRouteName());

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

	public String deleteTestCase(int[] chkList) {
		for (int testCaseRouteGroupNum : chkList) {
			List<TestCase> testCaseList = testCaseDao.getTestCaseRouteKeyNum(testCaseRouteGroupNum);
			int sucess = testCaseDao.deleteTestCase(testCaseRouteGroupNum);
			if (sucess <= 0)
				return "FALSE";
			for (TestCase testCase : testCaseList) {
				testCaseDao.deleteTestCaseRouteContents(testCase.getTestCaseRouteKeyNum());
			}
		}
		return "OK";
	}

	public TestCase getTestCaseFormOne(TestCase testCase) {
		return testCaseDao.getTestCaseFormOne(testCase);
	}

	public TestCase getTestCaseRouteOne(TestCase testCase) {
		return testCaseDao.getTestCaseRouteOne(testCase);
	}

	public String testCaseCopy(TestCase testCase, Principal principal) {
		int count = testCaseDao.testCaseConfirmed(testCase);
		if(count > 0) {
			return "Duplication";
		}
		int maxRouteGroutNum = testCaseDao.getMaxTestCaseRouteGroupNum()+1;
		List<TestCase> testCaseRouteList = new ArrayList<TestCase>();
		TestCase testCaseContents = new TestCase();
		testCaseRouteList = testCaseDao.getTestCaseRouteList(testCase);
		testCaseContents = testCase;
		int testCaseRouteKeyNum;
		for(TestCase testCaseRoute : testCaseRouteList) {
			testCaseRoute.setTestCaseRouteGroupNum(maxRouteGroutNum);
			testCaseRoute.setTestCaseRouteCustomer(testCase.getTestCaseRouteCustomer());
			testCaseRoute.setTestCaseRouteNote(testCase.getTestCaseRouteNote());
			testCaseRoute.setTestCaseRouteDate(nowDate());
			testCaseRoute.setTestCaseRouteRegistrant(principal.getName());
			testCaseRoute.setTestCaseRouteRegistrationDate(nowDate());
			testCaseRouteKeyNum = testCaseRoute.getTestCaseRouteKeyNum();
			testCaseRoute.setTestCaseRouteSortNum(testCaseDao.getMaxTestCaseRouteSortNum()+1); 
			testCaseDao.insertRoute(testCaseRoute);
			try {
				testCaseContents = testCaseDao.getTestCaseContents(testCaseRouteKeyNum);
				testCaseContents.setTestCaseRouteKeyNum(testCaseRoute.getTestCaseRouteKeyNum());
				testCaseContents.setTestCaseContentsRegistrant(principal.getName());
				testCaseContents.setTestCaseContentsRegistrationDate(nowDate());
				testCaseDao.testCaseContentsCopyInsert(testCaseContents);
			} catch (Exception e) {
			}
		}
		return "OK";
	}

	public String testCaseRouteMove(TestCase testCase) {
		if(testCase.getTestCaseRouteFullPath().equals("/")) {
			return "RouteFALSE";
		} 
		
		if(testCase.getTestCaseRouteFullPath().contains(testCase.getStartTestCaseRouteFullPath())) {
			return "Including";
		}
		
		if(testCase.getHitMode().equals("over")) {
			testCase.setOvelapTestCase(testCase.getTestCaseRouteFullPath()+"/"+testCase.getTestCaseRouteName());
			if(testCaseDao.getMoveOverlap(testCase) != null) {
				return "Overlap";
			}
			
			List<TestCase> testCaseList = testCaseDao.getTestCaseRouteFullPathMoveList(testCase);
			for (TestCase testCaseSub : testCaseList) {
				testCaseSub.setTestCaseRouteFullPath(testCaseSub.getTestCaseRouteFullPath().substring(testCase.getStartTestCaseRouteFullPath().length() - testCase.getTestCaseRouteName().length()-1));
				if(testCase.getStartTestCaseRouteParentPath().length() != 1)
					testCaseSub.setTestCaseRouteParentPath(testCaseSub.getTestCaseRouteParentPath().substring(testCase.getStartTestCaseRouteParentPath().length()));
				testCaseSub.setStartTestCaseRouteSortNum(testCaseSub.getTestCaseRouteSortNum());
				testCaseSub.setEndTestCaseRouteSortNum(testCaseSub.getTestCaseRouteSortNum());
				testCaseSub.setTestCaseRouteFullPath(testCase.getTestCaseRouteFullPath() + testCaseSub.getTestCaseRouteFullPath());
				testCaseSub.setTestCaseRouteParentPath(testCase.getTestCaseRouteFullPath() + testCaseSub.getTestCaseRouteParentPath());
				testCaseDao.testCaseRouteMove(testCaseSub);
			}
			testCase.setTestCaseRouteParentPath(testCase.getTestCaseRouteFullPath());
			testCase.setTestCaseRouteFullPath(testCase.getTestCaseRouteFullPath() + "/" + testCase.getTestCaseRouteName());
			testCase.setEndTestCaseRouteSortNum(testCaseDao.getMaxTestCaseRouteSortNum()+1);
			testCaseDao.testCaseRouteMove(testCase);
		} else {
			testCase.setOvelapTestCase(testCase.getTestCaseRouteParentPath()+"/"+testCase.getTestCaseRouteName());
			if(testCaseDao.getMoveOverlap(testCase) != null) {
				return "Overlap";
			}
			
 			List<TestCase> testCaseList = testCaseDao.getTestCaseRouteFullPathMoveList(testCase);
 			for (TestCase testCaseSub : testCaseList) {
				testCaseSub.setTestCaseRouteFullPath(testCaseSub.getTestCaseRouteFullPath().substring(testCase.getStartTestCaseRouteFullPath().length() - testCase.getTestCaseRouteName().length()-1));
				if(testCase.getStartTestCaseRouteParentPath().length() != 1)
					testCaseSub.setTestCaseRouteParentPath(testCaseSub.getTestCaseRouteParentPath().substring(testCase.getStartTestCaseRouteParentPath().length()));
				testCaseSub.setStartTestCaseRouteSortNum(testCaseSub.getTestCaseRouteSortNum());
				testCaseSub.setEndTestCaseRouteSortNum(testCaseSub.getTestCaseRouteSortNum());
				if(!testCase.getTestCaseRouteParentPath().equals("/")) {
					testCaseSub.setTestCaseRouteFullPath(testCase.getTestCaseRouteParentPath() + testCaseSub.getTestCaseRouteFullPath());
					testCaseSub.setTestCaseRouteParentPath(testCase.getTestCaseRouteParentPath() + testCaseSub.getTestCaseRouteParentPath());
				}
				testCaseDao.testCaseRouteMove(testCaseSub);
			}
 			if(!testCase.getTestCaseRouteParentPath().equals("/"))
 				testCase.setTestCaseRouteFullPath(testCase.getTestCaseRouteParentPath() + "/" + testCase.getTestCaseRouteName());
 			else
 				testCase.setTestCaseRouteFullPath(testCase.getTestCaseRouteParentPath() + testCase.getTestCaseRouteName());
		}
		
		if(testCase.getHitMode().equals("before")) {			
			testCaseDao.testCaseRouteMovePlus(testCase.getEndTestCaseRouteSortNum() - 1);
			if(testCase.getStartTestCaseRouteSortNum() > testCase.getEndTestCaseRouteSortNum())
				testCase.setStartTestCaseRouteSortNum(testCase.getStartTestCaseRouteSortNum() + 1);
			testCaseDao.testCaseRouteMove(testCase);
		} else if(testCase.getHitMode().equals("after")) {
			testCaseDao.testCaseRouteMovePlus(testCase.getEndTestCaseRouteSortNum());
			if(testCase.getStartTestCaseRouteSortNum() > testCase.getEndTestCaseRouteSortNum()) 
				testCase.setStartTestCaseRouteSortNum(testCase.getStartTestCaseRouteSortNum() + 1);
			testCase.setEndTestCaseRouteSortNum(testCase.getEndTestCaseRouteSortNum() + 1);
			testCaseDao.testCaseRouteMove(testCase);
		}
		return "OK";
		
	}

	
}
