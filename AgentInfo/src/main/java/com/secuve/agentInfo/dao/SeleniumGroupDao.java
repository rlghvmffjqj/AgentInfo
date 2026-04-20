package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.SeleniumGroup;

@Repository
public class SeleniumGroupDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<SeleniumGroup> getSeleniumGroupList(String parentPath) {
		return sqlSession.selectList("seleniumGroup.getSeleniumGroupList", parentPath);
	}

	public int insertSeleniumGroup(SeleniumGroup seleniumGroup) {
		return sqlSession.insert("seleniumGroup.insertSeleniumGroup", seleniumGroup);
	}

	public SeleniumGroup getSeleniumGroupFullPath(String seleniumGroupFullPath) {
		return sqlSession.selectOne("seleniumGroup.getSeleniumGroupFullPath",seleniumGroupFullPath);
	}

	public List<SeleniumGroup> getSeleniumGroupParentPath(String seleniumGroupFullPath) {
		return sqlSession.selectList("seleniumGroup.getSeleniumGroupParentPath",seleniumGroupFullPath);
	}

	public int deleteSeleniumGroup(SeleniumGroup seleniumGroup) {
		return sqlSession.delete("seleniumGroup.deleteSeleniumGroup",seleniumGroup);
	}

	public List<SeleniumGroup> getSeleniumGroupFullPathList(String seleniumGroupFullPath) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("seleniumGroupFullPath", seleniumGroupFullPath);
		parameters.put("seleniumGroupParentPath", seleniumGroupFullPath + "/%");
		return sqlSession.selectList("seleniumGroup.getSeleniumGroupFullPathList", parameters);
	}

	public int updateGroup(String ordSeleniumGroupFullPath, String seleniumGroupFullPath, String seleniumGroupParentPath, String seleniumGroupName) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("ordSeleniumGroupFullPath", ordSeleniumGroupFullPath);
		parameters.put("seleniumGroupFullPath", seleniumGroupFullPath);
		parameters.put("seleniumGroupParentPath", seleniumGroupParentPath);
		parameters.put("seleniumGroupName", seleniumGroupName);
		return sqlSession.insert("seleniumGroup.updateGroup", parameters);
	}
}
