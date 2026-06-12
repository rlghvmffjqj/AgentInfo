package com.secuve.agentInfo.service;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
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

	public String insertWorkManage(WorkManage workManage, List<MultipartFile> workManagePackageFileView) throws IllegalStateException, IOException {
		List<String> fileNames = new ArrayList<>();
		List<String> fileSizes = new ArrayList<>();
		
		if (workManage.getWorkManagePackageFileView() != null && !workManage.getWorkManagePackageFileView().isEmpty()) {
			int i=0;
			for(MultipartFile workManagePackageFile : workManage.getWorkManagePackageFileView()) {
				if(workManagePackageFile.getSize() == 0) {
					fileNames.add(workManage.getWorkManagePackageNameView().get(i));
			        fileSizes.add("0MB");
				} else {
					if(workManagePackageFile != null && !workManagePackageFile.isEmpty()) {
						fileNames.add(workManagePackageFile.getOriginalFilename());
				        fileSizes.add(getFileSize(workManagePackageFile.getSize()));
					}
				}
				++i;
			}
		}
		workManage.setWorkManageProductType(String.join(",", workManage.getWorkManageProductTypeView()));
		workManage.setWorkManageProductTypeCount(String.join(",", workManage.getWorkManageProductTypeCountView()));
		workManage.setWorkManagePackageName(String.join(",", workManage.getWorkManagePackageNameView()));
		workManage.setWorkManagePackageFileName(String.join(",", fileNames));
		workManage.setWorkManagePackageSize(String.join(",", fileSizes));
		
		String tester = workManage.getWorkManageTesterView();
		if (tester != null) {
		    tester = tester.replaceAll(",\\s*$", "");
		}
		workManage.setWorkManageTesterView(tester);
		
		int success = workManageDao.insertWorkManage(workManage);
		
		if (workManage.getWorkManagePackageFileView() != null && !workManage.getWorkManagePackageFileView().isEmpty()) {
			for(MultipartFile workManagePackageFile : workManage.getWorkManagePackageFileView()) {
				if(workManagePackageFile.getSize() != 0) {
					if(workManagePackageFile != null && !workManagePackageFile.isEmpty()) {
				        fileUpLoad(workManage, workManagePackageFile);
					}
				}
			}
		}
		
		if (success <= 0) return "FALSE";
		
		if (workManagePackageFileView != null && !workManagePackageFileView.isEmpty()) {
			for(MultipartFile workManagePackageFile : workManagePackageFileView) {
				if(workManagePackageFile != null && !workManagePackageFile.isEmpty()) {
			        fileUpLoad(workManage, workManagePackageFile);
				}
			}
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
		WorkManage workManage = workManageDao.getWorkManageOne(workManageKeyNum);
		
		if (workManage.getWorkManageProductType() != null && !workManage.getWorkManageProductType().isEmpty()) {
		    workManage.setWorkManageProductTypeView(Arrays.asList(workManage.getWorkManageProductType().split(",")));
		    workManage.setWorkManageProductTypeCountView(Arrays.asList(workManage.getWorkManageProductTypeCount().split(",")));
		    workManage.setWorkManagePackageNameView(Arrays.asList(workManage.getWorkManagePackageName().split(",")));
		    workManage.setWorkManagePackageFileNameView(Arrays.asList(workManage.getWorkManagePackageFileName().split(",")));
		    workManage.setWorkManagePackageSizeView(Arrays.asList(workManage.getWorkManagePackageSize().split(",")));
		}
		
		return workManage;
	}

	public String updateWorkManage(WorkManage workManage) throws IllegalStateException, IOException {
		List<String> fileNames = new ArrayList<>();
		List<String> fileSizes = new ArrayList<>();
		
		WorkManage workManageOld = workManageDao.getWorkManageOne(workManage.getWorkManageKeyNum());
		String[] fileNameOld = workManageOld.getWorkManagePackageFileName().split(",");
		String[] fileSizeOld = workManageOld.getWorkManagePackageSize().split(",");
		if (workManage.getWorkManagePackageFileView() != null && !workManage.getWorkManagePackageFileView().isEmpty()) {
			int i=0;
			for(MultipartFile workManagePackageFile : workManage.getWorkManagePackageFileView()) {
				if(workManagePackageFile.getSize() == 0) {
					try {
						fileNames.add(fileNameOld[i]);
			        	fileSizes.add(fileSizeOld[i]);
			        } catch (Exception e) {
			        	fileNames.add(workManage.getWorkManagePackageNameView().get(i));
			        	fileSizes.add("0MB");
					}
			        
				} else {
					if(workManagePackageFile != null && !workManagePackageFile.isEmpty()) {
						fileNames.add(workManagePackageFile.getOriginalFilename());
				        fileSizes.add(getFileSize(workManagePackageFile.getSize()));
				        fileUpLoad(workManage, workManagePackageFile);
					}
				}
				++i;
			}
			workManage.setWorkManagePackageFileName(String.join(",", fileNames));
			workManage.setWorkManagePackageSize(String.join(",", fileSizes));
		} else {
			workManage.setWorkManagePackageFileName(String.join(",", workManage.getWorkManagePackageFileNameView()));
			workManage.setWorkManagePackageSize(workManageOld.getWorkManagePackageSize());
		}
		
		
		String tester = workManage.getWorkManageTesterView();
		if (tester != null) {
		    tester = tester.replaceAll(",\\s*$", "");
		}
		workManage.setWorkManageTesterView(tester);
		
		workManage.setWorkManageProductType(String.join(",", workManage.getWorkManageProductTypeView()));
		workManage.setWorkManageProductTypeCount(String.join(",", workManage.getWorkManageProductTypeCountView()));
		workManage.setWorkManagePackageName(String.join(",", workManage.getWorkManagePackageNameView()));
		
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

	public String delWorkManageFlag(int[] chkList, String workManageDelReaon) {
		if (chkList == null || chkList.length == 0) {
            return "FALSE";
        }
		
		for (int workManageKeyNum : chkList) {
			int success = workManageDao.delWorkManageFlag(workManageKeyNum, workManageDelReaon);
			if (success <= 0) {
				return "FALSE";
			}
		}
		return "OK";
	}

	public List<WorkManage> getDailyWorkList(String employeeName) {
		return workManageDao.getDailyWorkList(employeeName);
	}

	public List<WorkManage> getTomorrowWorkList(String employeeName) {
		return workManageDao.getTomorrowWorkList(employeeName);
	}

}
