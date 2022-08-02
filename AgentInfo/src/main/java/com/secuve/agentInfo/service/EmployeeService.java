package com.secuve.agentInfo.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.EmployeeDao;
import com.secuve.agentInfo.vo.Employee;
import com.secuve.agentInfo.vo.Users;


@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class EmployeeService {

	@Autowired EmployeeDao employeeDao;
	@Autowired Employee employee;
	@Autowired UsersService usersService;
	@Autowired Users users;
	
	public List<Employee> getEmployeeList(Employee search) {
		List<Employee> list = new ArrayList<Employee>();
		list = employeeDao.getEmployeeList(search);
		for (Employee employee : list) {
			if(employee.getUsersRole().equals("ADMIN")) {
				employee.setUsersRole("관리자");
			} else if(employee.getUsersRole().equals("ENGINEER")) {
				employee.setUsersRole("엔지니어");
			} else {
				employee.setUsersRole("일반 사용자");
			}
		}
		return list;
	}

	public String delEmployee(String[] chkList) {
		for(String employeeId: chkList) {
			int sucess = employeeDao.delEmployee(employeeId);
			sucess *= employeeDao.delUsers(employeeId);
			if(sucess <= 0) 
				return "FALSE";
		}
		return "OK";
	}

	public int getEmployeeListCount(Employee search) {
		return employeeDao.getEmployeeListCount(search);
	}


	public String insertEmployee(Employee employee) {
		if(employee.getEmployeeId().equals("") || employee.getEmployeeId() == "" ) { // 사원 번호가 비어있을경우 리턴
			return "NotEmployeeId";
		} else if(employee.getEmployeeName().equals("") || employee.getEmployeeName() == "") { // 사원 이름이 비어있을 경우 리턴
			return "NotEmployeeName";
		} else if(employee.getUsersPw().equals("") || employee.getUsersPw() == "") {	// 패스워드 미입력
			return "NotUsersPw";
		} else if(employeeDao.getEmployeeOne(employee.getEmployeeId()) != null) {	// 사용자 중복 확인
			return "duplicateCheck";
		}
		employee.setDepartmentParentPath(employee.getDepartmentFullPath().replace("/"+employee.getDepartmentName(), ""));
		
		int sucess = employeeDao.insertEmployee(employee);
		users.setUsersId(employee.getEmployeeId());
		users.setUsersPw(employee.getUsersPw());
		users.setUsersRole(employee.getUsersRole());
		users.setPwdChangeYn(employee.getPwdChangeYn());
		
		if(sucess <= 0) 
			return "FALSE";
		return usersService.save(users);
	}

	public Employee getEmployeeOne(String employeeId) {
		return employeeDao.getEmployeeOne(employeeId);
	}

	public String updateEmployee(Employee employee) {
		int sucess = 0;
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		if(employee.getEmployeeName().equals("") || employee.getEmployeeName() == "") { // 사원 이름이 비어있을 경우 리턴
			return "NotEmployeeName";
		}
		if(!employee.getUsersPw().equals("") || employee.getUsersPw().equals(null)) {
			employee.setUsersPw(passwordEncoder.encode(employee.getUsersPw()));
			sucess = employeeDao.updateUsers(employee);
		} else {
			sucess = employeeDao.updateUsersRole(employee);
		}
		sucess *= employeeDao.updateEmployee(employee);
		
		if(sucess <= 0) 
			return "FALSE";
		return "OK";
	}

	public String updateDepartmentMove(String[] chkList, Employee employee) {
		employee.setDepartmentParentPath(employee.getDepartmentFullPath().replace("/"+employee.getDepartmentName(), ""));
		for(String employeeId: chkList) {
			employee.setEmployeeId(employeeId);
			int sucess =  employeeDao.updateDepartmentMove(employee);
			if(sucess <= 0) 
				return "FALSE";
		}
		return "OK";
	}

	public List<String> getEmployeeId() {
		return employeeDao.getEmployeeId();
	}

	public List<String> getEmployeeName() {
		return employeeDao.getEmployeeName();
	}

	public String loginSession(int loginSession, String employeeId) {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date lastLogin = null;
		try {
			lastLogin = formatter.parse(employeeDao.loginSession(employeeId));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		Date expireTime = DateUtils.addMinutes(lastLogin, loginSession);
		if(now.getTime() > expireTime.getTime()) {
			return "TimeOut";
		}
		return "OK";
	}

	public String getUsersRole(String usersId) {
		return employeeDao.getUsersRole(usersId);
	}

	public List<Employee> getEmployeeAll() {
		return employeeDao.getEmployeeAll();
	}
}