package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.License5UidLog;

@Repository
public class License5UidLogDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<String> getSelectInput(String selectInput) {
		return sqlSession.selectList("license5UidLog.getSelectInput", selectInput);
	}

	public List<License5UidLog> getLicenseList(License5UidLog search) {
		return sqlSession.selectList("license5UidLog.getLicense5UidLog", search);
	}

	public int getLicenseListCount(License5UidLog search) {
		return sqlSession.selectOne("license5UidLog.getLicense5UidLogCount", search);
	}

	public void license5UidLogInsert(License5UidLog license5UidLog) {
		sqlSession.insert("license5UidLog.license5UidLogInsert", license5UidLog);
	}

}
