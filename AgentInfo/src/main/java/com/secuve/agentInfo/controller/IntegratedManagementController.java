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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.IntegratedManagementService;
import com.secuve.agentInfo.service.PackagesService;
import com.secuve.agentInfo.service.ProductVersionService;
import com.secuve.agentInfo.vo.IntegratedManagement;
import com.secuve.agentInfo.vo.Packages;
import com.secuve.agentInfo.vo.ProductVersion;

@Controller
public class IntegratedManagementController {
	@Autowired IntegratedManagementService integratedManagementService;
	@Autowired FavoritePageService favoritePageService;	
	@Autowired PackagesService packagesService;
	@Autowired ProductVersionService productVersionService;
	
	@GetMapping(value = "/integratedManagement/list")
    public String integratedManagementList(Model model, Principal principal, HttpServletRequest req) {
        favoritePageService.insertFavoritePage(principal, req, "제품 통합 관리");

        return "integratedManagement/IntegratedManagementList";
    }
	
	@ResponseBody
	@PostMapping(value = "/integratedManagement")
	public Map<String, Object> ImPackagesList(IntegratedManagement search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<IntegratedManagement> list = new ArrayList<>(integratedManagementService.getIntegratedManagementList(search));
		int totalCount = integratedManagementService.getIntegratedManagementListCount(search);
		
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@GetMapping(value = "/integratedManagement/insertView")
	public String InsertView(Model model, Principal principal) {

		return "integratedManagement/IntegratedManagementView";
	}
	
	
	@ResponseBody
    @PostMapping(value = "/imPackagesList")
    public Map<String, Object> ImPackagesList(Packages search) {
        Map<String, Object> response = new HashMap<>();
        List<Packages> packagesList = packagesService.getPackagesList(search);
        int totalCount = packagesService.getPackagesListCount(search);

        response.put("page", search.getPage());
        response.put("total", Math.ceil((float) totalCount / search.getRows()));
        response.put("records", totalCount);
        response.put("rows", packagesList);

        return response;
    }
	
	@ResponseBody
	@PostMapping(value = "/imProductVersionList/{productData}")
	public Map<String, Object> ImProductVersionList(ProductVersion search, @RequestParam Map<String, String> paramMap) {
		String menuItemSort = productVersionService.getMenuItemSort(search.getMenuKeyNum());
		paramMap.put("menuItemSort", menuItemSort);
		Map<String, Object> response = new HashMap<>();
		
		if("productVersionKeyNum".equals(search.getSidx())) {
			search.setSidx(menuItemSort);
			paramMap.put("sidx", menuItemSort);
		}
		
		List<Map<String, Object>> productDataList = new ArrayList<Map<String, Object>>();
		int totalCount = 0;
		try {
			productDataList = productVersionService.getProductVersionList(paramMap);
			totalCount = productVersionService.getProductVersionListCount(paramMap);
		} catch (Exception e) {
			System.out.println("테이블이 생성 되지 않았습니다. 메뉴 설정에서 컬럼이 존재하는지 확인 바랍니다.");
			System.out.println(e);
		}
	
		response.put("page", search.getPage());
		response.put("total", Math.ceil((float) totalCount / search.getRows()));
		response.put("records", totalCount);
		response.put("rows", productDataList);
	
		return response;
	}
	
	
}
