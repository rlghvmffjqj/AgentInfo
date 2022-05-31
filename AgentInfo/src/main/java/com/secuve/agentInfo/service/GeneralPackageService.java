package com.secuve.agentInfo.service;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.secuve.agentInfo.dao.GeneralPackageDao;
import com.secuve.agentInfo.vo.GeneralPackage;

@Service
public class GeneralPackageService {
	@Autowired GeneralPackageDao generalPackageDao;
	@Autowired CategoryService categoryService;

	public List<GeneralPackage> getGeneralPackage(GeneralPackage search) {
		return generalPackageDao.getGeneralPackage(GeneralPackageSearch(search));
	}

	public int getGeneralPackageCount(GeneralPackage search) {
		return generalPackageDao.getGeneralPackageCount(GeneralPackageSearch(search));
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy년MM월dd일_HH시mm분ss초");
		return formatter.format(now);
	}

	public String insertGeneralPackage(GeneralPackage generalPackage, MultipartFile releaseNotesView, Principal principal) throws IllegalStateException, IOException {
		String inspection = inspection(generalPackage);
		if(inspection != null) {
			return inspection;
		}
		
		selfInput(generalPackage);
		generalPackage.setReleaseNotes(releaseNotesView.getOriginalFilename());
		generalPackage.setGeneralPackageKeyNum(generalPackageKeyNum());
		int sucess = generalPackageDao.insertGeneralPackage(generalPackage);

		if (sucess <= 0)
			return "FALSE";
		categoryCheck(generalPackage, principal);
		fileDownload(generalPackage, releaseNotesView);
		return "OK";
	}
	
	public String updateGeneralPackage(GeneralPackage generalPackage, MultipartFile releaseNotesView, Principal principal) throws IllegalStateException, IOException {
		String inspection = inspection(generalPackage);
		if(inspection != null) {
			return inspection;
		}
		
		selfInput(generalPackage);
		generalPackage.setReleaseNotes(releaseNotesView.getOriginalFilename());
		int sucess = generalPackageDao.updateGeneralPackage(generalPackage);

		if (sucess <= 0)
			return "FALSE";
		categoryCheck(generalPackage, principal);
		fileDownload(generalPackage, releaseNotesView);
		return "OK";
	}
	
	public void selfInput(GeneralPackage generalPackage) {
		if(generalPackage.getManagementServerSelf().length() > 0) {
			generalPackage.setManagementServerView(generalPackage.getManagementServerSelf());
		}
		if(generalPackage.getAgentVerSelf().length() > 0) {
			generalPackage.setAgentVerView(generalPackage.getAgentVerSelf());
		}
		
		if(generalPackage.getOsTypeSelf().length() >0) {
			generalPackage.setOsTypeView(generalPackage.getOsTypeSelf());
		}
	}
	
	public int generalPackageKeyNum() {
		int generalPackageKeyNum = 0;
		try {
			generalPackageKeyNum = generalPackageDao.getGeneralPackageKeyNum();
		} catch (Exception e) {
			return generalPackageKeyNum;
		}
		return ++generalPackageKeyNum;
	}

	public String deleteGeneralPackage(int[] chkList) {
		for(int generalPackageKeyNum: chkList) {
			int sucess = generalPackageDao.deleteGeneralPackage(generalPackageKeyNum);
			if(sucess <= 0) 
				return "FALSE";
		}
		return "OK";
	}

	public GeneralPackage getGeneralPackageOne(int generalPackageKeyNum) {
		return generalPackageDao.getGeneralPackageOne(generalPackageKeyNum);
	}

	public void fileDownload(GeneralPackage generalPackage, MultipartFile releaseNotesView) throws IllegalStateException, IOException {
		File newFileName = new File(generalPackage.getReleaseNotes());
		releaseNotesView.transferTo(newFileName);
	}
	
	public void categoryCheck(GeneralPackage generalPackage, Principal principal) {
		if (categoryService.getCategory("managementServer", generalPackage.getManagementServerView()) == 0) {
			categoryService.setCategory("managementServer", generalPackage.getManagementServerView(), principal.getName(), nowDate());
		}
		
		if (categoryService.getCategory("agentVer", generalPackage.getAgentVerView()) == 0) {
			categoryService.setCategory("agentVer", generalPackage.getAgentVerView(), principal.getName(), nowDate());
		}
		
		if (categoryService.getCategory("osType", generalPackage.getOsTypeView()) == 0) {
			categoryService.setCategory("osType", generalPackage.getOsTypeView(), principal.getName(), nowDate());
		}
	}
	
	public String inspection(GeneralPackage generalPackage) {
		if(generalPackage.getManagementServerView().equals(null) || generalPackage.getManagementServerView().equals("")) {
			if(generalPackage.getManagementServerSelf().equals(null) || generalPackage.getManagementServerSelf().equals(""))
				return "NotManagementServer";
		} else if(generalPackage.getAgentVerView().equals(null) || generalPackage.getAgentVerView().equals("")) {
			if(generalPackage.getAgentVerSelf().equals(null) || generalPackage.getAgentVerSelf().equals(""))
				return "NotAgentVer";
		} else if(generalPackage.getOsTypeView().equals(null) || generalPackage.getOsTypeView().equals("")) {
			if(generalPackage.getOsTypeSelf().equals(null) || generalPackage.getOsTypeSelf().equals(""))
				return "NotOsType";
		}
		return null;
	}

	public String[] BatchDownload(int[] chkList) {
		String[] files = new String[chkList.length];
		int num = 0;
		for(int generalPackageKeyNum: chkList) {
			files[num] = generalPackageDao.BatchDownload(generalPackageKeyNum);
			num++;
		}
		return files;
	}
	
	public GeneralPackage GeneralPackageSearch(GeneralPackage search) {
		search.setManagementServerArr(search.getManagementServer().split(","));
		search.setOsTypeArr(search.getOsType().split(","));
		search.setAgentVerArr(search.getAgentVer().split(","));
		
		return search;
	}
}