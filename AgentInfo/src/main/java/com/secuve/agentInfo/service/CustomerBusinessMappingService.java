package com.secuve.agentInfo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.CustomerBusinessMappingDao;

@Service
public class CustomerBusinessMappingService {
	@Autowired CustomerBusinessMappingDao customerBusinessMappingDao;

	public void customerBusinessMapping(String customerName, String businessName) {
		if(businessName != null || businessName != "") {
			int count = customerBusinessMappingDao.getBusinessCount(customerName, businessName);
			if(count <= 0) {
				customerBusinessMappingDao.insertCustomerBusiness(customerName, businessName);
			}
		}
	}
}