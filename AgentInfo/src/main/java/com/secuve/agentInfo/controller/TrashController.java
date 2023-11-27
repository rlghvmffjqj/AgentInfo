package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.TrashService;
import com.secuve.agentInfo.vo.Trash;

@Controller
public class TrashController {
	@Autowired TrashService trashService;
	@Autowired FavoritePageService favoritePageService;
	
	/**
	 * 휴지통 페이지 이동
	 * @return
	 */
	@GetMapping(value = "/trash/list")
	public String TrashList(Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "패키지 삭제 이력");
		return "trash/TrashList";
	}
	
	/**
	 * 휴지통 리스트 조회
	 * @param search
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/trash")
	public Map<String, Object> Trash(@ModelAttribute("search") Trash search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<Trash> list = new ArrayList<>(trashService.getTrashList(search));
		
		int totalCount = trashService.getTrashListCount();
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float)totalCount/search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
}