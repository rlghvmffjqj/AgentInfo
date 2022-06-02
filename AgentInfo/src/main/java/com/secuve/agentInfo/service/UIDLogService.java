package com.secuve.agentInfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.UIDLogDao;
import com.secuve.agentInfo.vo.UIDLog;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class UIDLogService {
	
	@Autowired UIDLogDao uidLogDao;

	/**
	 * 로그 리스트 조회
	 * @param search
	 * @return
	 */
	public List<UIDLog> getUIDLogList(UIDLog search) {
		return uidLogDao.getUIDLogList(UIDLogSearch(search));
	}

	/**
	 * 로그 갯수 조회
	 * @param search
	 * @return
	 */
	public int getUIDLogListCount(UIDLog search) {
		return uidLogDao.getUIDLogListCount(UIDLogSearch(search));
	}
	
	public UIDLog UIDLogSearch(UIDLog search) {
		search.setUidCustomerNameArr(search.getUidCustomerName().split(","));
		search.setUidEventArr(search.getUidEvent().split(","));
		
		return search;
	}
}