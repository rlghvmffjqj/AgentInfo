package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.LicenseUidLog;

@Repository
public class LicenseUidLogDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<String> getLicenseId() {
		return sqlSession.selectList("licenseUidLog.getLicenseId");
	}

	public List<LicenseUidLog> getLicenseUidLogList(LicenseUidLog search) {
		return sqlSession.selectList("licenseUidLog.getLicenseUidLog", search);
	}

	public int getLicenseUidLogListCount(LicenseUidLog search) {
		return sqlSession.selectOne("licenseUidLog.getLicenseUidLogCount", search);
	}

	public void insertLicenseUidLog(LicenseUidLog licenseUidLog) {
		sqlSession.insert("licenseUidLog.insertLicenseUidLog", licenseUidLog);		
		
	}

	public List<String> getSelectInput(String selectInput) {
		return sqlSession.selectList("licenseUidLog.getSelectInput", selectInput);
	}

	public String getLicenseIssueKey(int licenseUidLogKeyNum) {
		return sqlSession.selectOne("licenseUidLog.getLicenseIssueKey", licenseUidLogKeyNum);
	}

	public void saveUidLogLicenseKey(String licenseIssueKey, int licenseUidLogKeyNum) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("licenseIssueKey", licenseIssueKey);
		parameters.put("licenseUidLogKeyNum", licenseUidLogKeyNum);
		sqlSession.update("licenseUidLog.saveUidLogLicenseKey", parameters);
		
	}

	public void licensUidLogCancel(int licenseUidLogKeyNum) {
		sqlSession.delete("licenseUidLog.licensUidLogCancel", licenseUidLogKeyNum);
	}
}
