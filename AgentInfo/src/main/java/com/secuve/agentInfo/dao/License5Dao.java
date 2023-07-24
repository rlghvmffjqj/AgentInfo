package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.CustomerConsolidation;
import com.secuve.agentInfo.vo.License5;

@Repository
public class License5Dao {
	@Autowired SqlSessionTemplate sqlSession;
	
	public List<License5> getLicenseList(License5 search) {
		return sqlSession.selectList("license5.getLicenseList", search);
	}
	
	public int getLicenseListCount(License5 search) {
		return sqlSession.selectOne("license5.getLicenseListCount", search);
	}
	
	public List<String> getSelectInput(String selectInput) {
		return sqlSession.selectList("license5.getSelectInput", selectInput);
	}

	public License5 getLicenseOne(Integer licenseKeyNum) {
		return sqlSession.selectOne("license5.getLicenseOne", licenseKeyNum);
	}
	
	public String getRoute(String column) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("column", column);
		return sqlSession.selectOne("license5.getRoute", parameters);
	}

	public int issuedLicense(License5 license) {
		return sqlSession.insert("license5.issuedLicense", license);
	}

	public int delLicense(int licenseKeyNum) {
		return sqlSession.delete("license5.delLicense", licenseKeyNum);
	}

	public int updateLicense(License5 license) {
		return sqlSession.update("license5.updateLicense", license);
	}

	public List<String> existenceCheckInsert(License5 license) {
		return sqlSession.selectList("license5.existenceCheckInsert", license);
	}

	public List<String> existenceCheckUpdate(License5 license) {
		return sqlSession.selectList("license5.existenceCheckUpdate", license);
	}

	public int serialNumberCheck(String serialNumber) {
		return sqlSession.selectOne("license5.serialNumberCheck", serialNumber);
	}

	public List<License5> getCustomerConsolidationList(CustomerConsolidation customerConsolidation) {
		return sqlSession.selectList("license5.getCustomerConsolidationList", customerConsolidation);
	}

	public void updateSalesLicense(CustomerConsolidation customerConsolidation,	CustomerConsolidation customerConsolidationOne) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("customerConsolidationCustomerOrd", customerConsolidationOne.getCustomerConsolidationCustomer());
		parameters.put("customerConsolidationBusinessOrd", customerConsolidationOne.getCustomerConsolidationBusiness());
		parameters.put("customerConsolidationCustomerNew", customerConsolidation.getCustomerConsolidationCustomerView());
		parameters.put("customerConsolidationBusinessNew", customerConsolidation.getCustomerConsolidationBusinessView());
		sqlSession.update("license5.updateSalesLicense", parameters);
	}

}
