package com.secuve.agentInfo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.PackageAnalysisDao;

@Service
public class PackageAnalysisService {
	@Autowired
	PackageAnalysisDao packageAnalysisDao;

}
