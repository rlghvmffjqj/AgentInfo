package com.secuve.agentInfo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.TestCaseDao;

@Service
public class TestCaseService {
	@Autowired TestCaseDao testCaseDao;
}
