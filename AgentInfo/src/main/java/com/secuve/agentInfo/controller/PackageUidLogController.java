package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.CategoryService;
import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.PackageUidLogService;
import com.secuve.agentInfo.vo.PackageUidLog;

@Controller
public class PackageUidLogController {
	@Autowired PackageUidLogService packageUidLogService;
	@Autowired CategoryService categoryService;
	@Autowired FavoritePageService favoritePageService;
	
	/**
	 * 로그 리스트 페이지 이동
	 * @return
	 */
	@GetMapping(value = "/packageUidLog/list")
	public String PackageUidLogList(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "로그 정보 - 패키지 배포 내용 로그");
		List<String> customerName = categoryService.getCategoryValue("customerName");
		
		model.addAttribute("customerName", customerName);
		return "packageUidLog/PackageUidLogList";
	}
	
	/**
	 * 로그 데이터 가져오기
	 * @param search
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packageUidLog")
	public Map<String, Object> PackageUidLog(PackageUidLog search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<PackageUidLog> list = new ArrayList<>(packageUidLogService.getPackageUidLogList(search));
		
		int totalCount = packageUidLogService.getPackageUidLogListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float)totalCount/search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
}