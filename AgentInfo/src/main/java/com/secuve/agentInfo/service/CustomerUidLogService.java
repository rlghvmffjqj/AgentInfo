package com.secuve.agentInfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.CustomerUidLogDao;
import com.secuve.agentInfo.vo.CustomerUidLog;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class CustomerUidLogService {
	@Autowired CustomerUidLogDao customerUidLogDao;

	public List<CustomerUidLog> getCustomerUidLogList(CustomerUidLog search) {
		return customerUidLogDao.getCustomerUidLogList(CustomerUidLogSearch(search));
	}
	
	public CustomerUidLog CustomerUidLogSearch(CustomerUidLog search) {
		search.setCustomerUidLogCustomerNameArr(search.getCustomerUidLogCustomerName().split(","));
		search.setCustomerUidLogBusinessNameArr(search.getCustomerUidLogBusinessName().split(","));
		search.setCustomerUidEventArr(search.getCustomerUidEvent().split(","));
		if(search.getCustomerUidDateStart() != "" && search.getCustomerUidDateEnd() != "") {
			search.setCustomerUidDateStart(search.getCustomerUidDateStart() + " 00:00:00");
			search.setCustomerUidDateEnd(search.getCustomerUidDateEnd() + " 24:59:59");
		}
		
		return search;
	}

	public int getCustomerUidLogListCount(CustomerUidLog search) {
		return customerUidLogDao.getCustomerUidLogListCount(CustomerUidLogSearch(search));
	}
}
