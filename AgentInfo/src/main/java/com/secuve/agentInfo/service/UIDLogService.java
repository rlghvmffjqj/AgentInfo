package com.secuve.agentInfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.UIDLogDao;
import com.secuve.agentInfo.vo.UIDLog;

@Service
public class UIDLogService {
	
	@Autowired UIDLogDao uidLogDao;

	public List<UIDLog> getUIDLogList(UIDLog search) {
		return uidLogDao.getUIDLogList(search);
	}

	public int getUIDLogListCount(UIDLog search) {
		return uidLogDao.getUIDLogListCount(search);
	}

}
