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
	
	public List<FunctionTestSetting> functionTestForm(String functionTestSettingDivision, String functionTestType) {
		FunctionTestSetting functionTestSetting = new FunctionTestSetting();
		if(functionTestType.equals("tortal"))
			functionTestSetting.setFunctionTestSettingSubCategoryTortal("success");
		if(functionTestType.equals("basic"))
			functionTestSetting.setFunctionTestSettingSubCategoryBasic("success");
		if(functionTestType.equals("foundation"))
			functionTestSetting.setFunctionTestSettingSubCategoryFoundation("success");
		functionTestSetting.setFunctionTestSettingDivision(functionTestSettingDivision);
		return functionTestSettingDao.functionTestForm(functionTestSetting);
	}

	public int formPlus(FunctionTestSetting functionTestSetting) {
		if(functionTestSetting.getFunctionTestSettingFormKeyNum() == 0) {
			functionTestSetting.setFunctionTestSettingFormSort(0);
		} else {
			int functionTestSettingSort = functionTestSettingDao.getFunctionTestSettingFormSort(functionTestSetting.getFunctionTestSettingFormKeyNum());
			functionTestSetting.setFunctionTestSettingFormSort(++functionTestSettingSort);
			functionTestSettingDao.getFunctionTestSettingFormSortPlus(functionTestSetting.getFunctionTestSettingFormKeyNum());
		}
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
	
	public List<FunctionTestSetting> functionTestCategory(String functionTestType) {
		FunctionTestSetting functionTestSetting = new FunctionTestSetting();
		if(functionTestType.equals("tortal"))
			functionTestSetting.setFunctionTestSettingSubCategoryTortal("success");
		if(functionTestType.equals("basic"))
			functionTestSetting.setFunctionTestSettingSubCategoryBasic("success");
		if(functionTestType.equals("foundation"))
			functionTestSetting.setFunctionTestSettingSubCategoryFoundation("success");
		return functionTestSettingDao.functionTestCategory(functionTestSetting);
	}

	public List<FunctionTestSetting> functionTestSettingSubCategory() {
		return functionTestSettingDao.functionTestSettingSubCategory();
	}
	
	public List<FunctionTestSetting> functionTestSubCategory(String functionTestType) {
		FunctionTestSetting functionTestSetting = new FunctionTestSetting();
		if(functionTestType.equals("tortal"))
			functionTestSetting.setFunctionTestSettingSubCategoryTortal("success");
		if(functionTestType.equals("basic"))
			functionTestSetting.setFunctionTestSettingSubCategoryBasic("success");
		if(functionTestType.equals("foundation"))
			functionTestSetting.setFunctionTestSettingSubCategoryFoundation("success");
		return functionTestSettingDao.functionTestSubCategory(functionTestSetting);
	}

	public int categoryPlus(FunctionTestSetting functionTestSetting) {
		int functionTestSettingSort = 0;
		try {
			functionTestSettingSort = functionTestSettingDao.getFunctionTestSettingCategorySort(functionTestSetting.getFunctionTestSettingCategoryKeyNum());
		} catch (Exception e) {
		}
		functionTestSetting.setFunctionTestSettingCategorySort(++functionTestSettingSort);
		functionTestSettingDao.getFunctionTestSettingCategorySortPlus(functionTestSetting.getFunctionTestSettingCategoryKeyNum());
		functionTestSettingDao.categoryPlus(functionTestSetting);
		return functionTestSetting.getFunctionTestSettingCategoryKeyNum();
	}

	public int subCategoryPlus(FunctionTestSetting functionTestSetting) {
		int functionTestSettingSort = 0;
		try {
			functionTestSettingSort = functionTestSettingDao.getFunctionTestSettingSubCategorySort(functionTestSetting.getFunctionTestSettingSubCategoryKeyNum());
		} catch (Exception e) {
		}
		functionTestSetting.setFunctionTestSettingSubCategorySort(++functionTestSettingSort);
		functionTestSettingDao.getFunctionTestSettingSubCategorySortPlus(functionTestSetting.getFunctionTestSettingSubCategoryKeyNum());
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

	public void updateFunctionTestSettingCheck(FunctionTestSetting functionTestSetting) {
		if(functionTestSetting.getFunctionTestSettingSubCategoryType() == "tortal" || functionTestSetting.getFunctionTestSettingSubCategoryType().equals("tortal"))
			functionTestSettingDao.updateFunctionTestSettingTortalCheck(functionTestSetting);
		if(functionTestSetting.getFunctionTestSettingSubCategoryType() == "basic" || functionTestSetting.getFunctionTestSettingSubCategoryType().equals("basic"))
			functionTestSettingDao.updateFunctionTestSettingBasicCheck(functionTestSetting);
		if(functionTestSetting.getFunctionTestSettingSubCategoryType() == "foundation" || functionTestSetting.getFunctionTestSettingSubCategoryType().equals("foundation"))
			functionTestSettingDao.updateFunctionTestSettingFoundationCheck(functionTestSetting);
	}
}
