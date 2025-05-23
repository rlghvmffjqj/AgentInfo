package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.Employee;
import com.secuve.agentInfo.vo.UserAlarm;

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
		return sqlSession.update("employee.updateUsers", employee);
	}

	public int updateUsersRole(Employee employee) {
		return sqlSession.update("employee.updateUsersRole", employee);
	}

	public int updateEmployeeDepartment(String departmentName, String newDepartmentName) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("departmentName", departmentName);
		parameters.put("newDepartmentName", newDepartmentName);
		return sqlSession.update("employee.updateEmployeeDepartment", parameters);
	}

	public int updateDept(String ordDepartmentFullPath, String departmentFullPath, String departmentParentPath, String departmentName) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("ordDepartmentFullPath", ordDepartmentFullPath);
		parameters.put("departmentFullPath", departmentFullPath);
		parameters.put("departmentParentPath", departmentParentPath);
		parameters.put("departmentName", departmentName);
		return sqlSession.insert("employee.updateDept", parameters);
	}

	public int updateDepartmentMove(Employee employee) {
		return sqlSession.update("employee.updateDepartmentMove", employee);
	}

	public String pwdCheck(String usersId) {
		return sqlSession.selectOne("employee.pwdCheck", usersId);
	}

	public String getUsersPw(String usersId) {
		return sqlSession.selectOne("employee.getUsersPw", usersId);
	}

	public int updateUserPwd(String usersId, String changePwd) {
		Map<String, String> parameters = new HashMap<String, String>();
		parameters.put("usersId", usersId);
		parameters.put("changePwd", changePwd);
		return sqlSession.update("employee.updateUserPwd", parameters);
	}

	public int delUsers(String employeeId) {
		return sqlSession.delete("employee.delUsers", employeeId);
	}

	public List<String> getEmployeeId() {
		return sqlSession.selectList("employee.getEmployeeId");
	}

	public List<String> getEmployeeName() {
		return sqlSession.selectList("employee.getEmployeeName");
	}

	public void lastLogin(String lastLogin, String usersId) {
		Map<String, String> parameters = new HashMap<String, String>();
		parameters.put("lastLogin", lastLogin);
		parameters.put("usersId", usersId);
		sqlSession.update("employee.lastLogin", parameters);
	}

	public String loginSession(String employeeId) {
		return sqlSession.selectOne("employee.loginSession", employeeId);
	}

	public String getUsersRole(String usersId) {
		return sqlSession.selectOne("employee.getUsersRole", usersId);
	}

	public List<Employee> getEmployeeAll() {
		return sqlSession.selectList("employee.getEmployeeAll");
	}

	public String getEmployeeDepartment(String employeeId) {
		return sqlSession.selectOne("employee.getEmployeeDepartment", employeeId);
	}

	public List<Employee> getDepartmentEmail(String departmentName) {
		return sqlSession.selectList("employee.getDepartmentEmail", departmentName);
	}

	public List<UserAlarm> getUserAlarm(String userAlarmEmployeeId) {
		return sqlSession.selectList("employee.getUserAlarm", userAlarmEmployeeId);
	}

	public void setUserAlarm(UserAlarm userAlarm) {
		sqlSession.insert("employee.setUserAlarm", userAlarm);
	}

	public void delUserAlarm(int keyeyNum) {
		sqlSession.delete("employee.delUserAlarm", keyeyNum);
	}

	public int updateUserAlarm(UserAlarm userAlarm) {
		return sqlSession.update("employee.updateUserAlarm", userAlarm);
	}

	public List<String> getQaEmployeeId() {
		return sqlSession.selectList("employee.getQaEmployeeId");
	}

	public List<Integer> getAlarmIndex(int issueKeyNum, String employeeId) {
		Map parameters = new HashMap();
		parameters.put("issueKeyNum", issueKeyNum);
		parameters.put("employeeId", employeeId);
		return sqlSession.selectList("employee.getAlarmIndex", parameters);
	}

	public void updateAlarmY(int issueKeyNum, String employeeId) {
		Map parameters = new HashMap();
		parameters.put("issueKeyNum", issueKeyNum);
		parameters.put("employeeId", employeeId);
		sqlSession.update("employee.updateAlarmY", parameters);
	}

	public void setLastTimeUpdate(String usersId) {
		sqlSession.update("employee.setLastTimeUpdate", usersId);
	}

	public String getLastTime(String usersId) {
		return sqlSession.selectOne("employee.getLastTime", usersId);
	}
}