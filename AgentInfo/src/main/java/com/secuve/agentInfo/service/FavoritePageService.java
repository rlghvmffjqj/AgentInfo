package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.FavoritePageDao;
import com.secuve.agentInfo.vo.FavoritePage;

@Service
public class FavoritePageService {
	@Autowired FavoritePageDao favoritePageDao;
	@Autowired FavoritePage favoritePage;

	public void insertFavoritePage(Principal principal, HttpServletRequest req, String favoritePageName) {
		favoritePage.setFavoritePageId(principal.getName());
		favoritePage.setFavoritePageRegistrant(principal.getName());
		favoritePage.setFavoritePageRegistrant(nowDate());
		favoritePage.setFavoritePageUrl(req.getRequestURL().toString());
		String fullUrl = req.getRequestURL().toString();
        String queryString = req.getQueryString();
        if (queryString != null) {
        	favoritePage.setFavoritePageUrl(fullUrl + "?" + queryString);
        } else {
        	favoritePage.setFavoritePageUrl(fullUrl);
        }
		favoritePage.setFavoritePageDate(nowDate());
		favoritePage.setFavoritePageIp(req.getLocalAddr());
		favoritePage.setFavoritePageName(favoritePageName);
		
		favoritePageDao.insertFavoritePage(favoritePage);
	}
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public List<FavoritePage> getFavorite(String favoritePageId) {
		return favoritePageDao.getFavorite(favoritePageId);
	}

}
