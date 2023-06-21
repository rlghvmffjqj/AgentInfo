package com.secuve.agentInfo.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.FunctionTestSettingDao;
import com.secuve.agentInfo.vo.FunctionTestSetting;

@Service
public class FunctionTestSettingService {
	@Autowired FunctionTestSettingDao functionTestSettingDao;

	public List<FunctionTestSetting> functionTestSettingForm(String functionTestSettingDivision) {
		FunctionTestSetting functionTestSetting = new FunctionTestSetting();
		functionTestSetting.setFunctionTestSettingDivision(functionTestSettingDivision);
		return functionTestSettingDao.functionTestSettingForm(functionTestSetting);
	}

	public int formPlus(FunctionTestSetting functionTestSetting) {
		functionTestSettingDao.formPlus(functionTestSetting);
		return functionTestSetting.getFunctionTestSettingFormKeyNum();
	}

	public String formChange(FunctionTestSetting functionTestSetting) {
		int sucess = functionTestSettingDao.formChange(functionTestSetting);
		if(sucess > 0) {
			return "OK";
		}
		return "FALSE";
	}

	public String formMinus(Integer functionTestSettingFormKeyNum) {
		int sucess = functionTestSettingDao.formMinus(functionTestSettingFormKeyNum);
		if(sucess > 0) {
			functionTestSettingDao.formCategoryMinus(functionTestSettingFormKeyNum);
			functionTestSettingDao.formSubCategoryMinus(functionTestSettingFormKeyNum);
			functionTestSettingDao.formDetailMinus(functionTestSettingFormKeyNum);
			return "OK";
		}
		return "FALSE";
	}

	public List<FunctionTestSetting> functionTestSettingCategory() {
		return functionTestSettingDao.functionTestSettingCategory();
	}

	public List<FunctionTestSetting> functionTestSettingSubCategory() {
		return functionTestSettingDao.functionTestSettingSubCategory();
	}

	public int categoryPlus(FunctionTestSetting functionTestSetting) {
		functionTestSettingDao.categoryPlus(functionTestSetting);
		return functionTestSetting.getFunctionTestSettingCategoryKeyNum();
	}

	public int subCategoryPlus(FunctionTestSetting functionTestSetting) {
		functionTestSettingDao.subCategoryPlus(functionTestSetting);
		return functionTestSetting.getFunctionTestSettingSubCategoryKeyNum();
	}

	public String categorySave(FunctionTestSetting functionTestSetting) {
		int sucess = functionTestSettingDao.categorySave(functionTestSetting);
		if(sucess > 0) {
			return "OK";
		}
		return "FALSE";
	}

	public String subCategorySave(FunctionTestSetting functionTestSetting) {
		int sucess = functionTestSettingDao.subCategorySave(functionTestSetting);
		if(sucess > 0) {
			return "OK";
		}
		return "FALSE";
	}

	public String categoryMinus(FunctionTestSetting functionTestSetting) {
		int sucess = functionTestSettingDao.categoryMinus(functionTestSetting);
		if(sucess > 0) {
			functionTestSettingDao.categorySubCategoryMinus(functionTestSetting);
			functionTestSettingDao.categoryDetailMinus(functionTestSetting);
			return "OK";
		}
		return "FALSE";
	}

	public String subCategoryMinus(FunctionTestSetting functionTestSetting) {
		int sucess = functionTestSettingDao.subCategoryMinus(functionTestSetting);
		if(sucess > 0) {
			functionTestSettingDao.subCategoryDetailMinus(functionTestSetting);
			return "OK";
		}
		return "FALSE";
	}
	
	public FunctionTestSetting functionTestSettingDetail(Integer functionTestSettingSubCategoryKeyNum) {
		return functionTestSettingDao.functionTestSettingDetail(functionTestSettingSubCategoryKeyNum);
	}

	public String functionTestSettingDetailSave(FunctionTestSetting functionTestSetting) {
		int sucess = 0; 
		if(functionTestSetting.getFunctionTestSettingDetailKeyNum() == null) 
			sucess = functionTestSettingDao.functionTestSettingDetailInsert(functionTestSetting);
		else
			sucess = functionTestSettingDao.functionTestSettingDetailUpdate(functionTestSetting);
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
