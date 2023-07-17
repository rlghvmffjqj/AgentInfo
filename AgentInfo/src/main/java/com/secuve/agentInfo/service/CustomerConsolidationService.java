package com.secuve.agentInfo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.CustomerConsolidationDao;

@Service
public class CustomerConsolidationService {
	@Autowired CustomerConsolidationDao customerConsolidationDao;

}
