package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.FavoritePage;

@Repository
public class FavoritePageDao {
	@Autowired SqlSessionTemplate sqlSession;

	public void insertFavoritePage(FavoritePage favoritePage) {
		sqlSession.insert("favoritePage.insertFavoritePage", favoritePage);
	}

	public List<FavoritePage> getFavorite(String favoritePageId) {
		return sqlSession.selectList("favoritePage.getFavorite",favoritePageId);
	}

}
