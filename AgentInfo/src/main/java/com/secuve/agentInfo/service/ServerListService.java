package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.ServerListDao;
import com.secuve.agentInfo.vo.ServerList;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class ServerListService {
	@Autowired ServerListDao serverListDao;

	public List<String> getSelectInput(String serverListType, String selectInput) {
		return serverListDao.getSelectInput(serverListType, selectInput);
	}

	public List<ServerList> getServerList(ServerList search) {
		return serverListDao.getServerList(serverListSearch(search));
	}

	public int getServerListCount(ServerList search) {
		return serverListDao.getServerListCount(serverListSearch(search));
	}
	
	public ServerList serverListSearch(ServerList search) {
		search.setServerListDivisionArr(search.getServerListDivision().split(","));
		search.setServerListIpArr(search.getServerListIp().split(","));
		search.setServerListStateArr(search.getServerListState().split(","));
		search.setServerListMacArr(search.getServerListMac().split(","));
		search.setServerListAssetNumArr(search.getServerListAssetNum().split(","));
		search.setServerListHostNameArr(search.getServerListHostName().split(","));
		search.setServerListPurposeArr(search.getServerListPurpose().split(","));
		search.setServerListOsArr(search.getServerListOs().split(","));
		search.setServerListServerClassArr(search.getServerListServerClass().split(","));
		search.setServerListRackPositionArr(search.getServerListRackPosition().split(","));
		
		return search;
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String insertServerList(ServerList serverList) {
		int count = serverListDao.getServerListIp(serverList.getServerListIpView());
		if(count >= 1)
			return "IpOverlap";
		
		serverList.setServerListKeyNum(ServerListKeyNum());
		int sucess = serverListDao.insertServerList(serverList);
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}
	
	public int ServerListKeyNum() {
		int serverListKeyNum = 1;
		try {
			serverListKeyNum = serverListDao.getServerListKeyNum();
		} catch (Exception e) {
			return serverListKeyNum;
		}
		return ++serverListKeyNum;
	}

	public String delServerList(int[] chkList, Principal principal) {
		for (int serverListKeyNum : chkList) {
			int sucess = serverListDao.delServerList(serverListKeyNum);
			if (sucess <= 0)
				return "FALSE";
		}
		return "OK";
	}

	public ServerList getServerListOne(int serverListKeyNum) {
		return serverListDao.getServerListOne(serverListKeyNum);
	}

	public String updateServerList(ServerList serverList) {
		int count = serverListDao.getServerListIp(serverList.getServerListIpView());
		String ip = serverListDao.getServerListOne(serverList.getServerListKeyNum()).getServerListIp();
		if(ip.equals(serverList.getServerListIpView())) {
			count = 0;
		}
		if(count >= 1)
			return "IpOverlap";
		
		int sucess = serverListDao.updateServerList(serverList);
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public String stateChange(int[] chkList, String stateView) {
		for (int serverListKeyNum : chkList) {
			int sucess = serverListDao.stateChange(serverListKeyNum, stateView);

			if (sucess <= 0) 
				return "FALSE";
		}
		return "OK";
	}

	public List<ServerList> getServerListAll() {
		return serverListDao.getServerListAll();
	}

}
