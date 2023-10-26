package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.Category;
import com.secuve.agentInfo.vo.CategoryBusiness;
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

	public Packages getPackagesOne(int packagesKeyNum) {
		return sqlSession.selectOne("packages.getPackagesOne", packagesKeyNum);
	}

	public int updatePackages(Packages packages) {
		return sqlSession.update("packages.updatePackages", packages);
	}

	public List<Packages> getPackagesListAll(Packages packages) {
		return sqlSession.selectList("packages.getPackagesListAll", packages);
	}

	public void plusPackagesKeyNumOrigin(int packagesKeyNumOrigin) {
		sqlSession.update("packages.plusPackagesKeyNum", packagesKeyNumOrigin);
	}

	public List<Packages> getChartManagementServer(String managementServerYear) {
		return sqlSession.selectList("packages.getChartManagementServer", managementServerYear);
	}

	public List<Packages> getOsType(String osTypeYear) {
		return sqlSession.selectList("packages.getOsType", osTypeYear);
	}

	public Packages getChartRequestProductCategory(String requestProductCategoryYear) {
		return sqlSession.selectOne("packages.getChartRequestProductCategory", requestProductCategoryYear);
	}

	public Packages getAgentVer(String topAgentVer) {
		return sqlSession.selectOne("packages.getAgentVer", topAgentVer);
	}

	public String getTopAgentVer(String osType) {
		return sqlSession.selectOne("packages.getTopAgentVer", osType);
	}

	public List<Packages> getDeliveryData(String deliveryDataYear) {
		return sqlSession.selectList("packages.getDeliveryData", deliveryDataYear);
	}

	public List<Packages> getCustomerName(String customerNameYear) {
		return sqlSession.selectList("packages.getCustomerName", customerNameYear);
	}

	public int stateChange(int packagesKeyNum, String statusComment, String stateView) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("packagesKeyNum", packagesKeyNum);
		parameters.put("statusComment", statusComment);
		parameters.put("stateView", stateView);
		
		return sqlSession.update("packages.stateChange", parameters);
	}

	public List<Packages> getPackagesAll() {
		return sqlSession.selectList("packages.getPackagesAll");
	}

	public int getPackagesKeyNumOrigin() {
		return sqlSession.selectOne("packages.getPackagesKeyNumOrigin");
	}

	public void updateCategoryNameAll(String categoryName, String categoryValue, String categoryValueNew) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("categoryName", categoryName);
		parameters.put("categoryValue", categoryValue);
		parameters.put("categoryValueNew", categoryValueNew);
		
		sqlSession.update("packages.updateCategoryNameAll", parameters);
	}

	public void updateBussinessNameAll(String categoryCustomerName, String categoryBusinessName, String categoryBusinessNameNew) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("categoryCustomerName", categoryCustomerName);
		parameters.put("categoryBusinessName", categoryBusinessName);
		parameters.put("categoryBusinessNameNew", categoryBusinessNameNew);
		
		sqlSession.update("packages.updateBussinessNameAll", parameters);
		
	}

	public List<String> getCategoryCustomerNameList(Category category) {
		return sqlSession.selectList("packages.getCategoryCustomerNameList", category);
	}

	public List<String> getCategoryBusinessCustomerNameList(CategoryBusiness categoryBusiness) {
		return sqlSession.selectList("packages.getCategoryBusinessCustomerNameList", categoryBusiness);
	}
	
}