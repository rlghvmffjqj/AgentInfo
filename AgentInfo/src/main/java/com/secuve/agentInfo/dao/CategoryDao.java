package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.Category;

@Repository
public class CategoryDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<String> getCategoryValue(String categoryName) {
		return sqlSession.selectList("category.getCategoryValue", categoryName);
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

	public int getCategoryKeyNum() {
		return sqlSession.selectOne("category.getCategoryKeyNum");
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

	public int getCategory(String categoryName, String categoryValue) {
		Category category = new Category();
    	category.setCategoryName(categoryName);
    	category.setCategoryValue(categoryValue);
		return sqlSession.selectOne("category.getCategoryManagementServer", category);
	}

	public void setCategory(String categoryName, String categoryValue, String categoryRegistrant, String categoryRegistrationDate) {
		Category category = new Category();
    	category.setCategoryName(categoryName);
    	category.setCategoryValue(categoryValue);
    	category.setCategoryRegistrant(categoryRegistrant);
    	category.setCategoryRegistrationDate(categoryRegistrationDate);
    	sqlSession.insert("category.insertCategory", category);
		
	}

}
