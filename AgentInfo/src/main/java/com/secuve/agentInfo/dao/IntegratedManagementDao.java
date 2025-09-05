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

}
