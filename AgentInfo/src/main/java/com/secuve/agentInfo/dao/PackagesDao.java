package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.Packages;

@Repository
public class PackagesDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<Packages> getPackagesList(Packages search) {
		return sqlSession.selectList("packages.getPackages", search);
	}

	public int getPackagesListCount(Packages search) {
		return sqlSession.selectOne("packages.getPackagesCount", search);
	}

	public int delPackages(int packagesKeyNum) {
		return sqlSession.delete("packages.delPackages", packagesKeyNum);
	}

	public int insertPackages(Packages packages) {
		return sqlSession.insert("packages.insertPackages", packages);
	}

	public int getPackagesKeyNum() {
		return sqlSession.selectOne("packages.getPackagesKeyNum");
	}

	public Packages getPackagesOne(int packagesKeyNum) {
		return sqlSession.selectOne("packages.getPackagesOne", packagesKeyNum);
	}

	public int updatePackages(Packages packages) {
		return sqlSession.update("packages.updatePackages", packages);
	}

	public List<Packages> getPackagesListAll(Packages packages) {
		return sqlSession.selectList("packages.getPackagesListAll", packages);
	}

	public void plusPackagesKeyNum(int packagesKeyNum) {
		sqlSession.update("packages.plusPackagesKeyNum", packagesKeyNum);
	}

	public List<Packages> getChartManagementServer() {
		return sqlSession.selectList("packages.getChartManagementServer");
	}

	public List<Packages> getOsType() {
		return sqlSession.selectList("packages.getOsType");
	}

	public Packages getChartRequestProductCategory() {
		return sqlSession.selectOne("packages.getChartRequestProductCategory");
	}

	public Packages getAgentVer(String topAgentVer) {
		return sqlSession.selectOne("packages.getAgentVer", topAgentVer);
	}

	public String getTopAgentVer(String osType) {
		return sqlSession.selectOne("packages.getTopAgentVer", osType);
	}

	public List<Packages> getDeliveryData() {
		return sqlSession.selectList("packages.getDeliveryData");
	}

	public List<Packages> getCustomerName() {
		return sqlSession.selectList("packages.getCustomerName");
	}

	public int stateChange(int packagesKeyNum, String statusComment, String state) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("packagesKeyNum", packagesKeyNum);
		parameters.put("statusComment", statusComment);
		parameters.put("state", state);
		
		return sqlSession.update("packages.stateChange", parameters);
	}

}
