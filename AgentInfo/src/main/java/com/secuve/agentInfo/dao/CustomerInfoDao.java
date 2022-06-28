package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.CustomerInfo;

@Repository
public class CustomerInfoDao {
	@Autowired SqlSessionTemplate sqlSession;

	public int insertCustomerInfo(CustomerInfo customerInfo) {
		return sqlSession.insert("customerInfo.insertCustomerInfo", customerInfo);
	}

	public CustomerInfo getCustomerInfoOne(String customerName, String businessName) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("customerName", customerName);
		parameters.put("businessName", businessName);
		return sqlSession.selectOne("customerInfo.getCustomerInfoOne", parameters);
	}

}
