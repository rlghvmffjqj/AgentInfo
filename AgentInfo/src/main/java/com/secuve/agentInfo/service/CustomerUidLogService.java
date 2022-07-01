package com.secuve.agentInfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.CustomerUidLogDao;
import com.secuve.agentInfo.vo.CustomerUidLog;

@Service
public class CustomerUidLogService {
	@Autowired CustomerUidLogDao customerUidLogDao;

	public List<CustomerUidLog> getCustomerUidLogList(CustomerUidLog search) {
		return customerUidLogDao.getCustomerUidLogList(CustomerUidLogSearch(search));
	}
	
	public CustomerUidLog CustomerUidLogSearch(CustomerUidLog search) {
		search.setCustomerUidLogCustomerNameArr(search.getCustomerUidLogCustomerName().split(","));
		search.setCustomerUidLogBusinessNameArr(search.getCustomerUidLogBusinessName().split(","));
		search.setCustomerUidEventArr(search.getCustomerUidEvent().split(","));
		
		return search;
	}

	public int getCustomerUidLogListCount(CustomerUidLog search) {
		return customerUidLogDao.getCustomerUidLogListCount(CustomerUidLogSearch(search));
	}
}
