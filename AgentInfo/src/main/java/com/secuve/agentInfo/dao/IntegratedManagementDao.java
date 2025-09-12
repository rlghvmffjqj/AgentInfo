package com.secuve.agentInfo.dao;

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

	public IntegratedManagement getIntegratedManagementOne(int packagesKeyNum) {
		return sqlSession.selectOne("integratedManagement.getIntegratedManagementOne", packagesKeyNum);
	}

}
