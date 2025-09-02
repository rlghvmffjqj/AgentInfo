package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.SecuveOTP;

@Repository
public class SecuveOTPDao {
	@Autowired SqlSessionTemplate sqlSession;
	
	public int licenseInsert(SecuveOTP license) {
		return sqlSession.insert("secuveOTP.licenseInsert", license);
	}

	public List<SecuveOTP> getLicenseList(SecuveOTP search) {
		return sqlSession.selectList("secuveOTP.getLicenseList", search);
	}

	public int getLicenseListCount(SecuveOTP search) {
		return sqlSession.selectOne("secuveOTP.getLicenseListCount", search);
	}

	public int delLicense(int secuveOTPKeyNum) {
		return sqlSession.delete("secuveOTP.delLicense", secuveOTPKeyNum);
	}

	public SecuveOTP getLicenseOne(int secuveOTPKeyNum) {
		return sqlSession.selectOne("secuveOTP.getLicenseOne", secuveOTPKeyNum);
	}

	public int updateLicense(SecuveOTP license) {
		return sqlSession.update("secuveOTP.updateLicense", license);
	}

	public List listAll(SecuveOTP license) {
		return sqlSession.selectList("secuveOTP.listAll", license);
	}

}
