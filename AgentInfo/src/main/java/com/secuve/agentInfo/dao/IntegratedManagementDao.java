package com.secuve.agentInfo.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.IntegratedManagement;

@Repository
public class IntegratedManagementDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<IntegratedManagement> getIntegratedManagementList(IntegratedManagement search) {
		return sqlSession.selectList("integratedManagement.getIntegratedManagementList", search);
	}

	public int getIntegratedManagementListCount(IntegratedManagement search) {
		return sqlSession.selectOne("integratedManagement.getIntegratedManagementListCount", search);
	}

	public void setResultsReportMapping(IntegratedManagement integratedManagement) {
		sqlSession.insert("integratedManagement.setResultsReportMapping", integratedManagement);
	}

	public int delResultsReportMapping(IntegratedManagement integratedManagement) {
		return sqlSession.delete("integratedManagement.delResultsReportMapping", integratedManagement);
	}

	public IntegratedManagement getIntegratedManagementOne(IntegratedManagement integratedManagement) {
		return sqlSession.selectOne("integratedManagement.getIntegratedManagementOne", integratedManagement);
	}

	public int setProductVersionMapping(IntegratedManagement integratedManagement) {
		return sqlSession.insert("integratedManagement.setProductVersionMapping", integratedManagement);
		
	}

	public List<IntegratedManagement> getIntegratedManagementOneList(IntegratedManagement integratedManagement) {
		return sqlSession.selectList("integratedManagement.getIntegratedManagementOneList", integratedManagement);
	}

	public int delProductVersion(IntegratedManagement integratedManagement) {
		return sqlSession.delete("integratedManagement.delProductVersion", integratedManagement);
	}

	public int setIssueMapping(IntegratedManagement integratedManagement) {
		return sqlSession.insert("integratedManagement.setIssueMapping", integratedManagement);
	}

	public List<IntegratedManagement> getIntegratedManagementIssue(IntegratedManagement integratedManagement) {
		return sqlSession.selectList("integratedManagement.getIntegratedManagementIssue", integratedManagement);
	}

}
