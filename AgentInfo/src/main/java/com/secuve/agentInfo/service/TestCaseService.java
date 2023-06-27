package com.secuve.agentInfo.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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
}
