package com.secuve.agentInfo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.CategoryDao;
import com.secuve.agentInfo.vo.Category;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class CategoryService {
	
	@Autowired
	CategoryDao categoryDao;
	
	public List<String> getCategoryValue(String categoryName) {
		return categoryDao.getCategoryValue(categoryName);
	}
	
	public List<String> getCategoryValue(String categoryName, String customerName) {
		return categoryDao.getCategoryValue(categoryName, customerName);
	}

	public List<Category> getCategoryList(Category search) {
		return categoryDao.getCategoryList(categroySearch(search));
	}
	
	public Category categroySearch(Category search) {
		search.setCategoryValueArr(search.getCategoryValue().split(","));
		return search;
	}

	public int getCategoryListCount(Category search) {
		return categoryDao.getCategoryListCount(search);
	}

	public String delCategory(int[] chkList) {
		for(int categoryKeyNum: chkList) {
			int sucess = categoryDao.delCategory(categoryKeyNum);
			if(sucess <= 0) 
				return "FALSE";
		}
		return "OK";
	}

	public String insertCategory(Category category) {
		if(category.getCategoryValueView().equals("") || category.getCategoryValueView() == "") 
			return "NotCategory";
		if(categoryDao.getCategoryCheck(category) != null)
			return "duplicateCheck";
		
		int sucess = categoryDao.insertCategory(category);
		
		if(sucess <= 0) 
			return "FALSE";
		return "OK";
	}

	public Category getCategoryOne(int categoryKeyNum) {
		return categoryDao.getCategoryOne(categoryKeyNum);
	}

	public String updateCategory(Category category) {
		if(category.getCategoryValueView().equals("") || category.getCategoryValueView() == "") 
			return "NotCategory";
		if(categoryDao.getCategoryCheck(category) != null)
			return "duplicateCheck";
		int sucess = categoryDao.updateCategory(category);
		
		if(sucess <= 0) 
			return "FALSE";
		return "OK";
	}
	
	public int getCategory(String categoryName, String categoryValue) {
		Category category = new Category();
    	category.setCategoryName(categoryName);
    	category.setCategoryValue(categoryValue);
		return categoryDao.getCategory(category);
	}

	public void setCategory(String categoryName, String categoryValue, String categoryRegistrant, String categoryRegistrationDate) {
		if(categoryValue == "" || categoryValue == null || categoryValue.equals("") || categoryValue.equals(null) || categoryValue.length() == 0) {
			return;
		}
		Category category = new Category();
    	category.setCategoryName(categoryName);
    	category.setCategoryValue(categoryValue);
    	category.setCategoryRegistrant(categoryRegistrant);
    	category.setCategoryRegistrationDate(categoryRegistrationDate);
    	categoryDao.insertCategory(category);
	}

	public List<String> getSelectInput(String selectInput) {
		return categoryDao.getSelectInput(selectInput);
	}

	public List<String> existenceCheckInsert(Category category) {
		List<String> categoryValueList = new ArrayList<String>();
		
		List<String> categoryNameList = categoryDao.getCategoryValue(category.getCategoryName());
		for(String categoryName: categoryNameList) {
			if(categoryName.replaceAll(" ", "").contains(category.getCategoryValueView().replaceAll(" ", ""))) {
				categoryValueList.add(categoryName);
			} else if(category.getCategoryValueView().replaceAll(" ", "").contains(categoryName.replaceAll(" ", ""))) {
				categoryValueList.add(categoryName);
			}
		}
		return categoryValueList;
	}

	public List<String> existenceCheckUpdate(Category category) {
		List<String> categoryValueList = new ArrayList<String>();
		
		List<String> categoryNameList = categoryDao.getCategoryValue(category.getCategoryName());
		for(String categoryName: categoryNameList) {
			if(categoryName.replaceAll(" ", "").contains(category.getCategoryValueView().replaceAll(" ", ""))) {
				categoryValueList.add(categoryName);
			} else if(category.getCategoryValueView().replaceAll(" ", "").contains(categoryName.replaceAll(" ", ""))) {
				categoryValueList.add(categoryName);
			}
		}
		return categoryValueList;
	}
}