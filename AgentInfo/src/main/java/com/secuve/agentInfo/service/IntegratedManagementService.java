package com.secuve.agentInfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.IntegratedManagementDao;
import com.secuve.agentInfo.dao.ProductVersionDao;
import com.secuve.agentInfo.vo.IntegratedManagement;

@Service
public class IntegratedManagementService {
	@Autowired IntegratedManagementDao integratedManagementDao;
	@Autowired ProductVersionDao productVersionDao;

	public List<IntegratedManagement> getIntegratedManagementList(IntegratedManagement search) {
		return integratedManagementDao.getIntegratedManagementList(search);
	}

	public int getIntegratedManagementListCount(IntegratedManagement search) {
		return integratedManagementDao.getIntegratedManagementListCount(search);
	}

	public void setResultsReportMapping(IntegratedManagement integratedManagement) {
		integratedManagementDao.delResultsReportMapping(integratedManagement);
		integratedManagementDao.setResultsReportMapping(integratedManagement);
	}
	
	public String delResultsReportMapping(IntegratedManagement integratedManagement) {
		int success = integratedManagementDao.delResultsReportMapping(integratedManagement);
        if (success <= 0) {
        	return "FALSE";
        }
        return "OK";
	}

	public IntegratedManagement getIntegratedManagementOne(IntegratedManagement integratedManagement) {
		return integratedManagementDao.getIntegratedManagementOne(integratedManagement);
	}

	public String getProductVersionMapping(IntegratedManagement integratedManagement) {
		int success = 1;
		for(int i=0; i<integratedManagement.getProductVersionKeyNumArr().length; i++) {
			integratedManagement.setMenuKeyNum(integratedManagement.getMenuKeyNumArr()[i]);
			integratedManagement.setProductVersionKeyNum(integratedManagement.getProductVersionKeyNumArr()[i]);
			success *= integratedManagementDao.setProductVersionMapping(integratedManagement);
		}
		if (success <= 0) {
        	return "FALSE";
        }
        return "OK";
	}

	public List<IntegratedManagement> getIntegratedManagementOneList(IntegratedManagement integratedManagement) {
		return integratedManagementDao.getIntegratedManagementOneList(integratedManagement);
	}

	public String delProductVersion(int packagesKeyNum, int[] chkList, int[] chkmenuList, String packageName) {
		int success = 1;
		IntegratedManagement integratedManagement = new IntegratedManagement();
		
		for(int i=0; i<chkList.length; i++) {
			integratedManagement.setPackagesKeyNum(packagesKeyNum);
			integratedManagement.setMenuKeyNum(chkmenuList[i]);
			integratedManagement.setProductVersionKeyNum(chkList[i]);
			integratedManagement.setPackageName(packageName);
			success *= integratedManagementDao.delProductVersion(integratedManagement);
		}
		if (success <= 0) {
        	return "FALSE";
        }
        return "OK";
	}

	public String setIssueMapping(IntegratedManagement integratedManagement) {
		int success = integratedManagementDao.setIssueMapping(integratedManagement);
        if (success <= 0) {
        	return "FALSE";
        }
        return "OK";
	}

	public List<IntegratedManagement> getIntegratedManagementIssue(IntegratedManagement integratedManagement) {
		return integratedManagementDao.getIntegratedManagementIssue(integratedManagement);
	}

	public String delIssue(int packagesKeyNum, int productVersionKeyNum, int menuKeyNum, int issuePrimaryKeyNum, String packageName) {
		IntegratedManagement integratedManagement = new IntegratedManagement();
		integratedManagement.setPackagesKeyNum(packagesKeyNum);
		integratedManagement.setProductVersionKeyNum(productVersionKeyNum);
		integratedManagement.setMenuKeyNum(menuKeyNum);
		integratedManagement.setIssuePrimaryKeyNum(issuePrimaryKeyNum);
		integratedManagement.setPackageName(packageName);
		int success = integratedManagementDao.delIssue(integratedManagement);
		if (success <= 0) {
        	return "FALSE";
        }
        return "OK";
	}

	public List<IntegratedManagement> getPackagesNameProductVersionList(String packageName) {
		return integratedManagementDao.getPackagesNameProductVersionList(packageName);
	}

	public List<IntegratedManagement> getPackagesNameIssueList(IntegratedManagement integratedManagement) {
		return integratedManagementDao.getPackagesNameIssueList(integratedManagement);
	}

}
