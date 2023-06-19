package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.CheckListDao;
import com.secuve.agentInfo.vo.CheckList;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class CheckListService {
	@Autowired CheckListDao checkListDao;

	public List<CheckList> getCheckList(CheckList search) {
		return checkListDao.getCheckList(checkListSearch(search));
	}

	public int getCheckListCount(CheckList search) {
		return checkListDao.getCheckListCount(checkListSearch(search));
	}
	
	public CheckList checkListSearch(CheckList search) {
		search.setCheckListCustomerArr(search.getCheckListCustomer().split(","));
		search.setCheckListTitleArr(search.getCheckListTitle().split(","));
		
		return search;
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public Map insertCheckList(CheckList checkList, Principal principal) {
		Map map = new HashMap();
		checkList.setCheckListKeyNum(CheckListKeyNum(checkList.getCheckListKeyNum()));
		map.put("checkListKeyNum", checkList.getCheckListKeyNum());
		
		int sucess = 1;
		checkList = oneDate(checkList);
		for(int i=0; i < checkList.getCheckListSubCategoryStateList().size(); i++) {
			sucess *= checkListDao.insertCheckList(checkList.getCheckListKeyNum(), checkList.getCheckListCustomer(), checkList.getCheckListTitle(), checkList.getCheckListDate(), checkList.getCheckListSettingSubCategoryKeyNumList().get(i), checkList.getCheckListSubCategoryStateList().get(i), checkList.getCheckListSubCategoryFailReasonList().get(i), checkList.getCheckListRegistrant(), checkList.getCheckListRegistrationDate(), checkList.getCheckListModifier(), checkList.getCheckListModifiedDate());
		}
		if (sucess <= 0) {
			map.put("result", "FALSE");
		} else {
			map.put("result", "OK");
			map.put("checkListKeyNum", checkList.getCheckListKeyNum());
		}
		return map;
	}
	
	public CheckList oneDate(CheckList checkList) {
		List<String> list = new ArrayList<String>();
		List<Integer> list2 = new ArrayList<Integer>();
		list.add("");
		list2.add(0);
		if(checkList.getCheckListSettingSubCategoryKeyNumList().size() == 0) 
			checkList.setCheckListSettingSubCategoryKeyNumList(list2);
		if(checkList.getCheckListSubCategoryStateList().size() == 0) 
			checkList.setCheckListSubCategoryStateList(list);
		if(checkList.getCheckListSubCategoryFailReasonList().size() == 0) 
			checkList.setCheckListSubCategoryFailReasonList(list);
		
		return checkList;
	}
	
	public int CheckListKeyNum(int checkListKeyNum) {
		if(checkListKeyNum == 0) {
			checkListKeyNum = 1;
		} else {
			return checkListKeyNum;
		}
		try {
			checkListKeyNum = checkListDao.getCheckListKeyNum();
		} catch (Exception e) {
			return checkListKeyNum;
		}
		return ++checkListKeyNum;
	}

	public CheckList getCheckListOneTitle(int checkListKeyNum) {
		return checkListDao.getCheckListOneTitle(checkListKeyNum);
	}

	public List<CheckList> getCheckListOne(int checkListKeyNum) {
		return checkListDao.getCheckListOne(checkListKeyNum);
	}
}
