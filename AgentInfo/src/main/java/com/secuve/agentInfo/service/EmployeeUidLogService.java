package com.secuve.agentInfo.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.EmployeeDao;
import com.secuve.agentInfo.dao.EmployeeUidLogDao;
import com.secuve.agentInfo.vo.Employee;
import com.secuve.agentInfo.vo.EmployeeUidLog;

@Service
public class EmployeeUidLogService {
	@Autowired EmployeeUidLogDao employeeUidLogDao;
	@Autowired EmployeeDao employeeDao;

	public List<String> getEmployeeId() {
		return employeeUidLogDao.getEmployeeId();
	}

	public List<EmployeeUidLog> getEmployeeUidLogList(EmployeeUidLog search) {
		return employeeUidLogDao.getEmployeeUidLogList(EmployeeUidLogSearch(search));
	}
	
	public EmployeeUidLog EmployeeUidLogSearch(EmployeeUidLog search) {
		search.setEmployeeUidLogEmployeeIdArr(search.getEmployeeUidLogEmployeeId().split(","));
		return search;
	}

	public int getEmployeeUidLogListCount(EmployeeUidLog search) {
		return employeeUidLogDao.getEmployeeUidLogListCount(EmployeeUidLogSearch(search));
	}

	public void insertEmployeeUidLog(String employeeId) {
		int employeeUidLogKeyNum = 0;
		EmployeeUidLog employeeUidLog = new EmployeeUidLog();
		Employee employee = employeeDao.getEmployeeOne(employeeId);
		
		try {
			employeeUidLogKeyNum = employeeUidLogDao.employeeUidLogKeyNum();
			employeeUidLogKeyNum++;
		} catch (Exception e) {
		}
		
		employeeUidLog.setEmployeeUidLogKeyNum(employeeUidLogKeyNum);
		employeeUidLog.setEmployeeUidLogEmployeeId(employee.getEmployeeId());
		employeeUidLog.setEmployeeUidLogEmployeeName(employee.getEmployeeName());
		employeeUidLog.setEmployeeUidLogDepartmentName(employee.getDepartmentName());
		employeeUidLog.setEmployeeUidLogEmployeeType(employee.getEmployeeType());
		employeeUidLog.setEmployeeUidLogEmployeeRank(employee.getEmployeeRank());
		employeeUidLog.setEmployeeUidLogLoginTime(nowDate());
		
		employeeUidLogDao.insertEmployeeUidLog(employeeUidLog);
	}
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}
	
}
