package com.secuve.agentInfo.service;

import java.text.SimpleDateFormat;
import java.util.Date;
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

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String insertMenuSetting(MenuSetting menuSetting) {
		int success = menuSettingDao.insertMenuSetting(menuSetting);
		if (success <= 0) {
			return "FALSE";
		} 
		return "OK";
	}

	public MenuSetting getMenuSettingOne(int menuKeyNum) {
		return menuSettingDao.getMenuSettingOne(menuKeyNum);
	}

	public String updateMenuSetting(MenuSetting menuSetting) {
		int success = menuSettingDao.updateMenuSetting(menuSetting);
		if (success <= 0) {
			return "FALSE";
		} 
		return "OK";
	}

	public String delMenuSetting(int menuKeyNum) {
		int success = menuSettingDao.delMenuSetting(menuKeyNum);
		if (success <= 0) {
			return "FALSE";
		} 
		return "OK";
	}

	public List<MenuSetting> getMenuList() {
		return menuSettingDao.getMenuList();
	}

}
