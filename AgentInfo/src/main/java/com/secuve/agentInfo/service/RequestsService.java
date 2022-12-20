package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.RequestsDao;
import com.secuve.agentInfo.vo.Packages;
import com.secuve.agentInfo.vo.Requests;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class RequestsService {
	@Autowired RequestsDao requestsDao;

	public List<Requests> getRequestsList(Requests search) {
		return requestsDao.getRequestsList(requestsSearch(search));
	}

	public int getRequestsListCount() {
		return requestsDao.getRequestsListCount();
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String insertRequests(Requests requests) {
		int sucess = requestsDao.insertRequests(requests);
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public Requests getRequestsOne(int requestsKeyNum) {
		return requestsDao.getRequestsOne(requestsKeyNum);
	}
	
	public Requests requestsSearch(Requests search) {
		search.setEmployeeIdArr(search.getEmployeeId().split(","));
		search.setEmployeeNameArr(search.getEmployeeName().split(","));
		search.setRequestsStateArr(search.getRequestsState().split(","));
		return search;
	}

	public String updateRequests(Requests requests, Principal principal) {
		int sucess = requestsDao.updateRequests(requests);
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public String setRequestsState(int[] chkList, String requestsState, Principal principal) {
		Requests requests = new Requests();
		requests.setRequestsState(requestsState);
		for (int requestsKeyNum : chkList) {
			requests.setRequestsKeyNum(requestsKeyNum);
			int sucess = requestsDao.updateRequests(requests);

			if (sucess <= 0)
				return "FALSE";
		}
		return "OK";
	}

	public int getRequestsCount() {
		return requestsDao.getRequestsCount();
	}
}