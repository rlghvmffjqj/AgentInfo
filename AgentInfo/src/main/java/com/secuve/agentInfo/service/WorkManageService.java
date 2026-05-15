package com.secuve.agentInfo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.WorkManageDao;

@Service
public class WorkManageService {
	@Autowired	WorkManageDao workManageDao;

}
