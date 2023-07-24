package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.CustomerConsolidation;

@Repository
public class CustomerConsolidationDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<CustomerConsolidation> getCustomerConsolidationList(CustomerConsolidation search) {
		return sqlSession.selectList("customerConsolidation.getCustomerConsolidation", search);
	}

	public int getCustomerConsolidationListCount(CustomerConsolidation search) {
		return sqlSession.selectOne("customerConsolidation.getCustomerConsolidationListCount", search);
	}

	public int insertSales(CustomerConsolidation customerConsolidation) {
		return sqlSession.insert("customerConsolidation.insertSales", customerConsolidation);
	}

	public int getDuplicationCustomerBusiness(CustomerConsolidation customerConsolidation) {
		return sqlSession.selectOne("customerConsolidation.getDuplicationCustomerBusiness", customerConsolidation);
	}

	public int delCustomerConsolidation(CustomerConsolidation customerConsolidation) {
		return sqlSession.delete("customerConsolidation.delCustomerConsolidation", customerConsolidation);
	}

	public CustomerConsolidation getCustomerConsolidationOne(int customerConsolidationKeyNum) {
		return sqlSession.selectOne("customerConsolidation.getCustomerConsolidationOne", customerConsolidationKeyNum);
	}

	public int updateSales(CustomerConsolidation customerConsolidation) {
		return sqlSession.update("customerConsolidation.updateSales", customerConsolidation);
	}

	public int getDuplicationCustomerBusinessLocation(CustomerConsolidation customerConsolidation) {
		return sqlSession.selectOne("customerConsolidation.getDuplicationCustomerBusinessLocation", customerConsolidation);
	}

	public int insertSecurityInfo(CustomerConsolidation customerConsolidation) {
		return sqlSession.insert("customerConsolidation.insertSecurityInfo", customerConsolidation);
	}

	public int updateSecurityInfo(CustomerConsolidation customerConsolidation) {
		return sqlSession.update("customerConsolidation.updateSecurityInfo", customerConsolidation);
	}

	public List<CustomerConsolidation> getEngineerList(CustomerConsolidation search) {
		return sqlSession.selectList("customerConsolidation.getEngineerList", search);
	}

	public int getEngineerCount(CustomerConsolidation search) {
		return sqlSession.selectOne("customerConsolidation.getEngineerCount", search);
	}

	public void updateSalesSecurity(CustomerConsolidation customerConsolidation, CustomerConsolidation customerConsolidationOne) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("customerConsolidationCustomerOrd", customerConsolidationOne.getCustomerConsolidationCustomer());
		parameters.put("customerConsolidationBusinessOrd", customerConsolidationOne.getCustomerConsolidationBusiness());
		parameters.put("customerConsolidationCustomerNew", customerConsolidation.getCustomerConsolidationCustomerView());
		parameters.put("customerConsolidationBusinessNew", customerConsolidation.getCustomerConsolidationBusinessView());
		sqlSession.update("customerConsolidation.updateSalesSecurity", parameters);
	}

}
