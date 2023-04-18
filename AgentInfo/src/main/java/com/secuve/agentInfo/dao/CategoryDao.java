package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.Category;
import com.secuve.agentInfo.vo.CategoryBusiness;

@Repository
public class CategoryDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<String> getCategoryValue(String categoryName) {
		return sqlSession.selectList("category.getCategoryValue", categoryName);
	}
	
	public List<String> getCategoryValue(String categoryName, String customerName) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("categoryName", categoryName);
		map.put("customerName", customerName);
		return sqlSession.selectList("category.getCategoryBusinessName", map);
	}

	public List<Category> getCategoryList(Category search) {
		return sqlSession.selectList("category.getCategoryList", search);
	}

	public int getCategoryListCount(Category search) {
		return sqlSession.selectOne("category.getCategoryListCount", search);
	}

	public int delCategory(int categoryKeyNum) {
		return sqlSession.delete("category.delCategory", categoryKeyNum);
	}

	public int insertCategory(Category category) {
		return sqlSession.insert("category.insertCategory", category);
	}

	public Category getCategoryOne(int categoryKeyNum) {
		return sqlSession.selectOne("category.getCategoryOne", categoryKeyNum);
	}

	public int updateCategory(Category category) {
		return sqlSession.update("category.updateCategory", category);
	}

	public Category getCategoryCheck(Category category) {
		return sqlSession.selectOne("category.getCategoryCheck", category);
	}

	public int getCategory(Category category) {
		return sqlSession.selectOne("category.getCategoryManagementServer", category);
	}

	public List<String> getSelectInput(String selectInput) {
		return sqlSession.selectList("category.getSelectInput", selectInput);
	}

	public List<CategoryBusiness> getCategoryBusinessList(CategoryBusiness search) {
		return sqlSession.selectList("category.getCategoryBusinessList", search);
	}

	public int getCategoryBusinessListCount(CategoryBusiness search) {
		return sqlSession.selectOne("category.getCategoryBusinessListCount", search);
	}

	public List<String> existenceBusinessCheck(CategoryBusiness category) {
		return sqlSession.selectList("category.existenceBusinessCheck", category);
	}
	
	public CategoryBusiness getCategoryBusinessCheck(CategoryBusiness category) {
		return sqlSession.selectOne("category.getCategoryBusinessCheck", category);
	}
	
	public int insertCategoryBusiness(CategoryBusiness category) {
		return sqlSession.insert("category.insertCategoryBusiness", category);
	}
	
	public int updateCategoryBusiness(CategoryBusiness category) {
		return sqlSession.insert("category.updateCategoryBusiness", category);
	}
	
	public CategoryBusiness getCategoryBusinessOne(int categoryBusinessKeyNum) {
		return sqlSession.selectOne("category.getCategoryBusinessOne", categoryBusinessKeyNum);
	}
	
	public int delCategoryBusiness(int categoryBusinessKeyNum) {
		return sqlSession.delete("category.delCategoryBusiness", categoryBusinessKeyNum);
	}

	public List<String> getCategoryBusinessNameList() {
		return sqlSession.selectList("category.getCategoryBusinessNameList");
	}

	public List<String> getCategoryCustomerBusinessName(String customerName) {
		return sqlSession.selectList("category.getCategoryCustomerBusinessName",customerName);
	}

	public int checkCustomerBusinessMapping(CategoryBusiness categoryBusiness) {
		return sqlSession.selectOne("category.checkCustomerBusinessMapping",categoryBusiness);
	}

	public List<String> getCategoryBusinessValue(String customerName) {
		return sqlSession.selectList("category.getCategoryBusinessValue", customerName);
	}

}