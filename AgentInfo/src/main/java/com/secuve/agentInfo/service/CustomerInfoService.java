package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.CustomerInfoDao;
import com.secuve.agentInfo.vo.CustomerInfo;

@Service
public class CustomerInfoService {
	@Autowired CustomerInfoDao customerInfoDao;
	@Autowired CustomerBusinessMappingService customerBusinessMappingService;
	@Autowired CategoryService categoryService;

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String insertCustomerInfo(CustomerInfo customerInfo, Principal principal) {
		if (customerInfo.getCustomerNameSelf().length() > 0) {
			customerInfo.setCustomerName(customerInfo.getCustomerNameSelf());
		}
		if (customerInfo.getCustomerName().equals("") || customerInfo.getCustomerName() == "") { // 고객사명 값이 비어있을 경우
			return "NotCustomerName";
		}
		selfInput(customerInfo);
		int sucess = customerInfoDao.insertCustomerInfo(customerInfo);
		
		// 카테고리 추가 & 고객사 비즈니스 매핑
		if (sucess > 0) {
			customerBusinessMappingService.customerBusinessMapping(customerInfo.getCustomerName(), customerInfo.getBusinessName());
			categoryCheck(customerInfo, principal);
		}
		return parameter(sucess);
	}
	
	public CustomerInfo selfInput(CustomerInfo customerInfo) {
		if(customerInfo.getCustomerNameSelf().length() > 0)
			customerInfo.setCustomerName(customerInfo.getCustomerNameSelf());
		if(customerInfo.getBusinessNameSelf().length() > 0)
			customerInfo.setBusinessName(customerInfo.getBusinessNameSelf());
		return customerInfo;
	}
	
	public String parameter(int sucess) {
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}
	
	public void categoryCheck(CustomerInfo customerInfo, Principal principal) {
		if (categoryService.getCategory("customerName", customerInfo.getCustomerName()) == 0) {
			categoryService.setCategory("customerName", customerInfo.getCustomerName(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("businessName", customerInfo.getBusinessName()) == 0) {
			categoryService.setCategory("businessName", customerInfo.getBusinessName(), principal.getName(), nowDate());
		}
	}

	public CustomerInfo getCustomerInfoOne(String customerName, String businessName) {
		return customerInfoDao.getCustomerInfoOne(customerName, businessName);
	}

}
