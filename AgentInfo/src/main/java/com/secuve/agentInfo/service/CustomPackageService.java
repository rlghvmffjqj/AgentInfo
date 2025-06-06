package com.secuve.agentInfo.service;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.secuve.agentInfo.dao.CustomPackageDao;
import com.secuve.agentInfo.vo.CustomPackage;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class CustomPackageService {
	@Autowired CustomPackageDao customPackageDao;
	@Autowired CategoryService categoryService;

	public List<CustomPackage> getCustomPackage(CustomPackage search) {
		return customPackageDao.getCustomPackage(CustomPackageSearch(search));
	}

	public int getCustomPackageCount(CustomPackage search) {
		return customPackageDao.getCustomPackageCount(CustomPackageSearch(search));
	}
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy년MM월dd일_HH시mm분ss초");
		return formatter.format(now);
	}

	public String insertCustomPackage(CustomPackage customPackage, MultipartFile releaseNotesView, Principal principal) throws IllegalStateException, IOException {
		String inspection = inspection(customPackage);
		if(inspection != null) {
			return inspection;
		}
		
		selfInput(customPackage);
		customPackage.setReleaseNotes(releaseNotesView.getOriginalFilename());
		int success = customPackageDao.insertCustomPackage(customPackage);

		if (success <= 0)
			return "FALSE";
		categoryService.insertCustomerBusinessMapping(customPackage.getCustomerNameView(), customPackage.getBusinessNameView());
		categoryCheck(customPackage, principal);
		fileDownload(customPackage, releaseNotesView);
		return "OK";
	}
	
	public String updateCustomPackage(CustomPackage customPackage, MultipartFile releaseNotesView,	Principal principal) throws IllegalStateException, IOException {
		String inspection = inspection(customPackage);
		if(inspection != null) {
			return inspection;
		}
		
		selfInput(customPackage);
		customPackage.setReleaseNotes(releaseNotesView.getOriginalFilename());
		int success = customPackageDao.updateCustomPackage(customPackage);

		if (success <= 0)
			return "FALSE";
		categoryService.insertCustomerBusinessMapping(customPackage.getCustomerNameView(), customPackage.getBusinessNameView());
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
		} else if(customPackage.getOsTypeView().equals(null) || customPackage.getOsTypeView().equals("")) {
			if(customPackage.getOsTypeSelf().equals(null) || customPackage.getOsTypeSelf().equals(""))
				return "NotOsType";
		}
		return null;
	}
	
	public void selfInput(CustomPackage customPackage) {
		if(customPackage.getManagementServerSelf().length() > 0) {
			customPackage.setManagementServerView(customPackage.getManagementServerSelf());
		}
		if(customPackage.getAgentVerSelf().length() > 0) {
			customPackage.setAgentVerView(customPackage.getAgentVerSelf());
		}
		if(customPackage.getCustomerNameSelf().length() > 0) {
			customPackage.setCustomerNameView(customPackage.getCustomerNameSelf());
		}
		if(customPackage.getBusinessNameSelf().length() > 0) {
			customPackage.setBusinessNameView(customPackage.getBusinessNameSelf());
		}
		if(customPackage.getOsTypeSelf().length() > 0) {
			customPackage.setOsTypeView(customPackage.getOsTypeSelf());
		}
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
		if (categoryService.getCategory("osType", customPackage.getOsTypeView()) == 0) {
			categoryService.setCategory("osType", customPackage.getOsTypeView(), principal.getName(), nowDate());
		}
	}

	public String deleteCustomPackage(int[] chkList) {
		for(int customPackageKeyNum: chkList) {
			int success = customPackageDao.deleteCustomPackage(customPackageKeyNum);
			if(success <= 0) 
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
	
	public CustomPackage CustomPackageSearch(CustomPackage search) {
		search.setCustomerNameArr(search.getCustomerName().split(","));
		search.setBusinessNameArr(search.getBusinessName().split(","));
		search.setManagementServerArr(search.getManagementServer().split(","));
		search.setOsTypeArr(search.getOsType().split(","));
		search.setAgentVerArr(search.getAgentVer().split(","));
		
		return search;
	}
}