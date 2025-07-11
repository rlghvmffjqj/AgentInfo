package com.secuve.agentInfo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.ProductVersionDao;
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

}
