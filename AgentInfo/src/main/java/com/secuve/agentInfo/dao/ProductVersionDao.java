package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.MenuSetting;
import com.secuve.agentInfo.vo.ProductVersion;

@Repository
public class ProductVersionDao {
	@Autowired SqlSessionTemplate sqlSession;

	public int getProductVersionNoneExist(String mainTitle, String subTitle) {
		Map<String, String> parameters = new HashMap<String, String>();
		parameters.put("mainTitle", mainTitle);
		parameters.put("subTitle", subTitle);
			
		return sqlSession.selectOne("productVersion.getProductVersionNoneExist", parameters);
	}

	public void alterItem(MenuSetting menuSetting) {
		sqlSession.update("productVersion.alterItem", menuSetting);
	}

	public void createItem(MenuSetting menuSetting) {
		sqlSession.update("productVersion.createItem", menuSetting);
	}

	public void dropItem(MenuSetting menuSetting) {
		sqlSession.update("productVersion.dropItem", menuSetting);
	}

	public void alterDeleteItem(MenuSetting menuSetting) {
		sqlSession.update("productVersion.alterDeleteItem", menuSetting);
	}

	public void alterUpdateItem(MenuSetting menuSetting) {
		sqlSession.update("productVersion.alterUpdateItem", menuSetting);
		
	}

	public List<Map<String, Object>> getProductVersionList(ProductVersion search) {
		return sqlSession.selectList("productVersion.getProductVersionList",search);
	}

	public int getProductVersionListCount(ProductVersion search) {
		return sqlSession.selectOne("productVersion.getProductVersionListCount",search);
	}

	public int insertProductVersion(Map<String, String> paramMap) {
		Map<String, String> columnMap = new HashMap<>(paramMap);
		columnMap.remove("tableName");
		columnMap.remove("menuTitle");
		columnMap.remove("menuKeyNum");
		columnMap.remove("productVersionKeyNum");

		Map<String, Object> params = new HashMap<>();
		params.put("tableName", paramMap.get("tableName"));
		params.put("columnMap", columnMap);
		return sqlSession.insert("productVersion.insertProductVersion",params);
	}

	public int delProductVersion(Map<String, Object> paramMap) {
		return sqlSession.delete("productVersion.delProductVersion",paramMap);
	}

	public int updateProductVersion(Map<String, String> paramMap) {
		Map<String, String> columnMap = new HashMap<>(paramMap);
		columnMap.remove("menuTitle");
		columnMap.remove("menuKeyNum");
		columnMap.remove("productVersionKeyNum");

		Map<String, Object> params = new HashMap<>();
		params.put("menuTitle", paramMap.get("menuTitle"));
		params.put("menuKeyNum", paramMap.get("menuKeyNum"));
		params.put("productVersionKeyNum", paramMap.get("productVersionKeyNum"));
		params.put("columnMap", columnMap);
		return sqlSession.update("productVersion.updateProductVersion",params);
	}

}
