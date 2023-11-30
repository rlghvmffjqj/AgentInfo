package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.ServiceControl;

@Repository
public class ServiceControlDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<ServiceControl> getServiceControlList(ServiceControl search) {
		return sqlSession.selectList("serviceControl.getServiceControlList", search);
	}

	public int getServiceControlListCount(ServiceControl search) {
		return sqlSession.selectOne("serviceControl.getServiceControlListCount", search);
	}

	public int delServiceControl(int serviceControlKeyNum) {
		return sqlSession.delete("serviceControl.delServiceControl", serviceControlKeyNum);
	}

	public ServiceControl getServiceControlOne(String serviceControlIp) {
		return sqlSession.selectOne("serviceControl.getServiceControlOne", serviceControlIp);
	}

	public List<ServiceControl> serviceControlAll() {
		return sqlSession.selectList("serviceControl.serviceControlAll");
	}

	public void delServiceControlAll() {
		sqlSession.delete("serviceControl.delServiceControlAll");
	}
	
	
}
