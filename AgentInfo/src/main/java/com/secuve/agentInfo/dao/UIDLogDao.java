package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.UIDLog;

@Repository
public class UIDLogDao {

	@Autowired SqlSessionTemplate sqlSession;

	public List<UIDLog> getUIDLogList(UIDLog search) {
		return sqlSession.selectList("uidLog.getUIDLog", search);
	}

	public int getUIDLogListCount(UIDLog search) {
		return sqlSession.selectOne("uidLog.getUIDLogCount", search);
	}
	
	public int uidLogKeyNum() {
		return sqlSession.selectOne("uidLog.uidLogKeyNum");
	}
	
	public void insertUIDLog(UIDLog uidLog) {
		sqlSession.insert("uidLog.insertUIDLog", uidLog);		
	}
}
