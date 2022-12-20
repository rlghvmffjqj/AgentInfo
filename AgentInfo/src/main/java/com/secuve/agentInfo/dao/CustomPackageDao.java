package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.CustomPackage;

@Repository
public class CustomPackageDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<CustomPackage> getCustomPackage(CustomPackage search) {
		return sqlSession.selectList("customPackage.getCustomPackage", search);
	}

	public int getCustomPackageCount(CustomPackage search) {
		return sqlSession.selectOne("customPackage.getCustomPackageCount", search);
	}

	public int insertCustomPackage(CustomPackage customPackage) {
		return sqlSession.insert("customPackage.insertCustomPackage", customPackage);
	}

	public int updateCustomPackage(CustomPackage customPackage) {
		return sqlSession.update("customPackage.updateCustomPackage", customPackage);
	}

	public int deleteCustomPackage(int customPackageKeyNum) {
		return sqlSession.delete("customPackage.deleteCustomPackage", customPackageKeyNum);
	}

	public CustomPackage getCustomPackageOne(int customPackageKeyNum) {
		return sqlSession.selectOne("customPackage.getCustomPackageOne", customPackageKeyNum);
	}

	public String BatchDownload(int customPackageKeyNum) {
		return sqlSession.selectOne("customPackage.batchDownload", customPackageKeyNum);
	}
}