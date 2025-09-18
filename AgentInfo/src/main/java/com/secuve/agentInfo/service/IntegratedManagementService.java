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

}
