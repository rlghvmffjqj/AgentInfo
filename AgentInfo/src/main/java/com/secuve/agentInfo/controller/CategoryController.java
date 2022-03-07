package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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
	
	@Autowired
	CategoryService categoryService;
	
	@GetMapping(value = "/category/existingNew")
	public String ExistingNew( Model model) {
		model.addAttribute("category", "existingNew");
		
		return "category/CategoryList";
	}
	
	@GetMapping(value = "/category/managementServer")
	public String managementServer( Model model) {
		model.addAttribute("category", "managementServer");
		
		return "category/CategoryList";
	}
	
	@GetMapping(value = "/category/generalCustom")
	public String generalCustom( Model model) {
		model.addAttribute("category", "generalCustom");
		
		return "category/CategoryList";
	}
	
	@GetMapping(value = "/category/osType")
	public String osType( Model model) {
		model.addAttribute("category", "osType");
		
		return "category/CategoryList";
	}
	
	@GetMapping(value = "/category/requestProductCategory")
	public String requestProductCategory( Model model) {
		model.addAttribute("category", "requestProductCategory");
		
		return "category/CategoryList";
	}
	
	@GetMapping(value = "/category/deliveryMethod")
	public String deliveryMethod( Model model) {
		model.addAttribute("category", "deliveryMethod");
		
		return "category/CategoryList";
	}
	
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
	
	@ResponseBody
	@PostMapping(value = "/category/delete")
	public String CategoryDelete(@RequestParam int[] chkList) {
		return categoryService.delCategory(chkList);
	}
	
	@PostMapping(value = "/category/insertView")
	public String InsertCategoryView(Model model, Category category) {
		model.addAttribute("viewType","insert").addAttribute("category", category);
		return "/category/CategoryView";
	}
	
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
	
	@PostMapping(value ="/category/updateView")
	public String UpdateCategoryView(Model model, int categoryKeyNum) {
		Category category = categoryService.getCategoryOne(categoryKeyNum);
		model.addAttribute("viewType","update").addAttribute("category", category);
		return "/category/CategoryView";
	}
	
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
