package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.CategoryService;
import com.secuve.agentInfo.vo.Category;

@Controller
public class CategoryController {
	@Autowired CategoryService categoryService;
	
	/**
	 * 기존/신규
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/category/existingNew")
	public String ExistingNew( Model model) {
		model.addAttribute("category", "existingNew");
		
		return "category/CategoryList";
	}
	
	/**
	 * 패키지 종류
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/category/managementServer")
	public String managementServer( Model model) {
		model.addAttribute("category", "managementServer");
		
		return "category/CategoryList";
	}
	
	/**
	 * 일반/커스텀
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/category/generalCustom")
	public String generalCustom( Model model) {
		model.addAttribute("category", "generalCustom");
		
		return "category/CategoryList";
	}
	
	/**
	 * OS 종류
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/category/osType")
	public String osType( Model model) {
		model.addAttribute("category", "osType");
		
		return "category/CategoryList";
	}
	
	/**
	 * 요청 제품 구분
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/category/requestProductCategory")
	public String requestProductCategory( Model model) {
		model.addAttribute("category", "requestProductCategory");
		
		return "category/CategoryList";
	}
	
	/**
	 * 전달방법
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/category/deliveryMethod")
	public String deliveryMethod( Model model) {
		model.addAttribute("category", "deliveryMethod");
		
		return "category/CategoryList";
	}
	
	/**
	 * Agent Ver
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/category/agentVer")
	public String agentVer( Model model) {
		model.addAttribute("category", "agentVer");
		
		return "category/CategoryList";
	}
	
	/**
	 * Agent OS
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/category/agentOS")
	public String agentOS( Model model) {
		model.addAttribute("category", "agentOS");
		
		return "category/CategoryList";
	}
	
	/**
	 * 고객사명
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/category/customerName")
	public String customerName( Model model) {
		model.addAttribute("category", "customerName");
		
		return "category/CategoryList";
	}
	
	/**
	 * 고객사별 사업명
	 * @param model
	 * @param customerName
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/category/customerBusinessName")
	public List<String> customerBusinessName(Model model, String customerName) {
		List<String> businessName = categoryService.getCategoryValue("businessName", customerName);
		model.addAttribute("businessName", businessName);
		return businessName;
	}
	
	/**
	 * 사업명
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/category/businessName")
	public String businessName( Model model) {
		model.addAttribute("category", "businessName");
		
		return "category/CategoryList";
	}
	
	/**
	 * 카테고리 리스트 조회
	 * @param search
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/category")
	public Map<String, Object> Category(@ModelAttribute("search") Category search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<Category> list = new ArrayList<>(categoryService.getCategoryList(search));
		
		int totalCount = categoryService.getCategoryListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float)totalCount/search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	/**
	 * 카테고리 삭제
	 * @param chkList
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/category/delete")
	public String CategoryDelete(@RequestParam int[] chkList) {
		return categoryService.delCategory(chkList);
	}
	
	/**
	 * 추가 Model
	 * @param model
	 * @param category
	 * @return
	 */
	@PostMapping(value = "/category/insertView")
	public String InsertCategoryView(Model model, Category category) {
		model.addAttribute("viewType","insert").addAttribute("category", category);
		return "/category/CategoryView";
	}
	
	/**
	 * 카테고리 추가
	 * @param category
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/category/insert")
	public Map<String,String> InsertCategory(Category category, Principal principal) {
		category.setCategoryRegistrant(principal.getName());
		// Date formatter 현재 시간
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		category.setCategoryRegistrationDate(formatter.format(now));

		Map<String,String> map = new HashMap<String,String>();
		String result = categoryService.insertCategory(category);
		map.put("result", result);
		return map;
	}
	
	/**
	 * 카테고리 업데이트 Model
	 * @param model
	 * @param categoryKeyNum
	 * @return
	 */
	@PostMapping(value ="/category/updateView")
	public String UpdateCategoryView(Model model, int categoryKeyNum) {
		Category category = categoryService.getCategoryOne(categoryKeyNum);
		model.addAttribute("viewType","update").addAttribute("category", category);
		return "/category/CategoryView";
	}
	
	/**
	 * 카테고리 업데이트
	 * @param category
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/category/update")
	public Map<String,String> UpdateCategory(Category category, Principal principal) {
		category.setCategoryModifier(principal.getName());
		// Date formatter 현재 시간
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		category.setCategoryModifiedDate(formatter.format(now));
		
		Map<String,String> map = new HashMap<String,String>();
		String result = categoryService.updateCategory(category);
		map.put("result", result);
		return map;
	}
}