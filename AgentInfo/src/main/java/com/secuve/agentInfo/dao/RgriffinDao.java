package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.Rgriffin;

@Repository
public class RgriffinDao {
	@Autowired SqlSessionTemplate sqlSession;
	
	public int licenseInsert(Rgriffin license) {
		return sqlSession.insert("rgriffin.licenseInsert", license);
	}

	public List<Rgriffin> getLicenseList(Rgriffin search) {
		return sqlSession.selectList("rgriffin.getLicenseList", search);
	}

	public int getLicenseListCount(Rgriffin search) {
		return sqlSession.selectOne("rgriffin.getLicenseListCount", search);
	}

	public int delLicense(int rgriffinKeyNum) {
		return sqlSession.delete("rgriffin.delLicense", rgriffinKeyNum);
	}

	public Rgriffin getLicenseOne(int rgriffinKeyNum) {
		return sqlSession.selectOne("rgriffin.getLicenseOne", rgriffinKeyNum);
	}

	public int updateLicense(Rgriffin license) {
		return sqlSession.update("rgriffin.updateLicense", license);
	}

	public List listAll(Rgriffin license) {
		return sqlSession.selectList("rgriffin.listAll", license);
	}

}
