package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.CustomerUidLog;

@Repository
public class CustomerUidLogDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<CustomerUidLog> getCustomerUidLogList(CustomerUidLog search) {
		return sqlSession.selectList("customerUidLog.getCustomerUidLog", search);
	}

	public int getCustomerUidLogListCount(CustomerUidLog search) {
		return sqlSession.selectOne("customerUidLog.getCustomerUidLogCount", search);
	}

	public int customerUidLogKeyNum() {
		return sqlSession.selectOne("customerUidLog.customerUidLogKeyNum");
	}

	public void insertCustomerUidLog(CustomerUidLog customerUidLog) {
		sqlSession.insert("customerUidLog.insertCustomerUidLog", customerUidLog);		
	}

}
