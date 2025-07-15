package com.secuve.agentInfo.dao;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.Compatibility;
import com.secuve.agentInfo.vo.MenuSetting;

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

	public List<Map<String, Object>> getProductVersionList(Map<String, String> paramMap) {
        return sqlSession.selectList("productVersion.getProductVersionList", searchFormat(paramMap));
    }

	public int getProductVersionListCount(Map<String, String> paramMap) {
		return sqlSession.selectOne("productVersion.getProductVersionListCount",searchFormat(paramMap));
	}
	
	public Map<String, Object> searchFormat(Map<String, String> paramMap) {
	    // 1. 제외할 키 목록
	    Set<String> excludeKeys = new HashSet<>(Arrays.asList(
	        "menuKeyNum", "menuTitle", "_search", "nd",
	        "rows", "page", "sidx", "sord", "productData", "menuItemSort"
	    ));

	    // 2. 검색 조건 추출
	    List<Map<String, Object>> conditions = new ArrayList<>();
	    for (Map.Entry<String, String> entry : paramMap.entrySet()) {
	        String key = entry.getKey();
	        String value = entry.getValue();

	        // 제외 키가 아니고, 값이 비어있지 않을 때만 추가
	        if (!excludeKeys.contains(key) && value != null && !value.trim().isEmpty()) {
	            Map<String, Object> condition = new HashMap<>();
	            condition.put("key", key);
	            condition.put("value", value.trim());
	            conditions.add(condition);
	        }
	    }

	    // 3. 결과 구성
	    Map<String, Object> params = new HashMap<>();
	    // 필수 파라미터 추가
	    for (String key : excludeKeys) {
	        params.put(key, paramMap.get(key));
	    }
	    params.put("conditions", conditions);

	    return params;
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

	public String getMenuItemSort(int menuKeyNum) {
		return sqlSession.selectOne("productVersion.getMenuItemSort",menuKeyNum);
	}

	public List<MenuSetting> getcompatibilityList(Compatibility search) {
		return sqlSession.selectList("productVersion.getcompatibilityList",search);
	}

	public int getcompatibilityListCount(Compatibility search) {
		return sqlSession.selectOne("productVersion.getcompatibilityListCount",search);
	}

	public List<String> getProductVersionTableList(String databaseName) {
		return sqlSession.selectList("productVersion.getProductVersionTableList", databaseName);
	}

}
