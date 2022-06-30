package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
		customerInfo.setCustomerInfoKeyNum(CustomerInfoKeyNum());
		if(customerInfoDao.getCustomerInfoCount(customerInfo.getCustomerName(), customerInfo.getBusinessName(), customerInfo.getNetworkClassification()) > 0) {
			return "Overlap";
		}
		int sucess = customerInfoDao.insertCustomerInfo(customerInfo);
		
		// 카테고리 추가 & 고객사 비즈니스 매핑
		if (sucess > 0) {
			customerBusinessMappingService.customerBusinessMapping(customerInfo.getCustomerName(), customerInfo.getBusinessName());
			categoryCheck(customerInfo, principal);
		}
		return parameter(sucess);
	}
	
	public int CustomerInfoKeyNum() {
		int customerInfoKeyNum = 0;
		try {
			customerInfoKeyNum = customerInfoDao.getCustomerInfoKeyNum();
		} catch (Exception e) {
			return customerInfoKeyNum;
		}
		return ++customerInfoKeyNum;
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

	public CustomerInfo getCustomerInfoOne(int customerInfoKeyNum) {
		return customerInfoDao.getCustomerInfoOne(customerInfoKeyNum);
	}

	public String updateCustomerInfo(CustomerInfo customerInfo, Principal principal) {
		if (customerInfo.getCustomerNameSelf().length() > 0) {
			customerInfo.setCustomerName(customerInfo.getCustomerNameSelf());
		}
		if (customerInfo.getCustomerName().equals("") || customerInfo.getCustomerName() == "") { // 고객사명 값이 비어있을 경우
			return "NotCustomerName";
		}
		selfInput(customerInfo);
		int sucess = 0;
		
		int division = customerInfoDao.getCustomerInfoDivision(customerInfo.getCustomerInfoKeyNum(), customerInfo.getCustomerName(), customerInfo.getBusinessName(), customerInfo.getNetworkClassification());
		if(customerInfoDao.getCustomerInfoCount(customerInfo.getCustomerName(), customerInfo.getBusinessName(), customerInfo.getNetworkClassification()) > division) {
			return "Overlap";
		}
		sucess = customerInfoDao.updateCustomerInfo(customerInfo);
		
		if(customerInfoDao.getCustomerInfoCount(customerInfo.getCustomerName(), customerInfo.getBusinessName(), customerInfo.getNetworkClassification()) > 1) {
			return "Overlap";
		} 
		
		
		// 카테고리 추가 & 고객사 비즈니스 매핑
		if (sucess > 0) {
			customerBusinessMappingService.customerBusinessMapping(customerInfo.getCustomerName(), customerInfo.getBusinessName());
			categoryCheck(customerInfo, principal);
		}
		return parameter(sucess);
	}

	public List<CustomerInfo> getCustomerInfoList(String customerName) {
		return customerInfoDao.getCustomerInfoList(customerName);
	}

	public String deleteCustomerInfo(ArrayList<CustomerInfo> chkList) {
		for (CustomerInfo customerInfo : chkList) {
			CustomerInfo customerInfoSub = customerInfoDao.getCustomerInfoOne(customerInfo.getCustomerInfoKeyNum());
			int sucess = customerInfoDao.deleteCustomerInfo(customerInfo.getCustomerInfoKeyNum());

			if (sucess <= 0)
				return "FALSE";
		}
		return "OK";
	}

}
