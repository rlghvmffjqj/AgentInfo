package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.EmployeeUidLog;

@Repository
public class EmployeeUidLogDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<String> getEmployeeId() {
		return sqlSession.selectList("employeeUidLog.getEmployeeId");
	}

	public List<EmployeeUidLog> getEmployeeUidLogList(EmployeeUidLog search) {
		return sqlSession.selectList("employeeUidLog.getEmployeeUidLog", search);
	}

	public int getEmployeeUidLogListCount(EmployeeUidLog search) {
		return sqlSession.selectOne("employeeUidLog.getEmployeeUidLogCount", search);
	}

	public int employeeUidLogKeyNum() {
		return sqlSession.selectOne("employeeUidLog.employeeUidLogKeyNum");
	}

	public void insertEmployeeUidLog(EmployeeUidLog employeeUidLog) {
		sqlSession.insert("employeeUidLog.insertEmployeeUidLog", employeeUidLog);		
		
	}
	
}
