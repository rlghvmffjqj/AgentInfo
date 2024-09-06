package com.secuve.agentInfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.VmServerDao;
import com.secuve.agentInfo.vo.ServerList;
import com.secuve.agentInfo.vo.VmServer;

@Service
public class VmServerService {
	@Autowired VmServerDao vmServerDao;

	public List<String> getSelectInput(String selectInput) {
		return vmServerDao.getSelectInput(selectInput);
	}

	public List<VmServer> getVmServer(VmServer search) {
		return vmServerDao.getVmServer(vmServerSearch(search));
	}
	
	
	public int getVmServerCount(VmServer search) {
		return vmServerDao.getVmServerCount(vmServerSearch(search));
	}
	
	public VmServer vmServerSearch(VmServer search) {
		search.setVmServerHostNameArr(search.getVmServerHostName().split(","));
		search.setVmServerNameArr(search.getVmServerName().split(","));

		return search;
	}

}
