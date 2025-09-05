package com.secuve.agentInfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.IntegratedManagementDao;
import com.secuve.agentInfo.vo.IntegratedManagement;

@Service
public class IntegratedManagementService {
	@Autowired IntegratedManagementDao integratedManagementDao;

	public List<IntegratedManagement> getIntegratedManagementList(IntegratedManagement search) {
		return integratedManagementDao.getIntegratedManagementList(search);
	}

	public int getIntegratedManagementListCount(IntegratedManagement search) {
		return integratedManagementDao.getIntegratedManagementListCount(search);
	}

}
