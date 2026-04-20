package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.Selenium;

@Repository
public class SeleniumDao {
	@Autowired SqlSessionTemplate sqlSession;

	public int insertSelenium(Selenium selenium) {
		return sqlSession.insert("selenium.insertSelenium", selenium);
	}

	public int updateSelenium(Selenium selenium) {
		return sqlSession.insert("selenium.updateSelenium", selenium);
	}

	public Selenium getSeleniumOne(int seleniumKeyNum) {
		return sqlSession.selectOne("selenium.getSeleniumOne", seleniumKeyNum);
	}

	public List<Selenium> getSeleniumList(Selenium search) {
		return sqlSession.selectList("selenium.getSeleniumList", search);
	}

	public int getSeleniumListCount(Selenium search) {
		return sqlSession.selectOne("selenium.getSeleniumListCount", search);
	}

	public int delSelenium(int seleniumKeyNum) {
		return sqlSession.delete("selenium.delSelenium", seleniumKeyNum);
	}

	public void updateGroup(String ordSeleniumGroupFullPath, String seleniumGroupFullPath,
			String seleniumGroupParentPath, String seleniumGroupName) {
		// TODO Auto-generated method stub
		
	}

}