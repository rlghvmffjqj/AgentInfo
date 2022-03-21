package com.secuve.agentInfo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.EmployeeDao;
import com.secuve.agentInfo.vo.Employee;
import com.secuve.agentInfo.vo.Users;


@Service
public class EmployeeService {

	@Autowired EmployeeDao employeeDao;
	@Autowired Employee employee;
	@Autowired UsersService usersService;
	@Autowired Users users;
	
	public List<Employee> getEmployeeList(Employee search) {

		List<Employee> list = new ArrayList<Employee>();
		list = employeeDao.getEmployeeList(search);
		for (Employee employee : list) {
			if(employee.getUsersRole().equals("ADMIN"))
				employee.setUsersRole("관리자");
			else {
				employee.setUsersRole("일반 사용자");
			}
		}
		return list;
	}

	public String delEmployee(String[] chkList) {
		for(String employeeId: chkList) {
			int sucess = employeeDao.delEmployee(employeeId);
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
		} else if(employeeDao.getEmployeeOne(employee.getEmployeeId()) != null) {
			return "duplicateCheck";
		}
		
		int sucess = employeeDao.insertEmployee(employee);
		users.setUsersId(employee.getEmployeeId());
		users.setUsersPw(employee.getUsersPw());
		users.setUsersRole(employee.getUsersRole());
		
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

	
}
