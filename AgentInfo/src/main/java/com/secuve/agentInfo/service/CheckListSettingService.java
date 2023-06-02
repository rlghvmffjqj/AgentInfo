package com.secuve.agentInfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.CheckListSettingDao;
import com.secuve.agentInfo.vo.CheckListSetting;

@Service
public class CheckListSettingService {
	@Autowired CheckListSettingDao checkListSettingDao;

	public List<CheckListSetting> checkListSettingForm() {
		
		return checkListSettingDao.checkListSettingForm();
	}
}
