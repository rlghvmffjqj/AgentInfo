package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.CustomerInfoDao;
import com.secuve.agentInfo.dao.CustomerUidLogDao;
import com.secuve.agentInfo.vo.CustomerInfo;
import com.secuve.agentInfo.vo.CustomerUidLog;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class CustomerInfoService {
	@Autowired CustomerInfoDao customerInfoDao;
	@Autowired CustomerBusinessMappingService customerBusinessMappingService;
	@Autowired CategoryService categoryService;
	@Autowired CustomerUidLogDao customerUidLogDao;

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
		if(customerInfoDao.getCustomerInfoCount(customerInfo.getCustomerName(), customerInfo.getBusinessName(), customerInfo.getNetworkClassification()) > 0) {
			return "Overlap";
		}
		int sucess = customerInfoDao.insertCustomerInfo(customerInfo);
		
		// 카테고리 추가 & 고객사 비즈니스 매핑
		if (sucess > 0) {
			customerBusinessMappingService.customerBusinessMapping(customerInfo.getCustomerName(), customerInfo.getBusinessName());
			categoryCheck(customerInfo, principal);
			customerUidLog(customerInfo, principal, "INSERT");
		}
		return parameter(sucess);
	}
	
	public void customerUidLog(CustomerInfo customerInfo, Principal principal, String event) {
		CustomerUidLog customerUidLog = new CustomerUidLog();
		
		customerUidLog.setCustomerUidLogCustomerName(customerInfo.getCustomerName());
		customerUidLog.setCustomerUidLogBusinessName(customerInfo.getBusinessName());
		customerUidLog.setCustomerUidLogNetworkClassification(customerInfo.getNetworkClassification());
		customerUidLog.setCustomerUidLogCustomerManagerName(customerInfo.getCustomerManagerName());
		customerUidLog.setCustomerUidLogCustomerPhoneNumber(customerInfo.getCustomerPhoneNumber());
		customerUidLog.setCustomerUidLogCustomerFullAddress(customerInfo.getCustomerFullAddress());
		customerUidLog.setCustomerUidLogCustomerDept(customerInfo.getCustomerDept());
		customerUidLog.setCustomerUidLogEmployeeSeName(customerInfo.getEmployeeSeName());
		customerUidLog.setCustomerUidLogEmployeeSalesName(customerInfo.getEmployeeSalesName());
		customerUidLog.setCustomerUidLogTosmsVer(customerInfo.getTosmsVer());
		customerUidLog.setCustomerUidLogTosrfVer(customerInfo.getTosrfVer());
		customerUidLog.setCustomerUidLogPortalVer(customerInfo.getPortalVer());
		customerUidLog.setCustomerUidLogJavaVer(customerInfo.getJavaVer());
		customerUidLog.setCustomerUidLogWebServerVer(customerInfo.getWebServerVer());
		customerUidLog.setCustomerUidLogDatabaseVer(customerInfo.getDatabaseVer());
		customerUidLog.setCustomerUidLogLogServerVer(customerInfo.getLogServerVer());
		customerUidLog.setCustomerUidLogScvEaVer(customerInfo.getScvEaVer());
		customerUidLog.setCustomerUidLogScvCaVer(customerInfo.getScvCaVer());
		customerUidLog.setCustomerUidLogAuthPkiVer(customerInfo.getAuthPkiVer());
		customerUidLog.setCustomerUidEvent(event);
		customerUidLog.setCustomerUidUser(principal.getName());
		customerUidLog.setCustomerUidTime(nowDate());
		customerUidLog.setCustomerUidLogOsType(customerInfo.getOsType());
		customerUidLogDao.insertCustomerUidLog(customerUidLog);
		
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
			customerUidLog(customerInfo, principal, "UPDATE");
		}
		return parameter(sucess);
	}

	public List<CustomerInfo> getCustomerInfoList(String customerName) {
		return customerInfoDao.getCustomerInfoList(customerName);
	}

	public String deleteCustomerInfo(ArrayList<CustomerInfo> chkList, Principal principal) {
		for (CustomerInfo customerInfo : chkList) {
			CustomerInfo customerInfoSub = customerInfoDao.getCustomerInfoOne(customerInfo.getCustomerInfoKeyNum());
			int sucess = customerInfoDao.deleteCustomerInfo(customerInfo.getCustomerInfoKeyNum());

			if(sucess > 0) {
				customerUidLog(customerInfoSub, principal, "DELETE");
			}
			
			if (sucess <= 0)
				return "FALSE";
		}
		return "OK";
	}

}
