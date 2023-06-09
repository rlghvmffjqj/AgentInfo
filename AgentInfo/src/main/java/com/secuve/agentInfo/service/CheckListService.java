package com.secuve.agentInfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.CheckListDao;
import com.secuve.agentInfo.vo.CheckList;

@Service
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
}
