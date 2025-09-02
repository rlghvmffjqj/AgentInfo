package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.RGRIFFIN;

@Repository
public class RGRIFFINDao {
	@Autowired SqlSessionTemplate sqlSession;
	
	public int licenseInsert(RGRIFFIN license) {
		return sqlSession.insert("rGRIFFIN.licenseInsert", license);
	}

	public List<RGRIFFIN> getLicenseList(RGRIFFIN search) {
		return sqlSession.selectList("rGRIFFIN.getLicenseList", search);
	}

	public int getLicenseListCount(RGRIFFIN search) {
		return sqlSession.selectOne("rGRIFFIN.getLicenseListCount", search);
	}

	public int delLicense(int rGRIFFINKeyNum) {
		return sqlSession.delete("rGRIFFIN.delLicense", rGRIFFINKeyNum);
	}

	public RGRIFFIN getLicenseOne(int rGRIFFINKeyNum) {
		return sqlSession.selectOne("rGRIFFIN.getLicenseOne", rGRIFFINKeyNum);
	}

	public int updateLicense(RGRIFFIN license) {
		return sqlSession.update("rGRIFFIN.updateLicense", license);
	}

	public List listAll(RGRIFFIN license) {
		return sqlSession.selectList("rGRIFFIN.listAll", license);
	}

}
