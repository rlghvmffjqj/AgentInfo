package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.LogGriffin;

@Repository
public class LogGriffinDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<String> getSelectInput(String selectInput) {
		return sqlSession.selectList("logGriffin.getSelectInput", selectInput);
	}

	public LogGriffin getLicenseOne(Integer logGriffinKeyNum) {
		return sqlSession.selectOne("logGriffin.getLicenseOne", logGriffinKeyNum);
	}

	public List<LogGriffin> getLicenseList(LogGriffin search) {
		return sqlSession.selectList("logGriffin.getLicenseList", search);
	}

	public int getLicenseListCount(LogGriffin search) {
		return sqlSession.selectOne("logGriffin.getLicenseListCount", search);
	}

}
