package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.VmServer;
import com.secuve.agentInfo.vo.VmServerHost;

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

	public int insertVmServerHost(VmServerHost vmServerHost) {
		return sqlSession.insert("vmServer.insertVmServerHost", vmServerHost);
	}

	public int insertVmServer(VmServer vmServer) {
		return sqlSession.insert("vmServer.insertVmServer", vmServer);
	}

	public int deleteVmServerHost(String vmServerHostName) {
		return sqlSession.delete("vmServer.deleteVmServerHost", vmServerHostName);
	}

	public int deleteVmServer(String vmServerHostName) {
		return sqlSession.delete("vmServer.deleteVmServer", vmServerHostName);
	}

	public List getVmServerSearchAll(VmServer vmServer) {
		return sqlSession.selectList("vmServer.getVmServerSearchAll", vmServer);
	}

	public List<VmServerHost> getVmServerHost() {
		return sqlSession.selectList("vmServer.getVmServerHost");
	}

	public void deleteAllVmServer() {
		sqlSession.delete("vmServer.deleteAllVmServer");
	}

	public int getVmServerHostValidity(String column, String values) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("column", column);
		parameters.put("values", values);
		return sqlSession.selectOne("vmServer.getVmServerHostValidity", parameters);
	}

}
