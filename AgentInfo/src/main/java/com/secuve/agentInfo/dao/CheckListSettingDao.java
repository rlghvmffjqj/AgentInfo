package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.CheckListSetting;

@Repository
public class CheckListSettingDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<CheckListSetting> checkListSettingForm(CheckListSetting checkListSetting) {
		return sqlSession.selectList("checkListSetting.checkListSettingForm", checkListSetting);
	}

	public int formPlus(CheckListSetting checkListSetting) {
		return sqlSession.insert("checkListSetting.formPlus", checkListSetting);
	}

	public int formChange(CheckListSetting checkListSetting) {
		return sqlSession.update("checkListSetting.formChange", checkListSetting);
	}

	public int formMinus(Integer checkListSettingFormKeyNum) {
		return sqlSession.delete("checkListSetting.formMinus", checkListSettingFormKeyNum);
	}

	public List<CheckListSetting> checkListSettingCategory() {
		return sqlSession.selectList("checkListSetting.checkListSettingCategory");
	}

	public List<CheckListSetting> checkListSettingSubCategory() {
		return sqlSession.selectList("checkListSetting.checkListSettingSubCategory");
	}

	public int categoryPlus(CheckListSetting checkListSetting) {
		return sqlSession.insert("checkListSetting.categoryPlus", checkListSetting);
	}

	public int subCategoryPlus(CheckListSetting checkListSetting) {
		return sqlSession.insert("checkListSetting.subCategoryPlus", checkListSetting);
	}

	public void formCategoryMinus(Integer checkListSettingFormKeyNum) {
		sqlSession.delete("checkListSetting.formCategoryMinus", checkListSettingFormKeyNum);
	}

	public void formSubCategoryMinus(Integer checkListSettingFormKeyNum) {
		sqlSession.delete("checkListSetting.formSubCategoryMinus", checkListSettingFormKeyNum);
	}

	public int categorySave(CheckListSetting checkListSetting) {
		return sqlSession.update("checkListSetting.categorySave", checkListSetting);
	}

	public int subCategorySave(CheckListSetting checkListSetting) {
		return sqlSession.update("checkListSetting.subCategorySave", checkListSetting);
	}

	public int categoryMinus(CheckListSetting checkListSetting) {
		return sqlSession.delete("checkListSetting.categoryMinus", checkListSetting);
	}

	public void categorySubCategoryMinus(CheckListSetting checkListSetting) {
		sqlSession.delete("checkListSetting.categorySubCategoryMinus", checkListSetting);
	}

	public int subCategoryMinus(CheckListSetting checkListSetting) {
		return sqlSession.delete("checkListSetting.subCategoryMinus", checkListSetting);
	}

	public CheckListSetting checkListSettingDetail(Integer checkListSettingSubCategoryKeyNum) {
		return sqlSession.selectOne("checkListSetting.checkListSettingDetail",checkListSettingSubCategoryKeyNum);
	}

	public int checkListSettingDetailInsert(CheckListSetting checkListSetting) {
		return sqlSession.insert("checkListSetting.checkListSettingDetailInsert",checkListSetting);
	}

	public int checkListSettingDetailUpdate(CheckListSetting checkListSetting) {
		return sqlSession.update("checkListSetting.checkListSettingDetailUpdate",checkListSetting);
	}

	public void formDetailMinus(Integer checkListSettingFormKeyNum) {
		sqlSession.delete("checkListSetting.formDetailMinus", checkListSettingFormKeyNum);
	}

	public void categoryDetailMinus(CheckListSetting checkListSetting) {
		sqlSession.delete("checkListSetting.categoryDetailMinus", checkListSetting);
	}

	public void subCategoryDetailMinus(CheckListSetting checkListSetting) {
		sqlSession.delete("checkListSetting.subCategoryDetailMinus", checkListSetting);
	}

	public int getCheckListSettingFormSort(Integer checkListSettingFormKeyNum) {
		return sqlSession.selectOne("checkListSetting.getCheckListSettingFormSort",checkListSettingFormKeyNum);
	}

	public void getCheckListSettingFormSortPlus(CheckListSetting checkListSetting) {
		sqlSession.update("checkListSetting.getCheckListSettingFormSortPlus",checkListSetting);		
	}

	public int getCheckListSettingCategorySort(Integer checkListSettingCategoryKeyNum) {
		return sqlSession.selectOne("checkListSetting.getCheckListSettingCategorySort",checkListSettingCategoryKeyNum);
	}

	public void getCheckListSettingCategorySortPlus(CheckListSetting checkListSetting) {
		sqlSession.update("checkListSetting.getCheckListSettingCategorySortPlus",checkListSetting);
	}

	public int getCheckListSettingSubCategorySort(Integer checkListSettingSubCategoryKeyNum) {
		return sqlSession.selectOne("checkListSetting.getCheckListSettingSubCategorySort",checkListSettingSubCategoryKeyNum);
	}

	public void getCheckListSettingSubCategorySortPlus(CheckListSetting checkListSetting) {
		sqlSession.update("checkListSetting.getCheckListSettingSubCategorySortPlus",checkListSetting);
	}

}
