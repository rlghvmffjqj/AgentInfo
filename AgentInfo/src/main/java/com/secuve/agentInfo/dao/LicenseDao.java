package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.License;
import com.secuve.agentInfo.vo.LicenseSetting;

@Repository
public class LicenseDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<License> getLicenseList(License search) {
		return sqlSession.selectList("license.getLicenseList", search);
	}

	public int getLicenseListCount(License search) {
		return sqlSession.selectOne("license.getLicenseListCount", search);
	}

	public List<String> getSelectInput(String selectInput) {
		return sqlSession.selectList("license.getSelectInput", selectInput);
	}

	public String getLicenseIssueKey(int licenseKeyNum) {
		return sqlSession.selectOne("license.getLicenseIssueKey", licenseKeyNum);
	}

	public int getLicenseKeyNum() {
		return sqlSession.selectOne("license.getLicenseKeyNum");
	}

	public int issuedLicense(License license) {
		return sqlSession.insert("license.issuedLicense", license);
	}

	public License getLicenseOne(int licenseKeyNum) {
		return sqlSession.selectOne("license.getLicenseOne", licenseKeyNum);
	}

	public int delLicense(int licenseKeyNum) {
		return sqlSession.delete("license.delLicense", licenseKeyNum);
	}

	public int saveLicenseKey(String licenseIssueKey, int licenseKeyNum) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("licenseIssueKey", licenseIssueKey);
		parameters.put("licenseKeyNum", licenseKeyNum);
		return sqlSession.update("license.saveLicenseKey", parameters);
	}

	public void licensCancel(int licenseKeyNum) {
		sqlSession.delete("license.delLicense", licenseKeyNum);
	}

	public LicenseSetting getlicenseSetting() {
		return sqlSession.selectOne("license.getlicenseSetting");
	}

	public int RouteChange(LicenseSetting licenseSetting) {
		return sqlSession.update("license.RouteChange", licenseSetting);
	}

	public String getRoute(String column) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("column", column);
		return sqlSession.selectOne("license.getRoute", parameters);
	}

	public void plusLicenseKeyNumOrigin(int licenseKeyNumOrigin) {
		sqlSession.update("license.plusLicenseKeyNumOrigin", licenseKeyNumOrigin);
	}

	public int getLicenseKeyNumOrigin() {
		return sqlSession.selectOne("license.getLicenseKeyNumOrigin");
	}

	public int RouteInsert(LicenseSetting licenseSetting) {
		return sqlSession.update("license.RouteInsert", licenseSetting);
	}

	public int getSettingCount() {
		return sqlSession.selectOne("license.getSettingCount");
	}

}
