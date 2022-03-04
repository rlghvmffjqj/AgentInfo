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
		if(category.getCategoryValue().equals("") || category.getCategoryValue() == "") 
			return "NotCategory";
		if(categoryDao.getCategoryCheck(category) != null)
			return "duplicateCheck";
		
		category.setCategoryKeyNum(categoryDao.getCategoryKeyNum()+1);
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

}
