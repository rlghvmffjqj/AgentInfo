package com.secuve.agentInfo.controller;

import java.io.File;
import java.net.UnknownHostException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.View;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.secuve.agentInfo.core.FileDownloadView;
import com.secuve.agentInfo.core.PDFDownlod;
import com.secuve.agentInfo.core.Util;
import com.secuve.agentInfo.service.EmployeeService;
import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.MenuSettingService;
import com.secuve.agentInfo.service.ProductVersionService;
import com.secuve.agentInfo.vo.Compatibility;
import com.secuve.agentInfo.vo.Employee;
import com.secuve.agentInfo.vo.MenuSetting;
import com.secuve.agentInfo.vo.ProductVersion;

@Controller
public class ProductVersionController {
	@Autowired FavoritePageService favoritePageService;
	@Autowired ProductVersionService productVersionService;
	@Autowired MenuSettingService menuSettingService;
	@Autowired EmployeeService employeeService;
	@Autowired PDFDownlod pdfDownlod;
	
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
		model.addAttribute("mainTitle", mainTitle);
		model.addAttribute("subTitle", subTitle);
		
		List<MenuSetting> menuSettingItemList = menuSettingService.getMenuSettingItemList(Integer.parseInt(number));
		List<String> menuTitleList = menuSettingItemList.stream()
		        .map(MenuSetting::getMenuTitle)
		        .collect(Collectors.toList());

		List<String> menuTitleKorList = menuSettingItemList.stream()
		        .map(MenuSetting::getMenuTitleKor)
		        .collect(Collectors.toList());
		
		ObjectMapper objectMapper = new ObjectMapper();
		String menuTitleKorListJson = objectMapper.writeValueAsString(menuTitleKorList);
		
		MenuSetting menuSetting = menuSettingService.getMenuSettingOne(Integer.parseInt(number));
		Employee employee = employeeService.getEmployeeOne(principal.getName());
		if("admin".equals(principal.getName()) || "khkim".equals(principal.getName())) {
			menuSetting.setMenuDept("");
		}

		model.addAttribute("employee", employee);
		model.addAttribute("menuSetting",menuSetting);
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
	public String CompatibilityView(Model model, @RequestParam String menuKeyNum, int[] chkList, Principal principal) {
		List<String> menutitleList = productVersionService.getMenusettingMenutitle(menuKeyNum);
		MenuSetting menuSetting = menuSettingService.getMenuSettingOne(Integer.parseInt(menuKeyNum));
		Employee employee = employeeService.getEmployeeOne(principal.getName());
		if("admin".equals(principal.getName()) || "khkim".equals(principal.getName())) {
			menuSetting.setMenuDept("");
		}

		model.addAttribute("employee", employee);
		model.addAttribute("menuSetting",menuSetting);
		model.addAttribute("menutitleList", menutitleList);
		model.addAttribute("menuKeyNum", menuKeyNum);
		model.addAttribute("parentChkList", Arrays.toString(chkList));
		model.addAttribute("viewType", "insert");
		model.addAttribute("productVersionKeyNum", 0);
		
		return "/productVersion/CompatibilityView";
	}
	
	@PostMapping(value = "/productVersion/compatibilitySearchView")
	public String CompatibilitySerachView(Model model, @RequestParam String menuKeyNum, int[] chkList, Principal principal) {
		List<String> menutitleList = productVersionService.getMenusettingMenutitle(menuKeyNum);
		MenuSetting menuSetting = menuSettingService.getMenuSettingOne(Integer.parseInt(menuKeyNum));
		Employee employee = employeeService.getEmployeeOne(principal.getName());
		if("admin".equals(principal.getName()) || "khkim".equals(principal.getName())) {
			menuSetting.setMenuDept("");
		}

		model.addAttribute("employee", employee);
		model.addAttribute("menuSetting",menuSetting);
		model.addAttribute("menutitleList", menutitleList);
		model.addAttribute("menuKeyNum", menuKeyNum);
		model.addAttribute("productVersionKeyNum", chkList[0]);
		model.addAttribute("parentChkList", Arrays.toString(chkList));
		model.addAttribute("viewType", "search");
		
		return "/productVersion/CompatibilityView";
	}
	
	@ResponseBody
    @PostMapping(value = "/compatibility")
    public Map<String, Object> Compatibility(Compatibility search, String parentChkList) throws UnknownHostException {
		search.setMapperType("add");
        Map<String, Object> response = new HashMap<>();
        String[] parts = parentChkList.replaceAll("\\[|\\]", "").split(",");

		int[] productVersionKeyNum = new int[parts.length];
		for (int i = 0; i < parts.length; i++) {
			productVersionKeyNum[i] = Integer.parseInt(parts[i].trim()); // 공백 제거 후 숫자 변환
		}
		search.setProductVersionKeyNumArr(productVersionKeyNum);
		search.setProductVersionKeyNumList(Arrays.stream(productVersionKeyNum).boxed().collect(Collectors.toList()));
		
        List<MenuSetting> compatibilityList = productVersionService.getcompatibilityList(search);
        int totalCount = productVersionService.getcompatibilityListCount(search);

        response.put("page", search.getPage());
        response.put("total", Math.ceil((float) totalCount / search.getRows()));
        response.put("records", totalCount);
        response.put("rows", compatibilityList);

        return response;
    }
	
	@ResponseBody
    @PostMapping(value = "/compatibilitySearch")
    public Map<String, Object> CompatibilitySearch(Compatibility search) throws UnknownHostException {
		search.setMapperType("search");
        Map<String, Object> response = new HashMap<>();
        List<MenuSetting> compatibilityList = productVersionService.getcompatibilitySearchList(search);
        int totalCount = productVersionService.getcompatibilityListSearchCount(search);

        response.put("page", search.getPage());
        response.put("total", Math.ceil((float) totalCount / search.getRows()));
        response.put("records", totalCount);
        response.put("rows", compatibilityList);

        return response;
    }
	
	@ResponseBody
	@PostMapping(value = "/productVersion/insertCompatibility")
	public String InsertCompatibility(@RequestParam int menuKeyNum, int[] childChkList, String parentChkList) {
		parentChkList = parentChkList.replaceAll("[\\[\\]\\s]", ""); // → "1,2,3"
		
	    int[] parsedList = Arrays.stream(parentChkList.split(","))
	                             .mapToInt(Integer::parseInt)
	                             .toArray();
	    
		return productVersionService.insertCompatibility(menuKeyNum, childChkList, parsedList);
	}
	
	@ResponseBody
	@PostMapping(value = "/productVersion/deleteCompatibility")
	public String DeleteCompatibility(@RequestParam int menuKeyNum, int[] childChkList, String parentChkList) {
		parentChkList = parentChkList.replaceAll("[\\[\\]\\s]", ""); // → "1,2,3"
	    int[] parsedList = Arrays.stream(parentChkList.split(","))
	                             .mapToInt(Integer::parseInt)
	                             .toArray();
	    
		return productVersionService.deleteCompatibility(menuKeyNum, childChkList, parsedList);
	}
	
	@GetMapping(value = "/productVersion/detailView")
	public String DetailView(Model model, int productVersionKeyNum) {
		MenuSetting menuSetting = new MenuSetting();
		
		menuSetting.setMenuKeyNum(productVersionService.getTableManagerProductVersion(productVersionKeyNum));
		menuSetting.setProductVersionKeyNum(productVersionKeyNum);
		List<Map<String,Object>> menuSettingItemList = menuSettingService.getMenuSettingItemListJoin(menuSetting);
		
		model.addAttribute("menuSettingItemList", menuSettingItemList);
		model.addAttribute("menuSetting", menuSetting);
		
		return "/productVersion/DetailView";
	}
	
	@PostMapping(value = "/productVersion/export")
	public void exportServerList(@ModelAttribute Compatibility search, @RequestParam String[] columns, String productVersionKeyNum123,
			@RequestParam String[] headers, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Compatibility productVersionOne = productVersionService.getProductVersionOne(search);
		
		String[] columnList = {"mainMenuTitle","subMenuTitle", "packageName", "location", "packageDate"};
		
		String filename = "호환 가능 제품 목록 - " + productVersionOne.getPackageName() + ".csv";

		List<Object> list = productVersionService.listAll(search);

	    try {
			Util.exportExcelFile(response, filename, list, columnList, headers);
		} catch (Exception e) {
			System.out.println("FAIL: Export failed.\n" + e.toString());
		}
	}
	
	@ResponseBody
	@PostMapping(value = "/productVersion/pdf")
	public String PDF(String jsp, String packageName, Principal principal, Model model) {
		String decodedHtml = StringEscapeUtils.unescapeHtml4(jsp);

		String filePath = "C:\\AgentInfo\\productVersion";
		String fileName = packageName + ".pdf";
		try {
			pdfDownlod.makepdf(decodedHtml, filePath + "\\" + fileName);
		} catch (Exception e) {
			e.printStackTrace();
			return "FALSE";
		}
		return "OK"; 
	}
	
	@GetMapping(value = "/productVersion/fileDownload")
	public View FileDownload(@RequestParam String fileName, Model model) throws Exception {
		String filePath = "C:\\AgentInfo\\productVersion";
		model.addAttribute("fileUploadPath", filePath);          // 파일 경로    
		model.addAttribute("filePhysicalName", "/"+fileName);    // 파일 이름    
		model.addAttribute("fileLogicalName", fileName);  		 // 출력할 파일 이름
	
		return new FileDownloadView();
	}
	
	@ResponseBody
	@PostMapping(value = "/productVersion/fileDelete")
	public String FileDelete(String fileName, Principal principal, Model model) {
		//파일 경로 지정
		String path = "C:\\AgentInfo\\productVersion";
				
		//현재 게시판에 존재하는 파일객체를 만듬
		File file = new File(path + "\\" + fileName);
			
		if(file.exists()) { // 파일이 존재하면
			file.delete(); // 파일 삭제
			return "OK"; 
		}
		return "NotFile";
	}
	
	@ResponseBody
    @PostMapping(value = "/compatibilityAll")
    public Map<String, Object> CompatibilityAll(Compatibility search) throws UnknownHostException {
		Map<String, Object> response = new HashMap<>();
        
        List<MenuSetting> compatibilityList = productVersionService.getcompatibilityAll(search);
        int totalCount = productVersionService.getcompatibilityListCount(search);

        response.put("page", search.getPage());
        response.put("total", Math.ceil((float) totalCount / search.getRows()));
        response.put("records", totalCount);
        response.put("rows", compatibilityList);

        return response;
    }
}
