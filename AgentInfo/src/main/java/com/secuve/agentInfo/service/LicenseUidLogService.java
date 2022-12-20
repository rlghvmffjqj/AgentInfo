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

import com.secuve.agentInfo.dao.LicenseUidLogDao;
import com.secuve.agentInfo.vo.License;
import com.secuve.agentInfo.vo.LicenseUidLog;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class LicenseUidLogService {
	@Autowired LicenseUidLogDao licenseUidLogDao;

	public List<LicenseUidLog> getLicenseUidLogList(LicenseUidLog search) {
		return licenseUidLogDao.getLicenseUidLogList(LicenseUidLogSearch(search));
	}
	
	public int getLicenseUidLogListCount(LicenseUidLog search) {
		return licenseUidLogDao.getLicenseUidLogListCount(LicenseUidLogSearch(search));
	}
	
	public LicenseUidLog LicenseUidLogSearch(LicenseUidLog search) {
		search.setLicenseUidLogCustomerNameArr(search.getLicenseUidLogCustomerName().split(","));
		search.setLicenseUidLogBusinessNameArr(search.getLicenseUidLogBusinessName().split(","));
		search.setLicenseUidLogRequesterArr(search.getLicenseUidLogRequester().split(","));;
		search.setLicenseUidLogPartnersArr(search.getLicenseUidLogPartners().split(","));
		search.setLicenseUidLogOsTypeArr(search.getLicenseUidLogOsType().split(","));
		search.setLicenseUidLogOsVersionArr(search.getLicenseUidLogOsVersion().split(","));
		search.setLicenseUidLogKernelVersionArr(search.getLicenseUidLogKernelVersion().split(","));
		search.setLicenseUidLogTosVersionArr(search.getLicenseUidLogTosVersion().split(","));
		search.setLicenseUidLogMacUmlHostIdArr(search.getLicenseUidLogMacUmlHostId().split(","));
		search.setLicenseUidLogReleaseTypeArr(search.getLicenseUidLogReleaseType().split(","));
		search.setLicenseUidLogDeliveryMethodArr(search.getLicenseUidLogDeliveryMethod().split(","));
		search.setLicenseUidLogEventArr(search.getLicenseUidLogEvent().split(","));
		
		return search;
	}

	public int insertLicenseUidLog(License license, Principal principal, String event, String type) {
		LicenseUidLog licenseUidLog = new LicenseUidLog();
		
		licenseUidLog.setLicenseUidLogLicenseType(license.getLicenseType());
		licenseUidLog.setLicenseUidLogIssueKey(license.getLicenseIssueKey());
		licenseUidLog.setLicenseUidLogEvent(event);
		licenseUidLog.setLicenseUidUser(principal.getName());
		licenseUidLog.setLicenseUidTime(nowDate());
		licenseUidLog.setLicenseUidLogRegistrant(principal.getName());
		licenseUidLog.setLicenseUidLogRegistrationDate(nowDate());
		if(event == "INSERT" && type == "LINUX") {
			licenseUidLog.setLicenseUidLogCustomerName(license.getCustomerNameView());
			licenseUidLog.setLicenseUidLogBusinessName(license.getBusinessNameView());
			licenseUidLog.setLicenseUidLogIssueDate(license.getIssueDateView());
			licenseUidLog.setLicenseUidLogRequester(license.getRequesterView());
			licenseUidLog.setLicenseUidLogPartners(license.getPartnersView());
			licenseUidLog.setLicenseUidLogOsType(license.getOsTypeView());
			licenseUidLog.setLicenseUidLogOsVersion(license.getOsVersionView());
			licenseUidLog.setLicenseUidLogKernelVersion(license.getKernelVersionView());
			licenseUidLog.setLicenseUidLogKernelBit(license.getKernelBitView());
			licenseUidLog.setLicenseUidLogTosVersion(license.getTosVersionView());
			licenseUidLog.setLicenseUidLogPeriod(license.getPeriodView());
			licenseUidLog.setLicenseUidLogMacUmlHostId(license.getMacUmlHostIdView());
			licenseUidLog.setLicenseUidLogReleaseType(license.getReleaseTypeView());
			licenseUidLog.setLicenseUidLogDeliveryMethod(license.getDeliveryMethodView());
		} else if((event == "DELETE" && type == "ALL") || (event == "INSERT" && type == "WINDOWS")) {
			licenseUidLog.setLicenseUidLogCustomerName(license.getCustomerName());
			licenseUidLog.setLicenseUidLogBusinessName(license.getBusinessName());
			licenseUidLog.setLicenseUidLogIssueDate(license.getIssueDate());
			licenseUidLog.setLicenseUidLogRequester(license.getRequester());
			licenseUidLog.setLicenseUidLogPartners(license.getPartners());
			licenseUidLog.setLicenseUidLogOsType(license.getOsType());
			licenseUidLog.setLicenseUidLogOsVersion(license.getOsVersion());
			licenseUidLog.setLicenseUidLogKernelVersion(license.getKernelVersion());
			licenseUidLog.setLicenseUidLogKernelBit(license.getKernelBit());
			licenseUidLog.setLicenseUidLogTosVersion(license.getTosVersion());
			licenseUidLog.setLicenseUidLogPeriod(license.getPeriod());
			licenseUidLog.setLicenseUidLogMacUmlHostId(license.getMacUmlHostId());
			licenseUidLog.setLicenseUidLogReleaseType(license.getReleaseType());
			licenseUidLog.setLicenseUidLogDeliveryMethod(license.getDeliveryMethod());
		}
		
		licenseUidLogDao.insertLicenseUidLog(licenseUidLog);
		return licenseUidLog.getLicenseUidLogKeyNum();
	}
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public List<String> getSelectInput(String selectInput) {
		return licenseUidLogDao.getSelectInput(selectInput);
	}

	public String getLicenseIssueKey(int licenseUidLogKeyNum) {
		String result;
		try {
			result = licenseUidLogDao.getLicenseIssueKey(licenseUidLogKeyNum);
			if(result == "" || result.equals("")) {
				return "FALSE";
			}
		} catch (Exception e) {
			return "FALSE";
		}
		return result;
	}

}
