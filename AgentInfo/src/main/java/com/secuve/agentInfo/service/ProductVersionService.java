package com.secuve.agentInfo.service;

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

	public String getInsertIten(MenuSetting menuSetting) {
		// TODO Auto-generated method stub
		return "OK";
	}

}
