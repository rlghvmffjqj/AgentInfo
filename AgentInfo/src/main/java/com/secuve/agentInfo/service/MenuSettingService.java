package com.secuve.agentInfo.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.MenuSettingDao;
import com.secuve.agentInfo.vo.MenuSetting;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
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
		int itemChek =  menuSettingDao.getItemExistCheck(menuKeyNum);
		if(itemChek > 0) {
			return "ItemExist";
		}
		
		int subChek =  menuSettingDao.getSubExistCheck(menuKeyNum);
		if(subChek > 0) {
			return "SubExist";
		}
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
			itemCheck = menuSettingDao.getItemCheck(Integer.parseInt(menuSetting.getMainKeyNum()));
		}
		
		if(itemCheck > 0) {
			return "ItemCheckFalse";
		}
		return "OK";
	}

	public String insertItem(MenuSetting menuSetting) {
		if(menuSetting.getSubKeyNum() == "" || menuSetting.getSubKeyNum() == null) {
			menuSetting.setMenuParentKeyNum(Integer.parseInt(menuSetting.getMainKeyNum()));
			menuSetting.setMenuParentTitle(menuSettingDao.getMenuSettingOne(Integer.parseInt(menuSetting.getMainKeyNum())).getMenuTitle());
		} else {
			menuSetting.setMenuParentKeyNum(Integer.parseInt(menuSetting.getSubKeyNum()));
			menuSetting.setMenuParentTitle(menuSettingDao.getMenuSettingOne(Integer.parseInt(menuSetting.getSubKeyNum())).getMenuTitle());
		}
	
		String titleEng = menuSetting.getMenuTitle();
		boolean isEngOrDigitOnly = titleEng != null && titleEng.matches("^[a-zA-Z0-9]+$");

		if (!isEngOrDigitOnly) {
		    return "OnlyEnglish";
		} 
		
		int menuSortCheck = menuSettingDao.getMenuSortCheck(menuSetting);
		int menuTitleCheck = menuSettingDao.getMenuTitleCheck(menuSetting);
		if(menuSortCheck > 0 || menuTitleCheck > 0) {
			return "ItemInsertCheck";
		}
		int success = menuSettingDao.insertMenuSetting(menuSetting);
		if (success <= 0) {
			return "FALSE";
		} 
		menuSettingDao.setMenuItemSort(menuSetting);
		if(menuSettingDao.getItmeMenuSettingListCount(menuSetting) > 1) {
			return productVersionService.alterItem(menuSetting);
		} else {
			return productVersionService.createItem(menuSetting);
		}
	}

	public List<MenuSetting> getItmeMenuSettingList(MenuSetting search) {
		return menuSettingDao.getItmeMenuSettingList(search);
	}

	public int getItmeMenuSettingListCount(MenuSetting search) {
		return menuSettingDao.getItmeMenuSettingListCount(search);
	}

	public String updateItem(MenuSetting menuSetting) {
		if(menuSetting.getSubKeyNum() == "" || menuSetting.getSubKeyNum() == null) {
			menuSetting.setMenuParentKeyNum(Integer.parseInt(menuSetting.getMainKeyNum()));
			menuSetting.setMenuParentTitle(menuSettingDao.getMenuSettingOne(Integer.parseInt(menuSetting.getMainKeyNum())).getMenuTitle());
		} else {
			menuSetting.setMenuParentKeyNum(Integer.parseInt(menuSetting.getSubKeyNum()));
			menuSetting.setMenuParentTitle(menuSettingDao.getMenuSettingOne(Integer.parseInt(menuSetting.getSubKeyNum())).getMenuTitle());
		}
		menuSetting.setOldTitle(menuSettingDao.getMenuSettingOne(menuSetting.getMenuKeyNum()).getMenuTitle());
		int menuSortCheck = menuSettingDao.getMenuSortCheck(menuSetting);
		int menuTitleCheck = menuSettingDao.getMenuTitleCheck(menuSetting);
		if(menuSortCheck > 0 || menuTitleCheck > 0) {
			return "ItemUpdateCheck";
		}
		
		int success = menuSettingDao.updateMenuSetting(menuSetting);
		if (success <= 0) {
			return "FALSE";
		} 
		menuSettingDao.setMenuItemSort(menuSetting);
		return productVersionService.alterUpdateItem(menuSetting);
	}

	public String delItemMenuSetting(MenuSetting menuSetting) {
		MenuSetting menuSettingOne = menuSettingDao.getMenuSettingOne(menuSetting.getMenuKeyNum());
		if("packageName".equals(menuSettingOne.getMenuTitle()) || "location".equals(menuSettingOne.getMenuTitle()) || "packageDate".equals(menuSettingOne.getMenuTitle())) {
			return "NotDelete";
		}
		if(menuSetting.getSubKeyNum() == "" || menuSetting.getSubKeyNum() == null) {
			menuSetting.setMenuParentKeyNum(Integer.parseInt(menuSetting.getMainKeyNum()));
			menuSetting.setMenuParentTitle(menuSettingDao.getMenuSettingOne(Integer.parseInt(menuSetting.getMainKeyNum())).getMenuTitle());
			menuSetting.setMenuTitle(menuSettingDao.getMenuSettingOne(menuSetting.getMenuKeyNum()).getMenuTitle());
		} else {
			menuSetting.setMenuParentKeyNum(Integer.parseInt(menuSetting.getSubKeyNum()));
			menuSetting.setMenuParentTitle(menuSettingDao.getMenuSettingOne(Integer.parseInt(menuSetting.getSubKeyNum())).getMenuTitle());
			menuSetting.setMenuTitle(menuSettingDao.getMenuSettingOne(menuSetting.getMenuKeyNum()).getMenuTitle());
		}
		
		int success = menuSettingDao.delMenuSetting(menuSetting.getMenuKeyNum());
		if (success <= 0) {
			return "FALSE";
		} 
	
		if(menuSettingDao.getItmeMenuSettingListCount(menuSetting) > 3) {
			return productVersionService.alterDeleteItem(menuSetting);
		} else {
			return productVersionService.dropItem(menuSetting);
		}
	}

	public List<MenuSetting> getMenuSettingItemList(int menuParentKeyNum) {
		return menuSettingDao.getMenuSettingItemList(menuParentKeyNum);
	}

	public List<Map<String,Object>> getMenuSettingItemListJoin(MenuSetting menuSetting) {
		return menuSettingDao.getMenuSettingItemListJoin(menuSetting);
	}

	public int getSortNumMax(MenuSetting menuSetting) {
		if(menuSetting.getSubKeyNum() == "" || menuSetting.getSubKeyNum() == null) {
			menuSetting.setMenuParentKeyNum(Integer.parseInt(menuSetting.getMainKeyNum()));
			menuSetting.setMenuParentTitle(menuSettingDao.getMenuSettingOne(Integer.parseInt(menuSetting.getMainKeyNum())).getMenuTitle());
		} else {
			menuSetting.setMenuParentKeyNum(Integer.parseInt(menuSetting.getSubKeyNum()));
			menuSetting.setMenuParentTitle(menuSettingDao.getMenuSettingOne(Integer.parseInt(menuSetting.getSubKeyNum())).getMenuTitle());
		}
		try {
			return menuSettingDao.getSortNumMax(menuSetting);
		} catch (Exception e) {
			return 3;
		}
	}


	public int getMaxSort(MenuSetting menuSetting) {
		int maxSort = 0;
		try {
			if("main".equals(menuSetting.getMenuType())) {
				maxSort = menuSettingDao.getMaxMainSort();
			} else if("sub".equals(menuSetting.getMenuType())) {
				maxSort = menuSettingDao.getMaxSubSort(menuSetting);
			}
		} catch (Exception e) {
			return 1;
		}
		return ++maxSort;
	}

	public List<MenuSetting> getMenuSettingItemList(String mainKeyNum, String subKeyNum) {
		int menuParentKeyNum = 0;
		if(subKeyNum == "" || subKeyNum == null) {
			menuParentKeyNum = Integer.parseInt(mainKeyNum);
		} else {
			menuParentKeyNum = Integer.parseInt(subKeyNum);
		}
		return menuSettingDao.getMenuSettingItemList(menuParentKeyNum);
	}

}
