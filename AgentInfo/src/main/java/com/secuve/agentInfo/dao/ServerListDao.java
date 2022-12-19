package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.ServerList;

@Repository
public class ServerListDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<String> getSelectInput(String serverListType, String selectInput) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("serverListType", serverListType);
		parameters.put("selectInput", selectInput);
		return sqlSession.selectList("serverList.getSelectInput", parameters);
	}

	public List<ServerList> getServerList(ServerList search) {
		return sqlSession.selectList("serverList.getServerList", search);
	}

	public int getServerListCount(ServerList search) {
		return sqlSession.selectOne("serverList.getServerListCount", search);
	}

	public int insertServerList(ServerList serverList) {
		return sqlSession.insert("serverList.insertServerList", serverList);
	}

	public int getServerListKeyNum() {
		return sqlSession.selectOne("serverList.getServerListKeyNum");
	}

	public int delServerList(int serverListKeyNum) {
		return sqlSession.delete("serverList.delServerList", serverListKeyNum);
	}

	public ServerList getServerListOne(int serverListKeyNum) {
		return sqlSession.selectOne("serverList.getServerListOne", serverListKeyNum);
	}

	public int updateServerList(ServerList serverList) {
		return sqlSession.update("serverList.updateServerList", serverList);
	}

	public int stateChange(int serverListKeyNum, String stateView) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("serverListKeyNum", serverListKeyNum);
		parameters.put("stateView", stateView);
		
		return sqlSession.update("serverList.stateChange", parameters);
	}

	public int getServerListAssetNum(String serverListAssetNumView) {
		return sqlSession.selectOne("serverList.getServerListAssetNum", serverListAssetNumView);
	}

	public List<ServerList> getServerListAll() {
		return sqlSession.selectList("serverList.getServerListAll");
	}

	public List<ServerList> getServerListSearchAll(ServerList serverListSearch) {
		return sqlSession.selectList("serverList.getServerListSearchAll", serverListSearch);
	}


}
