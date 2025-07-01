package com.secuve.agentInfo.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.ProductVersionDao;
import com.secuve.agentInfo.vo.MenuSetting;
import com.secuve.agentInfo.vo.ProductVersion;

@Service
public class ProductVersionService {
	@Autowired ProductVersionDao productVersionDao;

	public int getProductVersionNoneExist(String mainTitle, String subTitle) {
		return productVersionDao.getProductVersionNoneExist(mainTitle, subTitle);
	}

	public String alterItem(MenuSetting menuSetting) {
		menuSetting.setTableName(menuSetting.getMenuParentTitle()+"_"+menuSetting.getMenuParentKeyNum());
		try {
			productVersionDao.alterItem(menuSetting);
		} catch (Exception e) {
			return "FALSE";
		}
		return "OK";
	}

	public String createItem(MenuSetting menuSetting) {
		menuSetting.setTableName(menuSetting.getMenuParentTitle()+"_"+menuSetting.getMenuParentKeyNum());
		try {
			productVersionDao.createItem(menuSetting);
		} catch (Exception e) {
			return "FALSE";
		}
		return "OK";
	}

	public String alterDeleteItem(MenuSetting menuSetting) {
		menuSetting.setTableName(menuSetting.getMenuParentTitle()+"_"+menuSetting.getMenuParentKeyNum());
		try {
			productVersionDao.alterDeleteItem(menuSetting);
		} catch (Exception e) {
			return "FALSE";
		}
		return "OK";
	}

	public String dropItem(MenuSetting menuSetting) {
		menuSetting.setTableName(menuSetting.getMenuParentTitle()+"_"+menuSetting.getMenuParentKeyNum());
		try {
			productVersionDao.dropItem(menuSetting);
		} catch (Exception e) {
			return "FALSE";
		}
		return "OK";
	}

	public String alterUpdateItem(MenuSetting menuSetting) {
		menuSetting.setTableName(menuSetting.getMenuParentTitle()+"_"+menuSetting.getMenuParentKeyNum());
		try {
			productVersionDao.alterUpdateItem(menuSetting);
		} catch (Exception e) {
			return "FALSE";
		}
		return "OK";
	}

	public List<Map<String, Object>> getProductVersionList(ProductVersion search) {
		return productVersionDao.getProductVersionList(search);
	}

	public int getProductVersionListCount(ProductVersion search) {
		return productVersionDao.getProductVersionListCount(search);
	}

}
