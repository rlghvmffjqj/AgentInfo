package com.secuve.agentInfo.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.CheckListSettingDao;
import com.secuve.agentInfo.vo.CheckListSetting;

@Service
public class CheckListSettingService {
	@Autowired CheckListSettingDao checkListSettingDao;

	public List<CheckListSetting> checkListSettingForm(String checkListSettingDivision) {
		CheckListSetting checkListSetting = new CheckListSetting();
		checkListSetting.setCheckListSettingDivision(checkListSettingDivision);
		return checkListSettingDao.checkListSettingForm(checkListSetting);
	}

	public int formPlus(CheckListSetting checkListSetting) {
		if(checkListSetting.getCheckListSettingFormKeyNum() == 0) {
			checkListSetting.setCheckListSettingFormSort(0);
		} else {
			int checkListSettingSort = checkListSettingDao.getCheckListSettingFormSort(checkListSetting.getCheckListSettingFormKeyNum());
			checkListSetting.setCheckListSettingFormSort(++checkListSettingSort);
			checkListSettingDao.getCheckListSettingFormSortPlus(checkListSetting);
		}
		checkListSettingDao.formPlus(checkListSetting);
		return checkListSetting.getCheckListSettingFormKeyNum();
	}

	public String formChange(CheckListSetting checkListSetting) {
		int success = checkListSettingDao.formChange(checkListSetting);
		if(success > 0) {
			return "OK";
		}
		return "FALSE";
	}

	public String formMinus(Integer checkListSettingFormKeyNum) {
		int success = checkListSettingDao.formMinus(checkListSettingFormKeyNum);
		if(success > 0) {
			checkListSettingDao.formCategoryMinus(checkListSettingFormKeyNum);
			checkListSettingDao.formSubCategoryMinus(checkListSettingFormKeyNum);
			checkListSettingDao.formDetailMinus(checkListSettingFormKeyNum);
			return "OK";
		}
		return "FALSE";
	}

	public List<CheckListSetting> checkListSettingCategory() {
		return checkListSettingDao.checkListSettingCategory();
	}

	public List<CheckListSetting> checkListSettingSubCategory() {
		return checkListSettingDao.checkListSettingSubCategory();
	}

	public int categoryPlus(CheckListSetting checkListSetting) {
		int checkListSettingSort = 0;
		try {
			checkListSettingSort = checkListSettingDao.getCheckListSettingCategorySort(checkListSetting.getCheckListSettingCategoryKeyNum());
		} catch (Exception e) {
		}
		checkListSetting.setCheckListSettingCategorySort(++checkListSettingSort);
		checkListSettingDao.getCheckListSettingCategorySortPlus(checkListSetting);
		checkListSettingDao.categoryPlus(checkListSetting);
		return checkListSetting.getCheckListSettingCategoryKeyNum();
	}

	public int subCategoryPlus(CheckListSetting checkListSetting) {
		int checkListSettingSort = 0;
		try {
			checkListSettingSort = checkListSettingDao.getCheckListSettingSubCategorySort(checkListSetting.getCheckListSettingSubCategoryKeyNum());
		} catch (Exception e) {
		}
		checkListSetting.setCheckListSettingSubCategorySort(++checkListSettingSort);
		checkListSettingDao.getCheckListSettingSubCategorySortPlus(checkListSetting);
		checkListSettingDao.subCategoryPlus(checkListSetting);
		return checkListSetting.getCheckListSettingSubCategoryKeyNum();
	}

	public String categorySave(CheckListSetting checkListSetting) {
		int success = checkListSettingDao.categorySave(checkListSetting);
		if(success > 0) {
			return "OK";
		}
		return "FALSE";
	}

	public String subCategorySave(CheckListSetting checkListSetting) {
		int success = checkListSettingDao.subCategorySave(checkListSetting);
		if(success > 0) {
			return "OK";
		}
		return "FALSE";
	}

	public String categoryMinus(CheckListSetting checkListSetting) {
		int success = checkListSettingDao.categoryMinus(checkListSetting);
		if(success > 0) {
			checkListSettingDao.categorySubCategoryMinus(checkListSetting);
			checkListSettingDao.categoryDetailMinus(checkListSetting);
			return "OK";
		}
		return "FALSE";
	}

	public String subCategoryMinus(CheckListSetting checkListSetting) {
		int success = checkListSettingDao.subCategoryMinus(checkListSetting);
		if(success > 0) {
			checkListSettingDao.subCategoryDetailMinus(checkListSetting);
			return "OK";
		}
		return "FALSE";
	}
	
	public CheckListSetting checkListSettingDetail(Integer checkListSettingSubCategoryKeyNum) {
		return checkListSettingDao.checkListSettingDetail(checkListSettingSubCategoryKeyNum);
	}

	public String checkListSettingDetailSave(CheckListSetting checkListSetting) {
		int success = 0; 
		if(checkListSetting.getCheckListSettingDetailKeyNum() == null) 
			success = checkListSettingDao.checkListSettingDetailInsert(checkListSetting);
		else
			success = checkListSettingDao.checkListSettingDetailUpdate(checkListSetting);
		if(success > 0) {
			return "OK";
		}
		return "FALSE";
	}
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

}
