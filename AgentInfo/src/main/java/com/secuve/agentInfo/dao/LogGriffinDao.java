package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	public List<String> existenceCheckInsert(LogGriffin license) {
		return sqlSession.selectList("logGriffin.existenceCheckInsert", license);
	}

	public int serialNumberCheck(String serialNumber) {
		return sqlSession.selectOne("logGriffin.serialNumberCheck", serialNumber);
	}
	
	public String getRoute(String column) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("column", column);
		return sqlSession.selectOne("logGriffin.getRoute", parameters);
	}

	public int issuedLicense(LogGriffin license) {
		return sqlSession.insert("logGriffin.issuedLicense", license);
	}

	public int updateLicense(LogGriffin license) {
		return sqlSession.update("logGriffin.updateLicense", license);
	}

	public List<String> existenceCheckUpdate(LogGriffin license) {
		return sqlSession.selectList("logGriffin.existenceCheckUpdate", license);
	}

	public int delLicense(int logGriffinKeyNum) {
		return sqlSession.delete("logGriffin.delLicense", logGriffinKeyNum);
	}

	public List getLicenseListAll(LogGriffin license) {
		return sqlSession.selectList("logGriffin.getLicenseListAll", license);
	}

}
