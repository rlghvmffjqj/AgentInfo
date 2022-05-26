package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.Requests;

@Repository
public class RequestsDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<Requests> getRequestsList(Requests search) {
		return sqlSession.selectList("requests.getRequestsList", search);
	}

	public int getRequestsListCount() {
		return sqlSession.selectOne("requests.getRequestsListCount");
	}

	public int getRequestsKeyNum() {
		return sqlSession.selectOne("requests.getRequestsKeyNum");
	}

	public int insertRequests(Requests requests) {
		return sqlSession.insert("requests.insertRequests", requests);
	}

	public Requests getRequestsOne(String employeeId) {
		// TODO Auto-generated method stub
		return null;
	}

	public Requests getRequestsOne(int requestsKeyNum) {
		return sqlSession.selectOne("requests.getRequestsOne", requestsKeyNum);
	}

	public int updateRequests(Requests requests) {
		return sqlSession.update("requests.updateRequests", requests);
	}

	public int getRequestsCount() {
		return sqlSession.selectOne("requests.getRequestsCount");
	}

}
