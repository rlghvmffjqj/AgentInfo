package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.Employee;

@Repository
public class EmployeeDao {
	@Autowired SqlSessionTemplate sqlSession;
	
	public List<Employee> getEmployeeList(Employee search) {
		return sqlSession.selectList("employee.getEmployee", search);
	}

	public int delEmployee(String employeeId) {
		return sqlSession.delete("employee.delEmployee", employeeId);
	}

	public int getEmployeeListCount(Employee search) {
		return sqlSession.selectOne("employee.getEmployeeCount", search);
	}


	public int insertEmployee(Employee employee) {
		return sqlSession.insert("employee.insertEmployee", employee);
	}

	public Employee getEmployeeOne(String employeeId) {
		return sqlSession.selectOne("employee.getEmployeeOne", employeeId);
	}

	public int updateEmployee(Employee employee) {
		return sqlSession.update("employee.updateEmployee", employee);
	}

	public int updateUsers(Employee employee) {
		return sqlSession.insert("employee.updateUsers", employee);
	}

	public int updateUsersRole(Employee employee) {
		return sqlSession.insert("employee.updateUsersRole", employee);
	}

}
