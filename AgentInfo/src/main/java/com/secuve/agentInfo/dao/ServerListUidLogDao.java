package com.secuve.agentInfo.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ServerListUidLogDao {
	@Autowired SqlSessionTemplate sqlSession;
	
}
