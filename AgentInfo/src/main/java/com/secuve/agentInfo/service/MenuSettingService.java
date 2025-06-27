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
	@Autowired ProductVersionService productVersionService;

	public List<MenuSetting> getMainMenuSettingList(MenuSetting search) {
		return menuSettingDao.getMainMenuSettingList(search);
	}

	public int getMainMenuSettingListCount(MenuSetting search) {
		return menuSettingDao.getMainMenuSettingListCount(search);
	}

	public List<MenuSetting> getSubMenuSettingList(MenuSetting search) {
		return menuSettingDao.getSubMenuSettingList(search);
	}

	public int getSubMenuSettingListCount(MenuSetting search) {
		return menuSettingDao.getSubMenuSettingListCount(search);
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String insertMenuSetting(MenuSetting menuSetting) {
		int menuSortCheck = menuSettingDao.getMenuSortCheck(menuSetting);
		int menuTitleCheck = menuSettingDao.getMenuTitleCheck(menuSetting);
		if(menuSortCheck > 0 || menuTitleCheck > 0) {
			return "MenuInsertCheck";
		}
		
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
		int menuSortCheck = menuSettingDao.getMenuSortCheck(menuSetting);
		int menuTitleCheck = menuSettingDao.getMenuTitleCheck(menuSetting);
		if(menuSortCheck > 0 || menuTitleCheck > 0) {
			return "MenuUpdateCheck";
		}
		
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

	public String getItemCheck(MenuSetting menuSetting) {
		int itemCheck = 0;
		if(menuSetting.getSubKeyNum() == "" || menuSetting.getSubKeyNum() == null) {
			itemCheck = menuSettingDao.getItemCheck(menuSetting.getMainKeyNum());
		}
		
		if(itemCheck > 0) {
			return "ItemCheckFalse";
		}
		return "OK";
	}

	public String insertItem(MenuSetting menuSetting) {
		int menuSortCheck = menuSettingDao.getMenuSortCheck(menuSetting);
		int menuTitleCheck = menuSettingDao.getMenuTitleCheck(menuSetting);
		if(menuSortCheck > 0 || menuTitleCheck > 0) {
			return "ItemInsertCheck";
		}
		
		if(menuSetting.getSubKeyNum() == "" || menuSetting.getSubKeyNum() == null) {
			menuSetting.setMenuParentKeyNum(Integer.parseInt(menuSetting.getMainKeyNum()));
		} else {
			menuSetting.setMenuParentKeyNum(Integer.parseInt(menuSetting.getSubKeyNum()));
		}
		int success = menuSettingDao.insertMenuSetting(menuSetting);
		if (success <= 0) {
			return "FALSE";
		} 
		return productVersionService.getInsertIten(menuSetting);
	}

	public List<MenuSetting> getItmeMenuSettingList(MenuSetting search) {
		return menuSettingDao.getItmeMenuSettingList(search);
	}

	public int getItmeMenuSettingListCount(MenuSetting search) {
		return menuSettingDao.getItmeMenuSettingListCount(search);
	}

	public String updateItem(MenuSetting menuSetting) {
		int menuSortCheck = menuSettingDao.getMenuSortCheck(menuSetting);
		int menuTitleCheck = menuSettingDao.getMenuTitleCheck(menuSetting);
		if(menuSortCheck > 0 || menuTitleCheck > 0) {
			return "ItemUpdateCheck";
		}
		
		if(menuSetting.getSubKeyNum() == "" || menuSetting.getSubKeyNum() == null) {
			menuSetting.setMenuParentKeyNum(Integer.parseInt(menuSetting.getMainKeyNum()));
		} else {
			menuSetting.setMenuParentKeyNum(Integer.parseInt(menuSetting.getSubKeyNum()));
		}
		int success = menuSettingDao.updateMenuSetting(menuSetting);
		if (success <= 0) {
			return "FALSE";
		} 
		return "OK";
	}


}
