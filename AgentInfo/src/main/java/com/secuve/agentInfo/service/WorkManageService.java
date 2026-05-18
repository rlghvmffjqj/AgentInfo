package com.secuve.agentInfo.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.WorkManageDao;
import com.secuve.agentInfo.vo.WorkManage;

@Service
public class WorkManageService {
	@Autowired	WorkManageDao workManageDao;

	public List<WorkManage> getWorkManageList(WorkManage search) {
		return workManageDao.getWorkManageList(workManageSearch(search));
	}

	public int getWorkManageListCount(WorkManage search) {
		return workManageDao.getWorkManageListCount(workManageSearch(search));
	}
	
	public WorkManage workManageSearch(WorkManage search) {
		search.setWorkManageCustomerArr(search.getWorkManageCustomer().split(","));
		search.setWorkManageDivisionArr(search.getWorkManageDivision().split(","));
		search.setWorkManageProgressStatusArr(search.getWorkManageProgressStatus().split(","));
		return search;
	}
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		return formatter.format(now);
	}

	public String nowDateDetail() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String insertWorkManage(WorkManage workManage) {
		int success = workManageDao.insertWorkManage(workManage);
	
		if (success <= 0) return "FALSE";
		return "OK";
	}

}
