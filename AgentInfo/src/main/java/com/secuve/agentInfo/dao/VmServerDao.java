package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.VmServer;

@Repository
public class VmServerDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<String> getSelectInput(String selectInput) {
		return sqlSession.selectList("vmServer.getSelectInput", selectInput);
	}

	public List<VmServer> getVmServer(VmServer search) {
		return sqlSession.selectList("vmServer.getVmServer", search);
	}

	public int getVmServerCount(VmServer search) {
		return sqlSession.selectOne("vmServer.getVmServerCount", search);
	}
}
