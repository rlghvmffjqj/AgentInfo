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

import com.secuve.agentInfo.dao.License5UidLogDao;
import com.secuve.agentInfo.vo.License5;
import com.secuve.agentInfo.vo.License5UidLog;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class License5UidLogService {
	@Autowired License5UidLogDao license5UidLogDao;

	public List<String> getSelectInput(String selectInput) {
		return license5UidLogDao.getSelectInput(selectInput);
	}

	public List<License5UidLog> getLicenseList(License5UidLog search) {
		return license5UidLogDao.getLicenseList(licenseSearch(search));
	}
	
	public int getLicenseListCount(License5UidLog search) {
		return license5UidLogDao.getLicenseListCount(licenseSearch(search));
	}
	
	public License5UidLog licenseSearch(License5UidLog search) {
		search.setCustomerNameArr(search.getCustomerName().split(","));
		search.setBusinessNameArr(search.getBusinessName().split(","));
		search.setRequesterArr(search.getRequester().split(","));;
		search.setProductTypeArr(search.getProductType().split(","));
		search.setAdditionalInformationArr(search.getAdditionalInformation().split(","));
		search.setMacAddressArr(search.getMacAddress().split(","));
		search.setManagerOsTypeArr(search.getManagerOsType().split(","));
		search.setManagerDbmsTypeArr(search.getManagerDbmsType().split(","));
		search.setProductVersionArr(search.getProductVersion().split(","));
		search.setLicenseFilePathArr(search.getLicenseFilePath().split(","));
		search.setSerialNumberArr(search.getSerialNumber().split(","));
		search.setCountryArr(search.getCountry().split(","));
		search.setLicense5UidLogEventArr(search.getLicense5UidLogEvent().split(","));
		
		return search;
	}
	
	public void license5UidLogInsert(License5 license, String event, Principal principal) {
		License5UidLog license5UidLog = new License5UidLog();
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		license5UidLog.setProductType(license.getProductTypeView());
		license5UidLog.setCustomerName(license.getCustomerNameView());
		license5UidLog.setBusinessName(license.getBusinessNameView());
		license5UidLog.setAdditionalInformation(license.getAdditionalInformationView());
		license5UidLog.setMacAddress(license.getMacAddressView());
		license5UidLog.setIssueDate(license.getIssueDateView());
		license5UidLog.setExpirationDays(license.getExpirationDaysView());
		license5UidLog.setIgriffinAgentCount(license.getIgriffinAgentCountView());
		license5UidLog.setTos5AgentCount(license.getTos5AgentCountView());
		license5UidLog.setTos2AgentCount(license.getTos2AgentCountView());
		license5UidLog.setDbmsCount(license.getDbmsCountView());
		license5UidLog.setNetworkCount(license.getNetworkCountView());
		license5UidLog.setAixCount(license.getAixCountView());
		license5UidLog.setHpuxCount(license.getHpuxCountView());
		license5UidLog.setSolarisCount(license.getSolarisCountView());
		license5UidLog.setLinuxCount(license.getLinuxCountView());
		license5UidLog.setWindowsCount(license.getWindowsCountView());
		license5UidLog.setManagerOsType(license.getManagerOsTypeView());
		license5UidLog.setManagerDbmsType(license.getManagerDbmsTypeView());
		license5UidLog.setCountry(license.getCountryView());
		license5UidLog.setProductVersion(license.getProductVersionView());
		license5UidLog.setLicenseFilePath(license.getLicenseFilePathView());
		license5UidLog.setSerialNumber(license.getSerialNumberView());
		license5UidLog.setRequester(license.getRequesterView());
		license5UidLog.setLicense5UidLogEvent(event);
		license5UidLog.setLicense5UidUser(principal.getName());
		license5UidLog.setLicense5UidTime(formatter.format(now));
		license5UidLog.setLicense5IssuanceRegistrant(principal.getName());
		license5UidLog.setLicense5IssuanceRegistrationDate(formatter.format(now));
		
		license5UidLogDao.license5UidLogInsert(license5UidLog);
	}
	
	public void license5UidLogDeleteInsert(License5 license, String event, Principal principal) {
		License5UidLog license5UidLog = new License5UidLog();
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		license5UidLog.setProductType(license.getProductType());
		license5UidLog.setCustomerName(license.getCustomerName());
		license5UidLog.setBusinessName(license.getBusinessName());
		license5UidLog.setAdditionalInformation(license.getAdditionalInformation());
		license5UidLog.setMacAddress(license.getMacAddress());
		license5UidLog.setIssueDate(license.getIssueDate());
		license5UidLog.setExpirationDays(license.getExpirationDays());
		license5UidLog.setIgriffinAgentCount(license.getIgriffinAgentCount());
		license5UidLog.setTos5AgentCount(license.getTos5AgentCount());
		license5UidLog.setTos2AgentCount(license.getTos2AgentCount());
		license5UidLog.setDbmsCount(license.getDbmsCount());
		license5UidLog.setNetworkCount(license.getNetworkCount());
		license5UidLog.setAixCount(license.getAixCount());
		license5UidLog.setHpuxCount(license.getHpuxCount());
		license5UidLog.setSolarisCount(license.getSolarisCount());
		license5UidLog.setLinuxCount(license.getLinuxCount());
		license5UidLog.setWindowsCount(license.getWindowsCount());
		license5UidLog.setManagerOsType(license.getManagerOsType());
		license5UidLog.setManagerDbmsType(license.getManagerDbmsType());
		license5UidLog.setCountry(license.getCountry());
		license5UidLog.setProductVersion(license.getProductVersion());
		license5UidLog.setLicenseFilePath(license.getLicenseFilePath());
		license5UidLog.setSerialNumber(license.getSerialNumber());
		license5UidLog.setRequester(license.getRequester());
		license5UidLog.setLicense5UidLogEvent(event);
		license5UidLog.setLicense5UidUser(principal.getName());
		license5UidLog.setLicense5UidTime(formatter.format(now));
		license5UidLog.setLicense5IssuanceRegistrant(principal.getName());
		license5UidLog.setLicense5IssuanceRegistrationDate(formatter.format(now));
		
		license5UidLogDao.license5UidLogInsert(license5UidLog);
	}

}
