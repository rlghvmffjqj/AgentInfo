package com.secuve.agentInfo.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletOutputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.secuve.agentInfo.dao.CustomPackageDao;
import com.secuve.agentInfo.vo.CustomPackage;

@Service
public class CustomPackageService {
	@Autowired CustomPackageDao customPackageDao;
	@Autowired CategoryService categoryService;
	@Autowired CustomerBusinessMappingService customerBusinessMappingService;

	public List<CustomPackage> getCustomPackage(CustomPackage search) {
		return customPackageDao.getCustomPackage(search);
	}

	public int getCustomPackageCount(CustomPackage search) {
		return customPackageDao.getCustomPackageCount(search);
	}
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String insertCustomPackage(CustomPackage customPackage, MultipartFile releaseNotesView, Principal principal) throws IllegalStateException, IOException {
		String inspection = inspection(customPackage);
		if(inspection != null) {
			return inspection;
		}
		
		customPackage = selfInput(customPackage);
		customPackage.setReleaseNotes(releaseNotesView.getOriginalFilename());
		customPackage.setCustomPackageKeyNum(customPackageKeyNum());
		int sucess = customPackageDao.insertCustomPackage(customPackage);

		if (sucess <= 0)
			return "FALSE";
		customerBusinessMappingService.customerBusinessMapping(customPackage.getCustomerNameView(), customPackage.getBusinessNameView());
		categoryCheck(customPackage, principal);
		fileDownload(customPackage, releaseNotesView);
		return "OK";
	}
	
	public String updateCustomPackage(CustomPackage customPackage, MultipartFile releaseNotesView,	Principal principal) throws IllegalStateException, IOException {
		String inspection = inspection(customPackage);
		if(inspection != null) {
			return inspection;
		}
		
		customPackage = selfInput(customPackage);
		customPackage.setReleaseNotes(releaseNotesView.getOriginalFilename());
		int sucess = customPackageDao.updateCustomPackage(customPackage);

		if (sucess <= 0)
			return "FALSE";
		customerBusinessMappingService.customerBusinessMapping(customPackage.getCustomerNameView(), customPackage.getBusinessNameView());
		categoryCheck(customPackage, principal);
		fileDownload(customPackage, releaseNotesView);
		return "OK";
	}
	
	public String inspection(CustomPackage customPackage) {
		if(customPackage.getCustomerNameView().equals(null) || customPackage.getCustomerNameView().equals("")) {
			if(customPackage.getCustomerNameSelf().equals(null) || customPackage.getCustomerNameSelf().equals(""))
				return "NotCustomerName";
		} else if(customPackage.getManagementServerView().equals(null) || customPackage.getManagementServerView().equals("")) {
			if(customPackage.getManagementServerSelf().equals(null) || customPackage.getManagementServerSelf().equals(""))
				return "NotManagementServer";
		} else if(customPackage.getAgentVerView().equals(null) || customPackage.getAgentVerView().equals("")) {
			if(customPackage.getAgentVerSelf().equals(null) || customPackage.getAgentVerSelf().equals(""))
				return "NotAgentVer";
		}
		return null;
	}
	
	public CustomPackage selfInput(CustomPackage customPackage) {
		if(customPackage.getManagementServerView().length() <= 0) {
			customPackage.setManagementServerView(customPackage.getManagementServerSelf());
		}
		if(customPackage.getAgentVerView().length() <= 0) {
			customPackage.setAgentVerView(customPackage.getAgentVerSelf());
		}
		if(customPackage.getCustomerNameView().length() <= 0) {
			customPackage.setCustomerNameView(customPackage.getCustomerNameSelf());
		}
		if(customPackage.getBusinessNameView().length() <= 0) {
			customPackage.setBusinessNameView(customPackage.getBusinessNameSelf());
		}
		return customPackage;
	}
	
	public int customPackageKeyNum() {
		int customPackageKeyNum = 0;
		try {
			customPackageKeyNum = customPackageDao.getCustomPackageKeyNum();
		} catch (Exception e) {
			return customPackageKeyNum;
		}
		return ++customPackageKeyNum;
	}
	
	public void fileDownload(CustomPackage customPackage, MultipartFile releaseNotesView) throws IllegalStateException, IOException {
		File newFileName = new File(customPackage.getReleaseNotes());
		releaseNotesView.transferTo(newFileName);
	}
	
	public void categoryCheck(CustomPackage customPackage, Principal principal) {
		if (categoryService.getCategory("managementServer", customPackage.getManagementServerView()) == 0) {
			categoryService.setCategory("managementServer", customPackage.getManagementServerView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("agentVer", customPackage.getAgentVerView()) == 0) {
			categoryService.setCategory("agentVer", customPackage.getAgentVerView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("customerName", customPackage.getCustomerNameView()) == 0) {
			categoryService.setCategory("customerName", customPackage.getCustomerNameView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("businessName", customPackage.getBusinessNameView()) == 0) {
			categoryService.setCategory("businessName", customPackage.getBusinessNameView(), principal.getName(), nowDate());
		}
	}

	public String deleteCustomPackage(int[] chkList) {
		for(int customPackageKeyNum: chkList) {
			int sucess = customPackageDao.deleteCustomPackage(customPackageKeyNum);
			if(sucess <= 0) 
				return "FALSE";
		}
		return "OK";
	}

	public CustomPackage getCustomPackageOne(int customPackageKeyNum) {
		return customPackageDao.getCustomPackageOne(customPackageKeyNum);
	}

	public String[] BatchDownload(int[] chkList) {
		String[] files = new String[chkList.length];
		int num = 0;
		for(int customPackageKeyNum: chkList) {
			files[num] = customPackageDao.BatchDownload(customPackageKeyNum);
			num++;
		}
		return files;
	}

}
