package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.Category;
import com.secuve.agentInfo.vo.CategoryBusiness;
import com.secuve.agentInfo.vo.PackagesInternational;

@Repository
public class PackagesInternationalDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<PackagesInternational> getPackagesInternationalList(PackagesInternational search) {
		return sqlSession.selectList("packagesInternational.getPackagesInternational", search);
	}

	public int getPackagesInternationalListCount(PackagesInternational search) {
		return sqlSession.selectOne("packagesInternational.getPackagesInternationalCount", search);
	}

	public int delPackagesInternational(int packagesInternationalKeyNum) {
		return sqlSession.delete("packagesInternational.delPackagesInternational", packagesInternationalKeyNum);
	}

	public int insertPackagesInternational(PackagesInternational packagesInternational) {
		return sqlSession.insert("packagesInternational.insertPackagesInternational", packagesInternational);
	}

	public PackagesInternational getPackagesInternationalOne(int packagesInternationalKeyNum) {
		return sqlSession.selectOne("packagesInternational.getPackagesInternationalOne", packagesInternationalKeyNum);
	}

	public int updatePackagesInternational(PackagesInternational packagesInternational) {
		return sqlSession.update("packagesInternational.updatePackagesInternational", packagesInternational);
	}

	public List<PackagesInternational> getPackagesInternationalListAll(PackagesInternational packagesInternational) {
		return sqlSession.selectList("packagesInternational.getPackagesInternationalListAll", packagesInternational);
	}

	public void plusPackagesInternationalKeyNumOrigin(int packagesInternationalKeyNumOrigin) {
		sqlSession.update("packagesInternational.plusPackagesInternationalKeyNum", packagesInternationalKeyNumOrigin);
	}

	public List<PackagesInternational> getChartManagementServer(String managementServerYear) {
		return sqlSession.selectList("packagesInternational.getChartManagementServer", managementServerYear);
	}

	public List<PackagesInternational> getOsType(String osTypeYear) {
		return sqlSession.selectList("packagesInternational.getOsType", osTypeYear);
	}

	public PackagesInternational getChartRequestProductCategory(String requestProductCategoryYear) {
		return sqlSession.selectOne("packagesInternational.getChartRequestProductCategory", requestProductCategoryYear);
	}

	public PackagesInternational getAgentVer(String topAgentVer) {
		return sqlSession.selectOne("packagesInternational.getAgentVer", topAgentVer);
	}

	public String getTopAgentVer(String osType) {
		return sqlSession.selectOne("packagesInternational.getTopAgentVer", osType);
	}

	public List<PackagesInternational> getDeliveryData(String deliveryDataYear) {
		return sqlSession.selectList("packagesInternational.getDeliveryData", deliveryDataYear);
	}
	
	public List<PackagesInternational> getDeliveryAvgData(int progressYear) {
		return sqlSession.selectList("packagesInternational.getDeliveryAvgData", progressYear);
	}

	public List<PackagesInternational> getCustomerName(String customerNameYear) {
		return sqlSession.selectList("packagesInternational.getCustomerName", customerNameYear);
	}

	public int stateChange(int packagesInternationalKeyNum, String statusComment, String stateView) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("packagesInternationalKeyNum", packagesInternationalKeyNum);
		parameters.put("statusComment", statusComment);
		parameters.put("stateView", stateView);
		
		return sqlSession.update("packagesInternational.stateChange", parameters);
	}

	public List<PackagesInternational> getPackagesInternationalAll() {
		return sqlSession.selectList("packagesInternational.getPackagesInternationalAll");
	}

	public int getPackagesInternationalKeyNumOrigin() {
		return sqlSession.selectOne("packagesInternational.getPackagesInternationalKeyNumOrigin");
	}

	public void updateCategoryNameAll(String categoryName, String categoryValue, String categoryValueNew) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("categoryName", categoryName);
		parameters.put("categoryValue", categoryValue);
		parameters.put("categoryValueNew", categoryValueNew);
		
		sqlSession.update("packagesInternational.updateCategoryNameAll", parameters);
	}

	public void updateBussinessNameAll(String categoryCustomerName, String categoryBusinessName, String categoryBusinessNameNew) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("categoryCustomerName", categoryCustomerName);
		parameters.put("categoryBusinessName", categoryBusinessName);
		parameters.put("categoryBusinessNameNew", categoryBusinessNameNew);
		
		sqlSession.update("packagesInternational.updateBussinessNameAll", parameters);
		
	}

	public List<String> getCategoryCustomerNameList(Category category) {
		return sqlSession.selectList("packagesInternational.getCategoryCustomerNameList", category);
	}

	public List<String> getCategoryBusinessCustomerNameList(CategoryBusiness categoryBusiness) {
		return sqlSession.selectList("packagesInternational.getCategoryBusinessCustomerNameList", categoryBusiness);
	}
	
}