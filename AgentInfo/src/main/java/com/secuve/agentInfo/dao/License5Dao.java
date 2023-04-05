package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	
	public String getRoute(String column, String employeeId) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("column", column);
		parameters.put("employeeId", employeeId);
		return sqlSession.selectOne("license5.getRoute", parameters);
	}

	public int issuedLicense(License5 license) {
		return sqlSession.insert("license5.issuedLicense", license);
	}
	
}
