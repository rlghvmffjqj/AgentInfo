package com.secuve.agentInfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.MenuSettingDao;
import com.secuve.agentInfo.vo.MenuSetting;

@Service
public class MenuSettingService {
	@Autowired MenuSettingDao menuSettingDao;

	public List<MenuSetting> getMainMenuSettingList(MenuSetting search) {
		return menuSettingDao.getMainMenuSettingList(search);
	}

	public int getMainMenuSettingListCount() {
		return menuSettingDao.getMainMenuSettingListCount();
	}

	public List<MenuSetting> getSubMenuSettingList(MenuSetting search) {
		return menuSettingDao.getSubMenuSettingList(search);
	}

	public int getSubMenuSettingListCount() {
		return menuSettingDao.getSubMenuSettingListCount();
	}

}
