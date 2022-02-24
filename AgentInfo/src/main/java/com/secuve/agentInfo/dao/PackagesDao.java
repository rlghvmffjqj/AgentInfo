package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.Packages;

@Repository
public class PackagesDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<Packages> getPackagesList(Packages search) {
		return sqlSession.selectList("packages.getPackages", search);
	}

	public int getPackagesListCount(Packages search) {
		return sqlSession.selectOne("packages.getPackagesCount", search);
	}

	public int delPackages(int packagesKeyNum) {
		return sqlSession.delete("packages.delPackages", packagesKeyNum);
	}

	public int insertPackages(Packages packages) {
		return sqlSession.insert("packages.insertPackages", packages);
	}

	public int getPackagesKeyNum() {
		return sqlSession.selectOne("packages.getPackagesKeyNum");
	}

	public Packages getPackagesOne(int packagesKeyNum) {
		return sqlSession.selectOne("packages.getPackagesOne", packagesKeyNum);
	}

	public int updatePackages(Packages packages) {
		return sqlSession.update("packages.updatePackages", packages);
	}

}
