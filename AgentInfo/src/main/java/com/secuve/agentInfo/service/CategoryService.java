package com.secuve.agentInfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.CategoryDao;
import com.secuve.agentInfo.vo.Category;

@Service
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
		return categoryDao.getCategoryList(search);
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
		int categroyKeyNum = 0;
		
		if(category.getCategoryValue().equals("") || category.getCategoryValue() == "") 
			return "NotCategory";
		if(categoryDao.getCategoryCheck(category) != null)
			return "duplicateCheck";
		
		try {
			categroyKeyNum = categoryDao.getCategoryKeyNum();
		} catch (Exception e) {}
		category.setCategoryKeyNum(++categroyKeyNum);
		int sucess = categoryDao.insertCategory(category);
		
		if(sucess <= 0) 
			return "FALSE";
		return "OK";
	}

	public Category getCategoryOne(int categoryKeyNum) {
		return categoryDao.getCategoryOne(categoryKeyNum);
	}

	public String updateCategory(Category category) {
		if(category.getCategoryValue().equals("") || category.getCategoryValue() == "") 
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
		int categroyKeyNum = 0;
		try {
			categroyKeyNum = categoryDao.getCategoryKeyNum();
		} catch (Exception e) {}
		Category category = new Category();
		category.setCategoryKeyNum(++categroyKeyNum);
    	category.setCategoryName(categoryName);
    	category.setCategoryValue(categoryValue);
    	category.setCategoryRegistrant(categoryRegistrant);
    	category.setCategoryRegistrationDate(categoryRegistrationDate);
    	categoryDao.insertCategory(category);
	}
}