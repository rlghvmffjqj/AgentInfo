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
		return generalPackageDao.getGeneralPackage(search);
	}

	public int getGeneralPackageCount(GeneralPackage search) {
		return generalPackageDao.getGeneralPackageCount(search);
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String insertGeneralPackage(GeneralPackage generalPackage, MultipartFile releaseNotesView, Principal principal) throws IllegalStateException, IOException {
		if(generalPackage.getManagementServerView().length() <= 0 && generalPackage.getManagementServerSelf() == null) {
			return "NotManagementServer";
		} else if(generalPackage.getAgentVerView().length() <= 0 && generalPackage.getAgentVerSelf() == null) {
			return "NotAgentVer";
		}
		
		if(generalPackage.getManagementServerView().length() <= 0) {
			generalPackage.setManagementServerView(generalPackage.getManagementServerSelf());
		}
		if(generalPackage.getAgentVerView().length() <= 0) {
			generalPackage.setAgentVerView(generalPackage.getAgentVerSelf());
		}
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
		if(generalPackage.getManagementServerView().length() <= 0 && generalPackage.getManagementServerSelf() == null) {
			return "NotManagementServer";
		} else if(generalPackage.getAgentVerView().length() <= 0 && generalPackage.getAgentVerSelf() == null) {
			return "NotAgentVer";
		}
		
		if(generalPackage.getManagementServerView().length() <= 0) {
			generalPackage.setManagementServerView(generalPackage.getManagementServerSelf());
		}
		if(generalPackage.getAgentVerView().length() <= 0) {
			generalPackage.setAgentVerView(generalPackage.getAgentVerSelf());
		}
		generalPackage.setReleaseNotes(releaseNotesView.getOriginalFilename());
		int sucess = generalPackageDao.updateGeneralPackage(generalPackage);

		if (sucess <= 0)
			return "FALSE";
		categoryCheck(generalPackage, principal);
		fileDownload(generalPackage, releaseNotesView);
		return "OK";
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
	}

}
