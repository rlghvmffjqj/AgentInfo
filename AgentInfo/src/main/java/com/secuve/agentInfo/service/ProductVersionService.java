package com.secuve.agentInfo.service;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.controller.MailSendController;
import com.secuve.agentInfo.dao.MenuSettingDao;
import com.secuve.agentInfo.dao.ProductVersionDao;
import com.secuve.agentInfo.vo.Compatibility;
import com.secuve.agentInfo.vo.MenuSetting;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class ProductVersionService {
	@Autowired ProductVersionDao productVersionDao;
	@Autowired MenuSettingDao menuSettingDao;
	@Autowired MailSendController mailSendController;

	public int getProductVersionNoneExist(String mainTitle, String subTitle) {
		return productVersionDao.getProductVersionNoneExist(mainTitle, subTitle);
	}

	public String alterItem(MenuSetting menuSetting) {
		menuSetting.setTableName("ProductVersion"+"_"+menuSetting.getMenuParentKeyNum());
		try {
			productVersionDao.alterItem(menuSetting);
		} catch (Exception e) {
			return "FALSE";
		}
		return "OK";
	}

	public String createItem(MenuSetting menuSetting) {
		menuSetting.setTableName("ProductVersion"+"_"+menuSetting.getMenuParentKeyNum());
		try {
			productVersionDao.createItem(menuSetting);
			productVersionDao.defaultItem(menuSetting);
			defaultMenuSetting(menuSetting);
		} catch (Exception e) {
			return "FALSE";
		}
		return "OK";
	}
	
	public void defaultMenuSetting(MenuSetting menuSetting) {
		menuSetting.setMenuSort(1);
		menuSetting.setMenuItemType("VARCHAR(100)");
		menuSetting.setMenuTitle("packageName");
		menuSetting.setMenuTitleKor("패키지명");
		menuSetting.setMenuType("item");
		menuSettingDao.insertMenuSetting(menuSetting);
		menuSetting.setMenuSort(2);
		menuSetting.setMenuTitle("location");
		menuSetting.setMenuTitleKor("전달위치");
		menuSettingDao.insertMenuSetting(menuSetting);
		menuSetting.setMenuSort(3);
		menuSetting.setMenuTitle("packageDate");
		menuSetting.setMenuItemType("DATE");
		menuSetting.setMenuTitleKor("날짜");
		menuSettingDao.insertMenuSetting(menuSetting);
	}

	public String alterDeleteItem(MenuSetting menuSetting) {
		menuSetting.setTableName("ProductVersion"+"_"+menuSetting.getMenuParentKeyNum());
		try {
			productVersionDao.alterDeleteItem(menuSetting);
		} catch (Exception e) {
			return "FALSE";
		}
		return "OK";
	}

	public String dropItem(MenuSetting menuSetting) {
		menuSetting.setTableName("ProductVersion"+"_"+menuSetting.getMenuParentKeyNum());
		try {
			productVersionDao.dropItem(menuSetting);
			menuSettingDao.deleteItem(menuSetting.getMenuParentKeyNum());
		} catch (Exception e) {
			return "FALSE";
		}
		return "OK";
	}

	public String alterUpdateItem(MenuSetting menuSetting) {
		menuSetting.setTableName("ProductVersion"+"_"+menuSetting.getMenuParentKeyNum());
		try {
			productVersionDao.alterUpdateItem(menuSetting);
		} catch (Exception e) {
			return "FALSE";
		}
		return "OK";
	}

	public List<Map<String, Object>> getProductVersionList(Map<String, String> paramMap) {
		return productVersionDao.getProductVersionList(paramMap);
	}

	public int getProductVersionListCount(Map<String, String> paramMap) {
		return productVersionDao.getProductVersionListCount(paramMap);
	}

	public String insertProductVersion(Map<String, String> paramMap, Principal principal) {
		int success = productVersionDao.insertProductVersion(paramMap);
		if (success <= 0) {
			return "FALSE";
		}
		mailSendProductVersion(paramMap, principal);
		return "OK";
	}
	
	public void mailSendProductVersion(Map<String, String> paramMap, Principal principal) {
		mailSendController.MailSendProductVersion(paramMap, principal);
	}

	public String delProductVersion(MenuSetting menuSettingOne, int[] chkList) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		int success = 1;
		paramMap.put("tableName", "ProductVersion"+"_"+menuSettingOne.getMenuKeyNum());
		for (int productVersionKeyNum : chkList) {
			paramMap.put("productVersionKeyNum", productVersionKeyNum);
			success *= productVersionDao.delProductVersion(paramMap);
			productVersionDao.delCompatibilityProductVersion(menuSettingOne.getMenuKeyNum(), productVersionKeyNum);
		}
		if (success <= 0) {
			return "FALSE";
		} 
		return "OK";
	}

	public String updateProductVersion(Map<String, String> paramMap) {
		int success = productVersionDao.updateProductVersion(paramMap);
		if (success <= 0) {
			return "FALSE";
		} 
		return "OK";
	}

	public String getMenuItemSort(int menuKeyNum) {
		return productVersionDao.getMenuItemSort(menuKeyNum);
	}

	public List<MenuSetting> getcompatibilityList(Compatibility search) throws UnknownHostException {
		String databaseName;
		String localIp = InetAddress.getLocalHost().getHostAddress();
		if(localIp.equals("172.16.100.90")) {
			databaseName = "agentinfo_sub";
		} else {
			databaseName = "agentinfo";
		}
		search.setProductVersionTable(productVersionDao.getProductVersionTableList(databaseName));
		search.getProductVersionTable().remove("productversion_"+search.getMenuKeyNum());
		MenuSetting menuSetting =  menuSettingDao.getMenuSettingOne(search.getMenuKeyNum());
		if(menuSetting.getMenuParentKeyNum() == 0) {
			search.setMainMenuTitle(menuSetting.getMenuTitle());
		} else {
			menuSetting =  menuSettingDao.getMenuSettingOne(menuSetting.getMenuParentKeyNum());
			search.setMainMenuTitle(menuSetting.getMenuTitle());
		}
		return productVersionDao.getcompatibilityList(search);
	}

	public int getcompatibilityListCount(Compatibility search) throws UnknownHostException {
		String databaseName;
		String localIp = InetAddress.getLocalHost().getHostAddress();
		if(localIp.equals("172.16.100.90")) {
			databaseName = "agentinfo_sub";
		} else {
			databaseName = "agentinfo";
		}
		search.setProductVersionTable(productVersionDao.getProductVersionTableList(databaseName));
		search.getProductVersionTable().remove("productversion_"+search.getMenuKeyNum());
		return productVersionDao.getcompatibilityListCount(search);
	}

	public String insertCompatibility(int menuKeyNum, int[] childChkList, int[] parsedList) {
		Compatibility compatibility = new Compatibility();
		for (int productVersionKeyNum1 : parsedList) {
			for (int productVersionKeyNum2 : childChkList) {
				compatibility.setMenuKeyNum1(menuKeyNum);
				compatibility.setProductVersionKeyNum1(productVersionKeyNum1);
				compatibility.setMenuKeyNum2(productVersionDao.getTableManagerProductVersion(productVersionKeyNum2));
				compatibility.setProductVersionKeyNum2(productVersionKeyNum2);
				int success = productVersionDao.insertCompatibility(compatibility);
				success *= productVersionDao.insertCompatibilityRe(compatibility);
				if (success <= 0) {
					return "FALSE";
				}
			}
		}
		
		return "OK";
	}

	public List<MenuSetting> getcompatibilitySearchList(Compatibility search) {
		List<Compatibility> compatibilityList = productVersionDao.getCompatibilityProductVersion(search);
		if(compatibilityList.size() == 0) {
			return null;
		}
		List<String> tableNameList = new ArrayList<String>();
		int[] productVersionKeyNumArr = new int[compatibilityList.size()];
		int num = 0;
		for(Compatibility compatibility : compatibilityList) {
			tableNameList.add("productversion_"+compatibility.getMenuKeyNum2());
			productVersionKeyNumArr[num] = compatibility.getProductVersionKeyNum2();
			num++;
		}
		tableNameList = new ArrayList<>(new LinkedHashSet<>(tableNameList));
		search.setProductVersionTable(tableNameList);
		search.setProductVersionKeyNumArr(productVersionKeyNumArr);
		return productVersionDao.getcompatibilityList(search);
	}

	public int getcompatibilityListSearchCount(Compatibility search) {
		List<Compatibility> compatibilityList = productVersionDao.getCompatibilityProductVersion(search);
		if(compatibilityList.size() == 0) {
			return 0;
		}
		List<String> tableNameList = new ArrayList<String>();
		int[] productVersionKeyNumArr = new int[compatibilityList.size()];
		int num = 0;
		for(Compatibility compatibility : compatibilityList) {
			tableNameList.add("productversion_"+compatibility.getMenuKeyNum2());
			productVersionKeyNumArr[num] = compatibility.getProductVersionKeyNum2();
			num++;
		}
		tableNameList = new ArrayList<>(new LinkedHashSet<>(tableNameList));
		search.setProductVersionTable(tableNameList);
		search.setProductVersionKeyNumArr(productVersionKeyNumArr);
		return productVersionDao.getcompatibilityListCount(search);
	}

	public String deleteCompatibility(int menuKeyNum, int[] childChkList, int[] parsedList) {
		Compatibility compatibility = new Compatibility();
		for (int productVersionKeyNum1 : parsedList) {
			for (int productVersionKeyNum2 : childChkList) {
				compatibility.setMenuKeyNum1(menuKeyNum);
				compatibility.setProductVersionKeyNum1(productVersionKeyNum1);
				compatibility.setMenuKeyNum2(productVersionDao.getTableManagerProductVersion(productVersionKeyNum2));
				compatibility.setProductVersionKeyNum2(productVersionKeyNum2);
				int success = productVersionDao.deleteCompatibility(compatibility);
				success *= productVersionDao.deleteCompatibilityRe(compatibility);
				if (success <= 0) {
					return "FALSE";
				}
			}
		}
		
		return "OK";
	}

	public int getTableManagerProductVersion(int productVersionKeyNum) {
		return productVersionDao.getTableManagerProductVersion(productVersionKeyNum);
	}

	public List<Object> listAll(Compatibility search) {
		List<Compatibility> compatibilityList = productVersionDao.getCompatibilityProductVersion(search);
		List<String> tableNameList = new ArrayList<String>();
		int[] productVersionKeyNumArr = new int[compatibilityList.size()];
		int num = 0;
		for(Compatibility compatibility : compatibilityList) {
			tableNameList.add("productversion_"+compatibility.getMenuKeyNum2());
			productVersionKeyNumArr[num] = compatibility.getProductVersionKeyNum2();
			num++;
		}
		tableNameList = new ArrayList<>(new LinkedHashSet<>(tableNameList));
		search.setProductVersionTable(tableNameList);
		search.setProductVersionKeyNumArr(productVersionKeyNumArr);
		return productVersionDao.getCompatibilityListAll(search);
	}
	
	public Compatibility getProductVersionOne(Compatibility compatibility) {
		return productVersionDao.getProductVersionOne(compatibility);
	}

	public List<String> getMenusettingMenutitle(String menuKeyNum) {
		return productVersionDao.getMenusettingMenutitle(menuKeyNum);
	}
	
	public List<MenuSetting> getcompatibilityAll(Compatibility search) throws UnknownHostException {
		String databaseName;
		String localIp = InetAddress.getLocalHost().getHostAddress();
		if(localIp.equals("172.16.100.90")) {
			databaseName = "agentinfo_sub";
		} else {
			databaseName = "agentinfo";
		}
		search.setProductVersionTable(productVersionDao.getProductVersionTableList(databaseName));
		search.getProductVersionTable().remove("productversion_"+search.getMenuKeyNum());

		return productVersionDao.getcompatibilityList(search);
	}

}
