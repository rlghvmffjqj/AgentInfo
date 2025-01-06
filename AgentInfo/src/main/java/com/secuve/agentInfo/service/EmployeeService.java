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
import com.secuve.agentInfo.vo.Issue;
import com.secuve.agentInfo.vo.Users;


@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class EmployeeService {

	@Autowired EmployeeDao employeeDao;
	@Autowired Employee employee;
	@Autowired UsersService usersService;
	@Autowired Users users;
	
	public List<Employee> getEmployeeList(Employee search) {
        List<Employee> employees = employeeDao.getEmployeeList(search);
        for (Employee employee : employees) {
            employee.setUsersRole(getLocalizedRole(employee.getUsersRole()));
        }
        return employees;
    }

    private String getLocalizedRole(String role) {
        switch (role) {
            case "ADMIN":
                return "관리자";
            case "ENGINEER":
                return "엔지니어";
            case "QA":
                return "QA";
            case "LICENSE":
                return "라이선스 관리자";
            case "ENGINEERLEADER":
                return "엔지니어 팀장";
            case "SALES":
                return "영업";
            default:
                return "일반 사용자";
        }
    }

	public String delEmployee(String[] chkList) {
		for(String employeeId: chkList) {
			int success = employeeDao.delEmployee(employeeId);
			success *= employeeDao.delUsers(employeeId);
			if(success <= 0) 
				return "FALSE";
		}
		return "OK";
	}

	public int getEmployeeListCount(Employee search) {
		return employeeDao.getEmployeeListCount(search);
	}


	public String insertEmployee(Employee employee) {
		if (employee.getEmployeeId().isEmpty()) {
            return "NotEmployeeId";
        }
        if (employee.getEmployeeName().isEmpty()) {
            return "NotEmployeeName";
        }
        if (employee.getUsersPw().isEmpty()) {
            return "NotUsersPw";
        }
        if (employeeDao.getEmployeeOne(employee.getEmployeeId()) != null) {
            return "duplicateCheck";
        }
		employee.setDepartmentParentPath(employee.getDepartmentFullPath().replace("/"+employee.getDepartmentName(), ""));
		
		int success = employeeDao.insertEmployee(employee);
		users.setUsersId(employee.getEmployeeId());
		users.setUsersPw(employee.getUsersPw());
		users.setUsersRole(employee.getUsersRole());
		users.setPwdChangeYn(employee.getPwdChangeYn());
		
		if(success <= 0) 
			return "FALSE";
		return usersService.save(users);
	}

	public Employee getEmployeeOne(String employeeId) {
		return employeeDao.getEmployeeOne(employeeId);
	}

	public String updateEmployee(Employee employee) {
        if (employee.getEmployeeName().isEmpty()) {
            return "NotEmployeeName";
        }

        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        if (!employee.getUsersPw().isEmpty()) {
            employee.setUsersPw(passwordEncoder.encode(employee.getUsersPw()));
            if (employeeDao.updateUsers(employee) <= 0) {
                return "FALSE";
            }
        } else if (employeeDao.updateUsersRole(employee) <= 0) {
            return "FALSE";
        }

        if (employeeDao.updateEmployee(employee) <= 0) {
            return "FALSE";
        }
        return "OK";
    }

	public String updateDepartmentMove(String[] employeeIds, Employee employee) {
        employee.setDepartmentParentPath(
                employee.getDepartmentFullPath().replace("/" + employee.getDepartmentName(), "")
        );
        for (String employeeId : employeeIds) {
            employee.setEmployeeId(employeeId);
            if (employeeDao.updateDepartmentMove(employee) <= 0) {
                return "FALSE";
            }
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
        try {
            String lastLoginString = employeeDao.loginSession(employeeId);
            Date lastLogin = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(lastLoginString);
            Date expireTime = DateUtils.addMinutes(lastLogin, loginSession);
            if (new Date().after(expireTime)) {
                return "TimeOut";
            }
        } catch (ParseException e) {
            return "Error";
        }
        return "OK";
    }

	public String getUsersRole(String usersId) {
		return employeeDao.getUsersRole(usersId);
	}

	public List<Employee> getEmployeeAll() {
		return employeeDao.getEmployeeAll();
	}

	public String getEmployeeDepartment(String employeeId) {
		return employeeDao.getEmployeeDepartment(employeeId);
	}

	public List<Integer> getAlarmIndex(int issueKeyNum, String employeeId) {
		return employeeDao.getAlarmIndex(issueKeyNum, employeeId);
	}

	public void updateAlarmY(int issueKeyNum, String employeeId) {
		employeeDao.updateAlarmY(issueKeyNum, employeeId);
	}
	

}