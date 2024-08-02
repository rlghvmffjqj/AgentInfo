package com.secuve.agentInfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.LogGriffinDao;
import com.secuve.agentInfo.vo.License5;
import com.secuve.agentInfo.vo.LogGriffin;

@Service
public class LogGriffinService {
	@Autowired LogGriffinDao logGriffinDao;

	public LogGriffin insertLicenseView(Integer logGriffinKeyNum) {
		LogGriffin license = new LogGriffin();
		if(logGriffinKeyNum != null) {
			license = logGriffinDao.getLicenseOne(logGriffinKeyNum);
		}
		return license;
	}

	public List<String> getSelectInput(String selectInput) {
		return logGriffinDao.getSelectInput(selectInput);
	}

	public List<LogGriffin> getLicenseList(LogGriffin search) {
		return logGriffinDao.getLicenseList(search);
	}

	public int getLicenseListCount(LogGriffin search) {
		return logGriffinDao.getLicenseListCount(search);
	}

}
