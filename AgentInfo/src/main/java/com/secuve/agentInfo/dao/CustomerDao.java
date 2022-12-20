package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.Customer;

@Repository
public class CustomerDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<Customer> getCustomerList(Customer search) {
		return sqlSession.selectList("customer.getCustomer", search);
	}

	public int getCustomerListCount(Customer search) {
		return sqlSession.selectOne("customer.getCustomerCount", search);
	}

	public int insertCustomer(Customer customer) {
		return sqlSession.insert("customer.insertCustomer", customer);
	}

	public int delCustomer(int customerKeyNum) {
		return sqlSession.delete("customer.delCustomer", customerKeyNum);
	}

	public Customer getCustomerOne(int customerKeyNum) {
		return sqlSession.selectOne("customer.getCustomerOne", customerKeyNum);
	}

	public int updateCustomer(Customer customer) {
		return sqlSession.update("customer.updateCustomer", customer);
	}
}