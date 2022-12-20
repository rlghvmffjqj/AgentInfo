package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
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

	public CustomerInfo getCustomerInfoOne(int customerInfoKeyNum) {
		return sqlSession.selectOne("customerInfo.getCustomerInfoOne", customerInfoKeyNum);
	}

	public void updateTOSMS(String customerName, String businessName, String networkClassification, String packageName, String osType) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("customerName", customerName);
		parameters.put("businessName", businessName);
		parameters.put("networkClassification", networkClassification);
		parameters.put("packageName", packageName);
		parameters.put("osType", osType);
		sqlSession.update("customerInfo.updateTOSMS", parameters);
	}

	public void updateTOSRF(String customerName, String businessName, String networkClassification,	String packageName, String osType) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("customerName", customerName);
		parameters.put("businessName", businessName);
		parameters.put("networkClassification", networkClassification);
		parameters.put("packageName", packageName);
		parameters.put("osType", osType);
		sqlSession.update("customerInfo.updateTOSRF", parameters);
	}

	public void updatePORTAL(String customerName, String businessName, String networkClassification, String packageName, String osType) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("customerName", customerName);
		parameters.put("businessName", businessName);
		parameters.put("networkClassification", networkClassification);
		parameters.put("packageName", packageName);
		parameters.put("osType", osType);
		sqlSession.update("customerInfo.updatePORTAL", parameters);
	}

	public void updateLogServer(String customerName, String businessName, String networkClassification,	String packageName, String osType) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("customerName", customerName);
		parameters.put("businessName", businessName);
		parameters.put("networkClassification", networkClassification);
		parameters.put("packageName", packageName);
		parameters.put("osType", osType);
		sqlSession.update("customerInfo.updateLogServer", parameters);
	}

	public void updateScvEA(String customerName, String businessName, String networkClassification,	String packageName, String osType) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("customerName", customerName);
		parameters.put("businessName", businessName);
		parameters.put("networkClassification", networkClassification);
		parameters.put("packageName", packageName);
		parameters.put("osType", osType);
		sqlSession.update("customerInfo.updateScvEA", parameters);
	}

	public void updateScvCA(String customerName, String businessName, String networkClassification,	String packageName, String osType) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("customerName", customerName);
		parameters.put("businessName", businessName);
		parameters.put("networkClassification", networkClassification);
		parameters.put("packageName", packageName);
		parameters.put("osType", osType);
		sqlSession.update("customerInfo.updateScvCA", parameters);
	}

	public void updateAuthclient(String customerName, String businessName, String networkClassification, String packageName, String osType) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("customerName", customerName);
		parameters.put("businessName", businessName);
		parameters.put("networkClassification", networkClassification);
		parameters.put("packageName", packageName);
		parameters.put("osType", osType);
		sqlSession.update("customerInfo.updateAuthclient", parameters);
	}

	public void updateProductCheck(String customerName, String businessName, String networkClassification ,String productCheck) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("customerName", customerName);
		parameters.put("businessName", businessName);
		parameters.put("networkClassification", networkClassification);
		parameters.put("productCheck", productCheck);
		sqlSession.update("customerInfo.updateProductCheck", parameters);
	}

	public List<CustomerInfo> getCustomerInfoList(String customerName) {
		return sqlSession.selectList("customerInfo.getCustomerInfoList", customerName);
	}

	public int getCustomerInfoCount(String customerName, String businessName, String networkClassification) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("customerName", customerName);
		parameters.put("businessName", businessName);
		parameters.put("networkClassification", networkClassification);
		return sqlSession.selectOne("customerInfo.getCustomerInfoCount", parameters);
	}

	public int getCustomerInfoDivision(int customerInfoKeyNum, String customerName, String businessName, String networkClassification) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("customerInfoKeyNum", customerInfoKeyNum);
		parameters.put("customerName", customerName);
		parameters.put("businessName", businessName);
		parameters.put("networkClassification", networkClassification);
		return sqlSession.selectOne("customerInfo.getCustomerInfoDivision", parameters);
	}

	public int updateCustomerInfo(CustomerInfo customerInfo) {
		return sqlSession.update("customerInfo.updateCustomerInfo", customerInfo);
	}

	public CustomerInfo getCustomerInfoMapping(String customerName, String businessName, String networkClassification) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("customerName", customerName);
		parameters.put("businessName", businessName);
		parameters.put("networkClassification", networkClassification);
		return sqlSession.selectOne("customerInfo.getCustomerInfoMapping", parameters);
	}

	public int deleteCustomerInfo(int customerInfoKeyNum) {
		return sqlSession.delete("customerInfo.deleteCustomerInfo", customerInfoKeyNum);
	}

}
