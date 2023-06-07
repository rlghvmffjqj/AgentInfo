package com.secuve.agentInfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.CheckListSettingDao;
import com.secuve.agentInfo.vo.CheckListSetting;

@Service
public class CheckListSettingService {
	@Autowired CheckListSettingDao checkListSettingDao;

	public List<CheckListSetting> checkListSettingForm(String checkListSettingType) {
		return checkListSettingDao.checkListSettingForm(checkListSettingType);
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
		checkListSettingDao.formCategoryMinus(checkListSettingFormKeyNum);
		checkListSettingDao.formSubCategoryMinus(checkListSettingFormKeyNum);
		if(sucess > 0) {
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
			return "OK";
		}
		return "FALSE";
	}

	public void categorySubCategoryMinus(CheckListSetting checkListSetting) {
		checkListSettingDao.categorySubCategoryMinus(checkListSetting);
	}

	public String subCategoryMinus(CheckListSetting checkListSetting) {
		int sucess = checkListSettingDao.subCategoryMinus(checkListSetting);
		if(sucess > 0) {
			return "OK";
		}
		return "FALSE";
	}
}
