package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.EmpDumpService;
import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.vo.empDump.IfUser;
import com.secuve.agentInfo.vo.empDump.ViewNac;
import com.secuve.agentInfo.vo.empDump.ViewSamsung;
import com.secuve.agentInfo.vo.empDump.VwUser;

@Controller
public class EmpDumpController {
	@Autowired EmpDumpService empDumpService;
	@Autowired FavoritePageService favoritePageService;
	
	@GetMapping(value = "/empDump/list")
	public String empDumpList(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "고객사 인사정보 파일");
		empDumpService.nhLifeDelete();
		empDumpService.kbankDelete();
		empDumpService.nhqvDelete();
		empDumpService.samsunglifeDelete();

		return "empDump/EmpDumpList";
	}
	
	@ResponseBody
	@PostMapping(value = "/nhlifeData")
	public Map<String, Object> empDumpNhlife(IfUser search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<IfUser> list = new ArrayList<>(empDumpService.getNHLifeData(search));
		
		
		int totalCount = empDumpService.getNHLifeDataCount();
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/kbankData")
	public Map<String, Object> empDumpKbank(VwUser search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<VwUser> list = new ArrayList<>(empDumpService.getKbankData(search));
		
		
		int totalCount = empDumpService.getKbankDataCount();
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/empDump/create")
	public String create(int empDumpCount, String empDumpCustomer) {
		return empDumpService.create(empDumpCount, empDumpCustomer);
	}
	
	@GetMapping("/empDump/empDumpDownLoad")
	public ResponseEntity<Resource> downLoad(String siteName) {
	    return empDumpService.downLoad(siteName);
	}
	
	@ResponseBody
	@PostMapping(value = "/nhqvData")
	public Map<String, Object> empDumpNhqv(ViewNac search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<ViewNac> list = new ArrayList<>(empDumpService.getNhqvData(search));
		
		
		int totalCount = empDumpService.getKbankDataCount();
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/samsunglifeData")
	public Map<String, Object> empDumpSamsunglife(ViewSamsung search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<ViewSamsung> list = new ArrayList<>(empDumpService.getSamsunglifeData(search));
		
		
		int totalCount = empDumpService.getSamsunglifeDataCount();
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
}
