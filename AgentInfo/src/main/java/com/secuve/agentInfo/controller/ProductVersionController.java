package com.secuve.agentInfo.controller;

import java.net.UnknownHostException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.server.ResponseStatusException;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.MenuSettingService;
import com.secuve.agentInfo.service.ProductVersionService;
import com.secuve.agentInfo.vo.Compatibility;
import com.secuve.agentInfo.vo.MenuSetting;
import com.secuve.agentInfo.vo.ProductVersion;

@Controller
public class ProductVersionController {
	@Autowired FavoritePageService favoritePageService;
	@Autowired ProductVersionService productVersionService;
	@Autowired MenuSettingService menuSettingService;
	
	@GetMapping(value = "/productVersion/{mainTitle}")
    public String productVersionList(Model model, Principal principal, HttpServletRequest req, @PathVariable("mainTitle") String mainTitle, String subTitle, String number) throws JsonProcessingException {
		int nonExist = productVersionService.getProductVersionNoneExist(mainTitle, subTitle);
		if (nonExist == 0) {
	        throw new ResponseStatusException(HttpStatus.NOT_FOUND, "해당 메뉴 정보가 존재하지 않습니다.");
	    }
		if(subTitle == "" || subTitle == null) {
			favoritePageService.insertFavoritePage(principal, req, mainTitle);
			model.addAttribute("menuTitle", mainTitle);
			model.addAttribute("menuType", "main");
		} else {
			favoritePageService.insertFavoritePage(principal, req, subTitle);
			model.addAttribute("menuTitle", subTitle);
			model.addAttribute("menuType", "sub");
		}
		
		List<MenuSetting> menuSettingItemList = menuSettingService.getMenuSettingItemList(Integer.parseInt(number));
		List<String> menuTitleList = menuSettingItemList.stream()
		        .map(MenuSetting::getMenuTitle)
		        .collect(Collectors.toList());

		List<String> menuTitleKorList = menuSettingItemList.stream()
		        .map(MenuSetting::getMenuTitleKor)
		        .collect(Collectors.toList());
		
		ObjectMapper objectMapper = new ObjectMapper();
		String menuTitleKorListJson = objectMapper.writeValueAsString(menuTitleKorList);
		
		model.addAttribute("menuKeyNum",number);
		model.addAttribute("menuSettingItemList", menuSettingItemList);
		model.addAttribute("menuTitleList", menuTitleList);
		model.addAttribute("menuTitleKorListJson", menuTitleKorListJson);
		model.addAttribute("productData","ProductVersion_"+number);
		
        return "productVersion/ProductVersionList";
    }
	
	@ResponseBody
	@PostMapping(value = "/productVersion/{productData}")
	public Map<String, Object> productData(@PathVariable("productData") String productData, ProductVersion search, @RequestParam Map<String, String> paramMap) {
		String menuItemSort = productVersionService.getMenuItemSort(search.getMenuKeyNum());
		paramMap.put("productData", productData);
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
	
	@PostMapping(value = "/productVersion/insertView")
	public String InsertProductVersionView(Model model, MenuSetting menuSetting) {
		List<MenuSetting> menuSettingItemList = menuSettingService.getMenuSettingItemList(menuSetting.getMenuKeyNum());
		
		model.addAttribute("viewType", "insert");
		model.addAttribute("menuSettingItemList", menuSettingItemList);
		model.addAttribute("menuKeyNum", menuSetting.getMenuKeyNum());
		
		return "/productVersion/ProductVersionView";
	}
	
	@ResponseBody
	@PostMapping(value = "/productVersion/productVersionInsert")
	public String InsertProductVersion(MenuSetting menuSetting, Principal principal, @RequestParam Map<String, String> paramMap) {
		MenuSetting menuSettingOne = menuSettingService.getMenuSettingOne(menuSetting.getMenuKeyNum());
		paramMap.put("tableName", "ProductVersion_"+menuSettingOne.getMenuKeyNum());
		return productVersionService.insertProductVersion(paramMap);
	}
	
	@ResponseBody
	@PostMapping(value = "/productVersion/delete")
	public String ProductVersionDelete(@RequestParam String menuKeyNum, int[] chkList) {
		MenuSetting menuSettingOne = menuSettingService.getMenuSettingOne(Integer.parseInt(menuKeyNum));
		
		return productVersionService.delProductVersion(menuSettingOne, chkList);
	}
	
	@PostMapping(value = "/productVersion/updateView")
	public String UpdateProductVersionView(Model model, MenuSetting menuSetting) {
//		MenuSetting menuSettingOne = menuSettingService.getMenuSettingOne(menuSetting.getMenuKeyNum());
		List<Map<String,Object>> menuSettingItemList = menuSettingService.getMenuSettingItemListJoin(menuSetting);
		
		model.addAttribute("viewType", "update");
		model.addAttribute("menuSettingItemList", menuSettingItemList);
		model.addAttribute("menuSetting", menuSetting);

		return "/productVersion/ProductVersionView";
	}
	
	@ResponseBody
	@PostMapping(value = "/productVersion/productVersionUpdate")
	public String UpdateProductVersion(@RequestParam Map<String, String> paramMap, Principal principal) {

		return productVersionService.updateProductVersion(paramMap);
	}
	
	@PostMapping(value = "/productVersion/compatibilityView")
	public String CompatibilityView(Model model, @RequestParam String menuKeyNum, int[] chkList) {
		
		model.addAttribute("viewType", "insert");
		model.addAttribute("menuKeyNum", menuKeyNum);
		
		return "/productVersion/CompatibilityView";
	}
	
	@ResponseBody
    @PostMapping(value = "/compatibility")
    public Map<String, Object> Compatibility(Compatibility search) throws UnknownHostException {
        Map<String, Object> response = new HashMap<>();
        List<MenuSetting> compatibilityList = productVersionService.getcompatibilityList(search);
        int totalCount = productVersionService.getcompatibilityListCount(search);

        response.put("page", search.getPage());
        response.put("total", Math.ceil((float) totalCount / search.getRows()));
        response.put("records", totalCount);
        response.put("rows", compatibilityList);

        return response;
    }
}
