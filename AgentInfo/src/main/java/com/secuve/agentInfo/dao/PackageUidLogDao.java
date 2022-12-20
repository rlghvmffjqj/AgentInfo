package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.PackageUidLog;

@Repository
public class PackageUidLogDao {

	@Autowired SqlSessionTemplate sqlSession;

	public List<PackageUidLog> getPackageUidLogList(PackageUidLog search) {
		return sqlSession.selectList("uidLog.getPackageUidLog", search);
	}

	public int getPackageUidLogListCount(PackageUidLog search) {
		return sqlSession.selectOne("uidLog.getPackageUidLogCount", search);
	}
	
	public void insertPackageUidLog(PackageUidLog uidLog) {
		sqlSession.insert("uidLog.insertPackageUidLog", uidLog);		
	}
}