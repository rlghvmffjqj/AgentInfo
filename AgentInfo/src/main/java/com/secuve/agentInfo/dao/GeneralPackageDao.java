package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.GeneralPackage;

@Repository
public class GeneralPackageDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<GeneralPackage> getGeneralPackage(GeneralPackage search) {
		return sqlSession.selectList("generalPackage.getGeneralPackage", search);
	}

	public int getGeneralPackageCount(GeneralPackage search) {
		return sqlSession.selectOne("generalPackage.getGeneralPackageCount", search);
	}

	public int getGeneralPackageKeyNum() {
		return sqlSession.selectOne("generalPackage.getGeneralPackageKeyNum");
	}

	public int insertGeneralPackage(GeneralPackage generalPackage) {
		return sqlSession.insert("generalPackage.insertGeneralPackage", generalPackage);
		
	}

	public int deleteGeneralPackage(int generalPackageKeyNum) {
		return sqlSession.delete("generalPackage.deleteGeneralPackage", generalPackageKeyNum);
	}

	public GeneralPackage getGeneralPackageOne(int generalPackageKeyNum) {
		return sqlSession.selectOne("generalPackage.getGeneralPackageOne", generalPackageKeyNum);
	}

	public int updateGeneralPackage(GeneralPackage generalPackage) {
		return sqlSession.update("generalPackage.updateGeneralPackage", generalPackage);
	}
}
