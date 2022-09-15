package com.secuve.agentInfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.PackageUidLogDao;
import com.secuve.agentInfo.vo.PackageUidLog;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class PackageUidLogService {
	
	@Autowired PackageUidLogDao uidLogDao;

	/**
	 * 로그 리스트 조회
	 * @param search
	 * @return
	 */
	public List<PackageUidLog> getPackageUidLogList(PackageUidLog search) {
		return uidLogDao.getPackageUidLogList(PackageUidLogSearch(search));
	}

	/**
	 * 로그 갯수 조회
	 * @param search
	 * @return
	 */
	public int getPackageUidLogListCount(PackageUidLog search) {
		return uidLogDao.getPackageUidLogListCount(PackageUidLogSearch(search));
	}
	
	public PackageUidLog PackageUidLogSearch(PackageUidLog search) {
		search.setUidCustomerNameArr(search.getUidCustomerName().split(","));
		search.setUidEventArr(search.getUidEvent().split(","));
		if(search.getUidDateStart() != "" && search.getUidDateEnd() != "") {
			search.setUidDateStart(search.getUidDateStart() + " 00:00:00");
			search.setUidDateEnd(search.getUidDateEnd() + " 24:59:59");
		}
		
		return search;
	}
}