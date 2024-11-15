package com.secuve.agentInfo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.EmployeeDao;
import com.secuve.agentInfo.dao.IssueRelayRmDao;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class IssueRelayRmService {
	@Autowired IssueRelayRmDao issueRelayRmDao;
	@Autowired EmployeeDao employeeDao;
	@Autowired IssueService issueService;

}
