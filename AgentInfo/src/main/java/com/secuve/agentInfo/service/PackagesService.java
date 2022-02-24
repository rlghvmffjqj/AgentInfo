package com.secuve.agentInfo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.PackagesDao;
import com.secuve.agentInfo.vo.Packages;

@Service
public class PackagesService {
	@Autowired PackagesDao packagesDao;
	@Autowired Packages packages;

	public List<Packages> getPackagesList(Packages search) {
		List<Packages> list = new ArrayList<Packages>();
		list = packagesDao.getPackagesList(search);
		return list;
	}

	public int getPackagesListCount(Packages search) {
		return packagesDao.getPackagesListCount(search);
	}

	public String delPackages(int[] chkList) {
		for(int packagesKeyNum: chkList) {
			int sucess = packagesDao.delPackages(packagesKeyNum);
			if(sucess <= 0) 
				return "FALSE";
		}
		return "OK";
	}

	public String insertPackages(Packages packages) {
		if(packages.getCustomerName().equals("") || packages.getCustomerName() == "" ) { // 고객사명 값이 비어있을 경우
			return "NotCustomerName";
		} 
		
		int num = packagesDao.getPackagesKeyNum();
		System.out.println(num);
		packages.setPackagesKeyNum(packagesDao.getPackagesKeyNum()+1);
		int sucess = packagesDao.insertPackages(packages);
		
		if(sucess <= 0) 
			return "FALSE";
		return "OK";
	}

	public Packages getPackagesOne(int packagesKeyNum) {
		return packagesDao.getPackagesOne(packagesKeyNum);
	}

	public String updatePackages(Packages packages) {
		if(packages.getCustomerName().equals("") || packages.getCustomerName() == "") { // 사원 이름이 비어있을 경우 리턴
			return "NotCustomerName";
		}
		int sucess = packagesDao.updatePackages(packages);
		
		if(sucess <= 0) 
			return "FALSE";
		return "OK";
	}

}
