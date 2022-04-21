package com.secuve.agentInfo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.UIDLogService;
import com.secuve.agentInfo.vo.UIDLog;

@Controller
public class UIDLogController {
	
	@Autowired UIDLogService uidLogService;
	
	/**
	 * 로그 리스트 페이지 이동
	 * @return
	 */
	@GetMapping(value = "/uidLog/list")
	public String UIDLogList() {
		return "uidLog/UIDLogList";
	}
	
	/**
	 * 로그 데이터 가져오기
	 * @param search
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/uidLog")
	public Map<String, Object> UIDLog(@ModelAttribute("search") UIDLog search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<UIDLog> list = new ArrayList<>(uidLogService.getUIDLogList(search));
		
		int totalCount = uidLogService.getUIDLogListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float)totalCount/search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
}
