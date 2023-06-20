package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.CheckList;

@Repository
public class CheckListDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<CheckList> getCheckList(CheckList search) {
		return sqlSession.selectList("checkList.getCheckList", search);
	}

	public int getCheckListCount(CheckList search) {
		return sqlSession.selectOne("checkList.getCheckListCount", search);
	}

	public int getCheckListKeyNum() {
		return sqlSession.selectOne("checkList.getCheckListKeyNum");
	}

	public int insertCheckList(Integer checkListKeyNum, String checkListCustomer, String checkListTitle,
			String checkListDate, Integer checkListSettingSubCategoryKeyNum, String checkListSubCategoryState, String checkListSubCategoryFailReason, String checkListRegistrant,
			String checkListRegistrationDate, String checkListModifier, String checkListModifiedDate) {

		CheckList checkList = new CheckList();
		checkList.setCheckListKeyNum(checkListKeyNum);
		checkList.setCheckListCustomer(checkListCustomer);
		checkList.setCheckListTitle(checkListTitle);
		checkList.setCheckListDate(checkListDate);
		checkList.setCheckListSettingSubCategoryKeyNum(checkListSettingSubCategoryKeyNum);
		checkList.setCheckListSubCategoryState(checkListSubCategoryState);
		checkList.setCheckListSubCategoryFailReason(checkListSubCategoryFailReason);
		checkList.setCheckListRegistrant(checkListRegistrant);
		checkList.setCheckListRegistrationDate(checkListRegistrationDate);
		checkList.setCheckListModifier(checkListModifier);
		checkList.setCheckListModifiedDate(checkListModifiedDate);
		
		return sqlSession.insert("checkList.insertCheckList", checkList);
	}

	public CheckList getCheckListOneTitle(int checkListKeyNum) {
		return sqlSession.selectOne("checkList.getCheckListOneTitle", checkListKeyNum);
	}

	public List<CheckList> getCheckListOne(int checkListKeyNum) {
		return sqlSession.selectList("checkList.getCheckListOne", checkListKeyNum);
	}

	public int delCheckList(int checkListKeyNum) {
		return sqlSession.delete("checkList.delCheckList", checkListKeyNum);
	}
	
	public List<Integer> checkListCheckListSettingSubCategoryKeyNum(int checkListKeyNum) {
		return sqlSession.selectList("checkList.checkListCheckListSettingSubCategoryKeyNum",checkListKeyNum);
	}
}
