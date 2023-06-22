package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.FunctionTestSetting;

@Repository
public class FunctionTestSettingDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<FunctionTestSetting> functionTestSettingForm(FunctionTestSetting functionTestSetting) {
		return sqlSession.selectList("functionTestSetting.functionTestSettingForm", functionTestSetting);
	}
	
	public List<FunctionTestSetting> functionTestForm(FunctionTestSetting functionTestSetting) {
		return sqlSession.selectList("functionTestSetting.functionTestForm", functionTestSetting);
	}

	public int formPlus(FunctionTestSetting functionTestSetting) {
		return sqlSession.insert("functionTestSetting.formPlus", functionTestSetting);
	}

	public int formChange(FunctionTestSetting functionTestSetting) {
		return sqlSession.update("functionTestSetting.formChange", functionTestSetting);
	}

	public int formMinus(Integer functionTestSettingFormKeyNum) {
		return sqlSession.delete("functionTestSetting.formMinus", functionTestSettingFormKeyNum);
	}

	public List<FunctionTestSetting> functionTestSettingCategory() {
		return sqlSession.selectList("functionTestSetting.functionTestSettingCategory");
	}
	
	public List<FunctionTestSetting> functionTestCategory(FunctionTestSetting functionTestSetting) {
		return sqlSession.selectList("functionTestSetting.functionTestCategory", functionTestSetting);
	}

	public List<FunctionTestSetting> functionTestSettingSubCategory() {
		return sqlSession.selectList("functionTestSetting.functionTestSettingSubCategory");
	}
	
	public List<FunctionTestSetting> functionTestSubCategory(FunctionTestSetting functionTestSetting) {
		return sqlSession.selectList("functionTestSetting.functionTestSubCategory",functionTestSetting);
	}

	public int categoryPlus(FunctionTestSetting functionTestSetting) {
		return sqlSession.insert("functionTestSetting.categoryPlus", functionTestSetting);
	}

	public int subCategoryPlus(FunctionTestSetting functionTestSetting) {
		return sqlSession.insert("functionTestSetting.subCategoryPlus", functionTestSetting);
	}

	public void formCategoryMinus(Integer functionTestSettingFormKeyNum) {
		sqlSession.delete("functionTestSetting.formCategoryMinus", functionTestSettingFormKeyNum);
	}

	public void formSubCategoryMinus(Integer functionTestSettingFormKeyNum) {
		sqlSession.delete("functionTestSetting.formSubCategoryMinus", functionTestSettingFormKeyNum);
	}

	public int categorySave(FunctionTestSetting functionTestSetting) {
		return sqlSession.update("functionTestSetting.categorySave", functionTestSetting);
	}

	public int subCategorySave(FunctionTestSetting functionTestSetting) {
		return sqlSession.update("functionTestSetting.subCategorySave", functionTestSetting);
	}

	public int categoryMinus(FunctionTestSetting functionTestSetting) {
		return sqlSession.delete("functionTestSetting.categoryMinus", functionTestSetting);
	}

	public void categorySubCategoryMinus(FunctionTestSetting functionTestSetting) {
		sqlSession.delete("functionTestSetting.categorySubCategoryMinus", functionTestSetting);
	}

	public int subCategoryMinus(FunctionTestSetting functionTestSetting) {
		return sqlSession.delete("functionTestSetting.subCategoryMinus", functionTestSetting);
	}

	public FunctionTestSetting functionTestSettingDetail(Integer functionTestSettingSubCategoryKeyNum) {
		return sqlSession.selectOne("functionTestSetting.functionTestSettingDetail",functionTestSettingSubCategoryKeyNum);
	}

	public int functionTestSettingDetailInsert(FunctionTestSetting functionTestSetting) {
		return sqlSession.insert("functionTestSetting.functionTestSettingDetailInsert",functionTestSetting);
	}

	public int functionTestSettingDetailUpdate(FunctionTestSetting functionTestSetting) {
		return sqlSession.update("functionTestSetting.functionTestSettingDetailUpdate",functionTestSetting);
	}

	public void formDetailMinus(Integer functionTestSettingFormKeyNum) {
		sqlSession.delete("functionTestSetting.formDetailMinus", functionTestSettingFormKeyNum);
	}

	public void categoryDetailMinus(FunctionTestSetting functionTestSetting) {
		sqlSession.delete("functionTestSetting.categoryDetailMinus", functionTestSetting);
	}

	public void subCategoryDetailMinus(FunctionTestSetting functionTestSetting) {
		sqlSession.delete("functionTestSetting.subCategoryDetailMinus", functionTestSetting);
	}

	public void updateFunctionTestSettingTortalCheck(FunctionTestSetting functionTestSetting) {
		sqlSession.update("functionTestSetting.updateFunctionTestSettingTortalCheck",functionTestSetting);
	}

	public void updateFunctionTestSettingBasicCheck(FunctionTestSetting functionTestSetting) {
		sqlSession.update("functionTestSetting.updateFunctionTestSettingBasicCheck",functionTestSetting);
	}

	public void updateFunctionTestSettingFoundationCheck(FunctionTestSetting functionTestSetting) {
		sqlSession.update("functionTestSetting.updateFunctionTestSettingFoundationCheck",functionTestSetting);
	}

}
