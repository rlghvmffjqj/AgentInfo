package com.secuve.agentInfo.service;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.ProductVersionDao;
import com.secuve.agentInfo.vo.Compatibility;
import com.secuve.agentInfo.vo.MenuSetting;

@Service
public class ProductVersionService {
	@Autowired ProductVersionDao productVersionDao;

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
		} catch (Exception e) {
			return "FALSE";
		}
		return "OK";
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

	public String insertProductVersion(Map<String, String> paramMap) {
		int success = productVersionDao.insertProductVersion(paramMap);
		if (success <= 0) {
			return "FALSE";
		} 
		return "OK";
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

	public List<String> getMenusettingMenutitle() {
		return productVersionDao.getMenusettingMenutitle();
	}

}
