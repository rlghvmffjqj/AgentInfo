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

	public List<CheckListSetting> checkListSettingForm(String checkListSettingType, String checkListSettingDivision) {
		CheckListSetting checkListSetting = new CheckListSetting();
		checkListSetting.setCheckListSettingType(checkListSettingType);
		checkListSetting.setCheckListSettingDivision(checkListSettingDivision);
		return checkListSettingDao.checkListSettingForm(checkListSetting);
	}

	public int formPlus(CheckListSetting checkListSetting) {
		checkListSettingDao.formPlus(checkListSetting);
		return checkListSetting.getCheckListSettingFormKeyNum();
	}

	public String formChange(CheckListSetting checkListSetting) {
		int sucess = checkListSettingDao.formChange(checkListSetting);
		if(sucess > 0) {
			return "OK";
		}
		return "FALSE";
	}

	public String formMinus(Integer checkListSettingFormKeyNum) {
		int sucess = checkListSettingDao.formMinus(checkListSettingFormKeyNum);
		if(sucess > 0) {
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
		checkListSettingDao.categoryPlus(checkListSetting);
		return checkListSetting.getCheckListSettingCategoryKeyNum();
	}

	public int subCategoryPlus(CheckListSetting checkListSetting) {
		checkListSettingDao.subCategoryPlus(checkListSetting);
		return checkListSetting.getCheckListSettingSubCategoryKeyNum();
	}

	public String categorySave(CheckListSetting checkListSetting) {
		int sucess = checkListSettingDao.categorySave(checkListSetting);
		if(sucess > 0) {
			return "OK";
		}
		return "FALSE";
	}

	public String subCategorySave(CheckListSetting checkListSetting) {
		int sucess = checkListSettingDao.subCategorySave(checkListSetting);
		if(sucess > 0) {
			return "OK";
		}
		return "FALSE";
	}

	public String categoryMinus(CheckListSetting checkListSetting) {
		int sucess = checkListSettingDao.categoryMinus(checkListSetting);
		if(sucess > 0) {
			checkListSettingDao.categorySubCategoryMinus(checkListSetting);
			checkListSettingDao.categoryDetailMinus(checkListSetting);
			return "OK";
		}
		return "FALSE";
	}

	public String subCategoryMinus(CheckListSetting checkListSetting) {
		int sucess = checkListSettingDao.subCategoryMinus(checkListSetting);
		if(sucess > 0) {
			checkListSettingDao.subCategoryDetailMinus(checkListSetting);
			return "OK";
		}
		return "FALSE";
	}
	
	public CheckListSetting checkListSettingDetail(Integer checkListSettingSubCategoryKeyNum) {
		return checkListSettingDao.checkListSettingDetail(checkListSettingSubCategoryKeyNum);
	}

	public String checkListSettingDetailSave(CheckListSetting checkListSetting) {
		int sucess = 0; 
		if(checkListSetting.getCheckListSettingDetailKeyNum() == null) 
			sucess = checkListSettingDao.checkListSettingDetailInsert(checkListSetting);
		else
			sucess = checkListSettingDao.checkListSettingDetailUpdate(checkListSetting);
		if(sucess > 0) {
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
