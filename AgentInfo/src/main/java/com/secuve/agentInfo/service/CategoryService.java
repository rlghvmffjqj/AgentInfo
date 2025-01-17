package com.secuve.agentInfo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.CategoryDao;
import com.secuve.agentInfo.dao.PackagesDao;
import com.secuve.agentInfo.vo.Category;
import com.secuve.agentInfo.vo.CategoryBusiness;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class CategoryService {
	
	@Autowired CategoryDao categoryDao;
	@Autowired PackagesDao packagesDao;
	
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
		search.setCustomerIdArr(search.getCustomerId().split(","));
		if(search.getCustomerId() != "" && search.getCustomerId() != null) {
			for(int i=0; i<search.getCustomerIdArr().length; i++) {
				search.getCustomerIdArr()[i] = String.valueOf(Integer.parseInt(search.getCustomerIdArr()[i].substring(2)));
			}
		}
		return search;
	}

	public int getCategoryListCount(Category search) {
		return categoryDao.getCategoryListCount(categroySearch(search));
	}

	public String delCategory(int[] chkList) {
		for(int categoryKeyNum: chkList) {
			Category category = categoryDao.getCategoryOne(categoryKeyNum);
			List<String> packagesOneList = packagesDao.getCategoryCustomerNameList(category);
			if(packagesOneList.size() > 0) {
				return "VALIDATION";
			}
		}
		
		for(int categoryKeyNum: chkList) {
			int success = categoryDao.delCategory(categoryKeyNum);
			if(success <= 0) 
				return "FALSE";
		}
		return "OK";
	}

	public String insertCategory(Category category) {
		if(category.getCategoryValueView().equals("") || category.getCategoryValueView() == "") 
			return "NotCategory";
		if(categoryDao.getCategoryCheck(category) != null)
			return "duplicateCheck";
		
		int success = categoryDao.insertCategory(category);
		
		if(success <= 0) 
			return "FALSE";
		return "OK";
	}

	public Category getCategoryOne(int categoryKeyNum) {
		return categoryDao.getCategoryOne(categoryKeyNum);
	}

	public String updateCategory(Category category) {
		String categoryName = category.getCategoryName();
		String categoryValueNew = category.getCategoryValueView();
		String categoryValue = categoryDao.getCategoryOne(category.getCategoryKeyNum()).getCategoryValue();
		
		if(category.getCategoryValueView().equals("") || category.getCategoryValueView() == "") 
			return "NotCategory";
		if(!categoryValueNew.equals(categoryValue)) {
			if(categoryDao.getCategoryCheck(category) != null)
				return "duplicateCheck";
		}
		int success = categoryDao.updateCategory(category);
		
		if(success <= 0) 
			return "FALSE";
		
		categoryDao.updateCategoryBusinessAll(categoryValue, categoryValueNew);
		packagesDao.updateCategoryNameAll(categoryName, categoryValue, categoryValueNew);
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
    	category.setCategoryValueView(categoryValue);
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

	public List<CategoryBusiness> getCategoryBusinessList(CategoryBusiness search) {
		search.setCategoryCustomerNameArr(search.getCategoryCustomerName().split(","));
		search.setCategoryBusinessNameArr(search.getCategoryBusinessName().split(","));
		return categoryDao.getCategoryBusinessList(search);
	}

	public int getCategoryBusinessListCount(CategoryBusiness search) {
		search.setCategoryCustomerNameArr(search.getCategoryCustomerName().split(","));
		search.setCategoryBusinessNameArr(search.getCategoryBusinessName().split(","));
		return categoryDao.getCategoryBusinessListCount(search);
	}

	public List<String> existenceBusinessCheckInsert(CategoryBusiness category) {
		List<String> categoryBusinessNameList = new ArrayList<String>();
		List<String> categoryBusinessNameAllList =  categoryDao.existenceBusinessCheck(category);
		
		for(String categoryBusinessName: categoryBusinessNameAllList) {
			if(categoryBusinessName.replaceAll(" ", "").contains(category.getCategoryBusinessNameView().replaceAll(" ", ""))) {
				categoryBusinessNameList.add(categoryBusinessName);
			} else if(category.getCategoryBusinessNameView().replaceAll(" ", "").contains(categoryBusinessName.replaceAll(" ", ""))) {
				categoryBusinessNameList.add(categoryBusinessName);
			}
		}
		return categoryBusinessNameList;
	}

	public List<String> existenceBusinessCheckUpdate(CategoryBusiness category) {
		List<String> categoryBusinessNameList = new ArrayList<String>();
		List<String> categoryBusinessNameAllList =  categoryDao.existenceBusinessCheck(category);
		
		for(String categoryBusinessName: categoryBusinessNameAllList) {
			if(categoryBusinessName.replaceAll(" ", "").contains(category.getCategoryBusinessNameView().replaceAll(" ", ""))) {
				categoryBusinessNameList.add(categoryBusinessName);
			} else if(category.getCategoryBusinessNameView().replaceAll(" ", "").contains(categoryBusinessName.replaceAll(" ", ""))) {
				categoryBusinessNameList.add(categoryBusinessName);
			}
		}
		return categoryBusinessNameList;
	}

	public String insertCategoryBusiness(CategoryBusiness category) {
		if(category.getCategoryCustomerNameView().equals("") || category.getCategoryCustomerNameView() == "") 
			return "NotCategoryCustomerName";
		if(category.getCategoryBusinessNameView().equals("") || category.getCategoryBusinessNameView() == "") 
			return "NotCategoryBusinessName";
		if(categoryDao.getCategoryBusinessCheck(category) != null)
			return "duplicateCheck";
		
		int success = categoryDao.insertCategoryBusiness(category);
		
		if(success <= 0) 
			return "FALSE";
		return "OK";
	}

	public String updateCategoryBusiness(CategoryBusiness category) {
		String categoryCustomerName = category.getCategoryCustomerNameView();
		String categoryBusinessNameNew = category.getCategoryBusinessNameView();
		String categoryBusinessName = categoryDao.getCategoryBusinessOne(category.getCategoryBusinessKeyNum()).getCategoryBusinessName();
		
		if(category.getCategoryCustomerNameView().equals("") || category.getCategoryCustomerNameView() == "") 
			return "NotCategoryCustomerName";
		if(category.getCategoryBusinessNameView().equals("") || category.getCategoryBusinessNameView() == "") 
			return "NotCategoryBusinessName";
		if(!categoryBusinessNameNew.equals(categoryBusinessName)) {
			if(categoryDao.getCategoryBusinessCheck(category) != null)
				return "duplicateCheck";
		}
		
		int success = categoryDao.updateCategoryBusiness(category);
		
		if(success <= 0) 
			return "FALSE";
		
		packagesDao.updateBussinessNameAll(categoryCustomerName, categoryBusinessName, categoryBusinessNameNew);
		return "OK";
	}

	public CategoryBusiness getCategoryBusinessOne(int categoryBusinessKeyNum) {
		return categoryDao.getCategoryBusinessOne(categoryBusinessKeyNum);
	}

	public String delCategoryBusiness(int[] chkList) {
		for(int categoryBusinessKeyNum: chkList) {
			CategoryBusiness categoryBusiness = categoryDao.getCategoryBusinessOne(categoryBusinessKeyNum);
			List<String> packagesOneList = packagesDao.getCategoryBusinessCustomerNameList(categoryBusiness);
			if(packagesOneList.size() > 0) {
				return "VALIDATION";
			}
		}
		
		for(int categoryBusinessKeyNum: chkList) {
			int success = categoryDao.delCategoryBusiness(categoryBusinessKeyNum);
			if(success <= 0) 
				return "FALSE";
		}
		return "OK";
	}

	public List<String> getCategoryBusinessNameList() {
		return categoryDao.getCategoryBusinessNameList();
	}

	public List<String> getCategoryCustomerBusinessName(String customerName) {
		return categoryDao.getCategoryCustomerBusinessName(customerName);
	}

	public void insertCustomerBusinessMapping(String customerNameView, String businessNameView) {
		if(businessNameView == "" || businessNameView == null) {
			return;
		}
		CategoryBusiness categoryBusiness = new CategoryBusiness();
		categoryBusiness.setCategoryCustomerNameView(customerNameView);
		categoryBusiness.setCategoryBusinessNameView(businessNameView);
		if(categoryBusiness.getCategoryBusinessNameView() != "") {
			int count = categoryDao.checkCustomerBusinessMapping(categoryBusiness);
			if(count <= 0) {
				categoryDao.insertCategoryBusiness(categoryBusiness);
			}
		}
	}

	public List<String> getCategoryBusinessValue(String customerName) {
		return categoryDao.getCategoryBusinessValue(customerName);
	}

	public List<String> getCategoryKeyNum() {
		List<Integer> categoryKeyNumList = categoryDao.getCategoryKeyNum();
		List<String> customerIdList = new ArrayList<String>();
		String customerId = "S_";
		for(int i=0; i<categoryKeyNumList.size(); i++) {
			for(int j=categoryKeyNumList.get(i).toString().length(); j<5; j++) {
				customerId += "0";
			}
			customerIdList.add(customerId + categoryKeyNumList.get(i).toString());
			customerId = "S_";
		}
		return customerIdList;
	}

	public List<String> getCategoryMergeList(int[] chkList) {
		List<String> categoryMergeList = new ArrayList<String>();
		for(int categoryKeyNum : chkList) {
			categoryMergeList.add(categoryDao.getCategoryOne(categoryKeyNum).getCategoryValue());
		}
		return categoryMergeList;
	}

	public String updateMerge(int[] chkList, String categoryName, String categoryValueView) {
		int success = 1;
		String categoryValue = "";
		int selectCategoryKeyNum = categoryDao.getCategoryKeyNumOne(categoryName, categoryValueView);
		for(int categoryKeyNum: chkList) {
			if(selectCategoryKeyNum != categoryKeyNum) {
				categoryValue = categoryDao.getCategoryOne(categoryKeyNum).getCategoryValue();
				packagesDao.updateCategoryNameAll(categoryName, categoryValue, categoryValueView);
				categoryDao.updateCategoryBusinessAll(categoryValue, categoryValueView);
				
				success *= categoryDao.delCategory(categoryKeyNum);
			}
		}
		if(success <= 0) 
			return "FALSE";
		return "OK";
	}

	public List<String> getCategoryBusinessMergeList(int[] chkList) {
		List<String> categoryBusinessMergeList = new ArrayList<String>();
		for(int categoryBusinessKeyNum : chkList) {
			categoryBusinessMergeList.add(categoryDao.getCategoryBusinessOne(categoryBusinessKeyNum).getCategoryBusinessName());
		}
		return categoryBusinessMergeList;
	}

	public String updateBusinessMerge(int[] chkList, String categoryBusinessNameView) {
		int success = 1;
		String categoryBusinessName = "";
		String categoryCustomerName = categoryDao.getCategoryBusinessOne(chkList[0]).getCategoryCustomerName();
		int selectCategoryBusinessKeyNum = categoryDao.getCategoryBusinessKeyNumOne(categoryCustomerName, categoryBusinessNameView);
		for(int categoryBusinessKeyNum: chkList) {
			if(selectCategoryBusinessKeyNum != categoryBusinessKeyNum) {
				categoryBusinessName = categoryDao.getCategoryBusinessOne(categoryBusinessKeyNum).getCategoryBusinessName();
				packagesDao.updateBussinessNameAll(categoryCustomerName, categoryBusinessName, categoryBusinessNameView);
				success *= categoryDao.delCategoryBusiness(categoryBusinessKeyNum);
			}
		}
		if(success <= 0) 
			return "FALSE";
		return "OK";
	}

	public String mergeCheck(int[] chkList) {
		String categoryCustomerName = categoryDao.getCategoryBusinessOne(chkList[0]).getCategoryCustomerName();
		for(int categoryBusinessKeyNum : chkList) {
			if(!categoryCustomerName.equals(categoryDao.getCategoryBusinessOne(categoryBusinessKeyNum).getCategoryCustomerName())) {
				return "FALSE";
			}
		}
		return "OK";
	}

}