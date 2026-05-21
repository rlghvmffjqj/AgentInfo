package com.secuve.agentInfo.service;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.secuve.agentInfo.dao.WorkManageDao;
import com.secuve.agentInfo.vo.WorkManage;

@Service
public class WorkManageService {
	@Autowired	WorkManageDao workManageDao;

	public List<WorkManage> getWorkManageList(WorkManage search) {
	    List<WorkManage> workManageList = workManageDao.getWorkManageList(workManageSearch(search));

	    for (WorkManage workManage : workManageList) {
	        List<String> list = new ArrayList<>();

	        String[] productTypes = {
	                workManage.getWorkManageProductTypeOne(),
	                workManage.getWorkManageProductTypeTwo(),
	                workManage.getWorkManageProductTypeThree(),
	                workManage.getWorkManageProductTypeFour()
	        };

	        for (String productType : productTypes) {
	            if (productType != null && !productType.isEmpty()) {
	                list.add(productType);
	            }
	        }

	        // 쉼표로 문자열 변환
	        workManage.setWorkManageProductTypeList(
	                String.join(", ", list)
	        );
	    }
	    return workManageList;
	}

	public int getWorkManageListCount(WorkManage search) {
		return workManageDao.getWorkManageListCount(workManageSearch(search));
	}
	
	public WorkManage workManageSearch(WorkManage search) {
		search.setWorkManageCustomerArr(search.getWorkManageCustomer().split(","));
		search.setWorkManageDivisionArr(search.getWorkManageDivision().split(","));
		search.setWorkManageProgressStatusArr(search.getWorkManageProgressStatus().split(","));
		return search;
	}
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		return formatter.format(now);
	}

	public String nowDateDetail() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String insertWorkManage(WorkManage workManage, MultipartFile workManagePackageFileOneView, MultipartFile workManagePackageFileTwoView, MultipartFile workManagePackageFileThreeView, MultipartFile workManagePackageFileFourView) throws IllegalStateException, IOException {
		if(workManagePackageFileOneView != null) {
			workManage.setWorkManagePackageFileOne(workManagePackageFileOneView.getOriginalFilename());
			fileDownload(workManage, workManagePackageFileOneView);
		}
		
		if(workManagePackageFileTwoView != null) {
			workManage.setWorkManagePackageFileTwo(workManagePackageFileTwoView.getOriginalFilename());
			fileDownload(workManage, workManagePackageFileTwoView);
		}
		
		if(workManagePackageFileThreeView != null) {
			workManage.setWorkManagePackageFileThree(workManagePackageFileThreeView.getOriginalFilename());
			fileDownload(workManage, workManagePackageFileThreeView);
		}
		
		if(workManagePackageFileFourView != null) {
			workManage.setWorkManagePackageFileFour(workManagePackageFileFourView.getOriginalFilename());
			fileDownload(workManage, workManagePackageFileFourView);
		}
		
		String tester = workManage.getWorkManageTesterView();
		if (tester != null) {
		    tester = tester.replaceAll(",\\s*$", "");
		}
		workManage.setWorkManageTesterView(tester);
		
		int success = workManageDao.insertWorkManage(workManage);
		
		if (success <= 0) return "FALSE";
		
		return "OK";
	}

	public WorkManage getWorkManageOne(int workManageKeyNum) {
		return workManageDao.getWorkManageOne(workManageKeyNum);
	}

	public String updateWorkManage(WorkManage workManage, MultipartFile workManagePackageFileOneView, MultipartFile workManagePackageFileTwoView, MultipartFile workManagePackageFileThreeView, MultipartFile workManagePackageFileFourView) throws IllegalStateException, IOException {
		if(workManagePackageFileOneView != null) {
			workManage.setWorkManagePackageFileOne(workManagePackageFileOneView.getOriginalFilename());
			fileDownload(workManage, workManagePackageFileOneView);
		}
		
		if(workManagePackageFileTwoView != null) {
			workManage.setWorkManagePackageFileTwo(workManagePackageFileTwoView.getOriginalFilename());
			fileDownload(workManage, workManagePackageFileTwoView);
		}
		
		if(workManagePackageFileThreeView != null) {
			workManage.setWorkManagePackageFileThree(workManagePackageFileThreeView.getOriginalFilename());
			fileDownload(workManage, workManagePackageFileThreeView);
		}
		
		if(workManagePackageFileFourView != null) {
			workManage.setWorkManagePackageFileFour(workManagePackageFileFourView.getOriginalFilename());
			fileDownload(workManage, workManagePackageFileFourView);
		}
		
		String tester = workManage.getWorkManageTesterView();
		if (tester != null) {
		    tester = tester.replaceAll(",\\s*$", "");
		}
		workManage.setWorkManageTesterView(tester);
		
		int success = workManageDao.updateWorkManage(workManage);
		
		if (success <= 0) return "FALSE";
		return "OK";
	}

	public String delWorkManage(int[] chkList) {
		if (chkList == null || chkList.length == 0) {
            return "FALSE";
        }
		
		for (int workManageKeyNum : chkList) {
			int success = workManageDao.delWorkManage(workManageKeyNum);
			if (success <= 0) {
				return "FALSE";
			}
		}
		return "OK";
	}
	
	@Value("${spring.servlet.multipart.location}")
	String filePath;
	
	public void fileDownload(WorkManage workManage, MultipartFile workManagePackageFileView) throws IllegalStateException, IOException {
		File newFileName = new File(filePath + File.separator + "workManage", workManagePackageFileView.getOriginalFilename());
		workManagePackageFileView.transferTo(newFileName);
	}

}
