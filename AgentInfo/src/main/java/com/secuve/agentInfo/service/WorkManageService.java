package com.secuve.agentInfo.service;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
			workManage.setWorkManagePackageSizeOne(getFileSize(workManagePackageFileOneView.getSize()));			
		}
		
		if(workManagePackageFileTwoView != null) {
			workManage.setWorkManagePackageFileTwo(workManagePackageFileTwoView.getOriginalFilename());
			workManage.setWorkManagePackageSizeTwo(getFileSize(workManagePackageFileTwoView.getSize()));
		}
		
		if(workManagePackageFileThreeView != null) {
			workManage.setWorkManagePackageFileThree(workManagePackageFileThreeView.getOriginalFilename());
			workManage.setWorkManagePackageSizeThree(getFileSize(workManagePackageFileThreeView.getSize()));
		}
		
		if(workManagePackageFileFourView != null) {
			workManage.setWorkManagePackageFileFour(workManagePackageFileFourView.getOriginalFilename());
			workManage.setWorkManagePackageSizeFour(getFileSize(workManagePackageFileFourView.getSize()));
		}
		
		String tester = workManage.getWorkManageTesterView();
		if (tester != null) {
		    tester = tester.replaceAll(",\\s*$", "");
		}
		workManage.setWorkManageTesterView(tester);
		
		int success = workManageDao.insertWorkManage(workManage);
		
		if (success <= 0) return "FALSE";
		
		// 파일 다운로드 시 keyNum_filename 형식을 위해 키값을 받고 업로드 진행
		if(workManagePackageFileOneView != null) {
			fileUpLoad(workManage, workManagePackageFileOneView);
		}
		
		if(workManagePackageFileTwoView != null) {
			fileUpLoad(workManage, workManagePackageFileTwoView);
		}
		
		if(workManagePackageFileThreeView != null) {
			fileUpLoad(workManage, workManagePackageFileThreeView);
		}
		
		if(workManagePackageFileFourView != null) {
			fileUpLoad(workManage, workManagePackageFileFourView);
		}
		
		return "OK";
	}
	
	private String getFileSize(long size) {
	    double kb = (double) size / 1024;
	    double mb = kb / 1024;
	    double gb = mb / 1024;

	    if (gb >= 1) {
	        return String.format("%.1f GB", gb);
	    }
	    if (mb >= 1) {
	        return String.format("%.1f MB", mb);
	    }
	    if (kb >= 1) {
	        return String.format("%.1f KB", kb);
	    }
	    return size + " Byte";
	}

	public WorkManage getWorkManageOne(int workManageKeyNum) {
		return workManageDao.getWorkManageOne(workManageKeyNum);
	}

	public String updateWorkManage(WorkManage workManage, MultipartFile workManagePackageFileOneView, MultipartFile workManagePackageFileTwoView, MultipartFile workManagePackageFileThreeView, MultipartFile workManagePackageFileFourView) throws IllegalStateException, IOException {
		if(workManagePackageFileOneView != null) {
			workManage.setWorkManagePackageFileOne(workManagePackageFileOneView.getOriginalFilename());
			workManage.setWorkManagePackageSizeOne(getFileSize(workManagePackageFileOneView.getSize()));
			fileUpLoad(workManage, workManagePackageFileOneView);
		}
		
		if(workManagePackageFileTwoView != null) {
			workManage.setWorkManagePackageFileTwo(workManagePackageFileTwoView.getOriginalFilename());
			workManage.setWorkManagePackageSizeTwo(getFileSize(workManagePackageFileTwoView.getSize()));
			fileUpLoad(workManage, workManagePackageFileTwoView);
		}
		
		if(workManagePackageFileThreeView != null) {
			workManage.setWorkManagePackageFileThree(workManagePackageFileThreeView.getOriginalFilename());
			workManage.setWorkManagePackageSizeThree(getFileSize(workManagePackageFileThreeView.getSize()));
			fileUpLoad(workManage, workManagePackageFileThreeView);
		}
		
		if(workManagePackageFileFourView != null) {
			workManage.setWorkManagePackageFileFour(workManagePackageFileFourView.getOriginalFilename());
			workManage.setWorkManagePackageSizeFour(getFileSize(workManagePackageFileFourView.getSize()));
			fileUpLoad(workManage, workManagePackageFileFourView);
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
	
	public void fileUpLoad(WorkManage workManage, MultipartFile workManagePackageFileView) throws IllegalStateException, IOException {
		File newFileName = new File(filePath + File.separator + "workManage", workManage.getWorkManageKeyNum()+"_"+workManagePackageFileView.getOriginalFilename());
		workManagePackageFileView.transferTo(newFileName);
	}

	public String progressChange(int[] chkList, String workManageCommentView, String workManageProgressView, Principal principal) {
		for (int workManageKeyNum : chkList) {
            if (workManageDao.progressChange(workManageKeyNum, workManageCommentView, workManageProgressView) <= 0) {
                return "FALSE";
            }
        }
        return "OK";
	}

	public Object getPeriod() {
		LocalDate today = LocalDate.now();
		LocalDate monday = today.with(DayOfWeek.MONDAY);
		LocalDate friday = today.with(DayOfWeek.FRIDAY);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy. MM. dd");
		String period = monday.format(formatter) + " ~ " + friday.format(formatter);

		return "업무기간 : " + period + "\r\n\r\n";
	}

	public List<String> getCustomerList() {
		return workManageDao.getCustomerList();
	}

	public List<WorkManage> getWorkManageCustomerAllProgressList(String workManageCustomer) {
		return workManageDao.getWorkManageCustomerAllProgressList(workManageCustomer);
	}

	public List<WorkManage> getWorkManageCustomerAllExpectedList(String workManageCustomer) {
		return workManageDao.getWorkManageCustomerAllExpectedList(workManageCustomer);
	}

	public List<WorkManage> getWorkManageCustomerWeeklyProgressList(String workManageCustomer, String employeeName) {
		return workManageDao.getWorkManageCustomerWeeklyProgressList(workManageCustomer, employeeName);
	}

	public List<WorkManage> getWorkManageCustomerWeeklyExpectedList(String workManageCustomer, String employeeName) {
		return workManageDao.getWorkManageCustomerWeeklyExpectedList(workManageCustomer, employeeName);
	}
	
}
