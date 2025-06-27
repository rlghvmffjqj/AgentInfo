package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductVersionDao {
	@Autowired SqlSessionTemplate sqlSession;

	public int getProductVersionNoneExist(String mainTitle, String subTitle) {
		Map<String, String> parameters = new HashMap<String, String>();
		parameters.put("mainTitle", mainTitle);
		parameters.put("subTitle", subTitle);
			
		return sqlSession.selectOne("productVersion.getProductVersionNoneExist", parameters);
	}
}
