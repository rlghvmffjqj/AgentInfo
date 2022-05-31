package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CustomerBusinessMappingDao {
	@Autowired SqlSessionTemplate sqlSession;
	
	public void insertCustomerBusiness(String customerName, String businessName) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("customerName", customerName);
		parameters.put("businessName", businessName);
		sqlSession.update("customerBusinessMapping.insertCustomerBusiness", parameters);
	}

	public int getBusinessCount(String customerName, String businessName) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("customerName", customerName);
		parameters.put("businessName", businessName);
		return sqlSession.selectOne("customerBusinessMapping.getBusinessCount", parameters);
	}
}