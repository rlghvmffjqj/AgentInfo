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

	public ServiceControl getServiceControlIpOne(String serviceControlIp) {
		return sqlSession.selectOne("serviceControl.getServiceControlIpOne", serviceControlIp);
	}

	public List<ServiceControl> serviceControlAll() {
		return sqlSession.selectList("serviceControl.serviceControlAll");
	}

	public void delServiceControlAll() {
		sqlSession.delete("serviceControl.delServiceControlAll");
	}

	public List<String> getServiceControlValue(String column) {
		return sqlSession.selectList("serviceControl.getServiceControlValue",column);
	}

	public void insertServiceControl(ServiceControl serviceControl) {
		sqlSession.insert("serviceControl.insertServiceControl", serviceControl);
	}

	public ServiceControl getServiceControlOne(int serviceControlKeyNum) {
		return sqlSession.selectOne("serviceControl.getServiceControlOne", serviceControlKeyNum);
	}

	public String getLastLogDate(ServiceControl serviceControl) {
		return sqlSession.selectOne("serviceControl.getLastLogDate", serviceControl);
	}

	public int setServiceControlUpdate(ServiceControl serviceControl) {
		return sqlSession.update("serviceControl.setServiceControlUpdate", serviceControl);
	}

	public int setRouteSetting(ServiceControl serviceControl) {
		return sqlSession.update("serviceControl.setRouteSetting", serviceControl);
	}

	public void delServiceControlIp(String serviceControlIp) {
		sqlSession.delete("delServiceControlIp",serviceControlIp);
	}
	
	
}
