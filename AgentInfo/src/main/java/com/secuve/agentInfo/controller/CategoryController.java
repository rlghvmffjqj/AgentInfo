package com.secuve.agentInfo.controller;

import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.CategoryService;
import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.vo.Category;
import com.secuve.agentInfo.vo.CategoryBusiness;

@Controller
public class CategoryController {
	@Autowired CategoryService categoryService;
	@Autowired FavoritePageService favoritePageService;
	
	/**
	 * 기존/신규
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/category/existingNew")
	public String ExistingNew(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "카테고리 - 기존/신규");
		List<String> categoryValue = categoryService.getSelectInput("existingNew");
		model.addAttribute("categoryValue", categoryValue);
		model.addAttribute("category", "existingNew");
		return "category/CategoryList";
	}
	
	/**
	 * 패키지 종류
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/category/managementServer")
	public String managementServer(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "카테고리 - 패키지 종류");
		List<String> categoryValue = categoryService.getSelectInput("managementServer");
		model.addAttribute("categoryValue", categoryValue);
		model.addAttribute("category", "managementServer");
		return "category/CategoryList";
	}
	
	/**
	 * 일반/커스텀
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/category/generalCustom")
	public String generalCustom(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "카테고리 - 일반/커스텀");
		List<String> categoryValue = categoryService.getSelectInput("generalCustom");
		model.addAttribute("categoryValue", categoryValue);
		model.addAttribute("category", "generalCustom");
		return "category/CategoryList";
	}
	
	/**
	 * OS 종류
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/category/osType")
	public String osType(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "카테고리 - OS종류");
		List<String> categoryValue = categoryService.getSelectInput("osType");
		model.addAttribute("categoryValue", categoryValue);
		model.addAttribute("category", "osType");
		return "category/CategoryList";
	}
	
	
	/**
	 * 요청 제품 구분
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/category/requestProductCategory")
	public String requestProductCategory(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "카테고리 - 요청 제품 구분");
		List<String> categoryValue = categoryService.getSelectInput("requestProductCategory");
		model.addAttribute("categoryValue", categoryValue);
		model.addAttribute("category", "requestProductCategory");
		return "category/CategoryList";
	}
	
	/**
	 * 전달방법
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/category/deliveryMethod")
	public String deliveryMethod(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "카테고리 - 전달방법");
		List<String> categoryValue = categoryService.getSelectInput("deliveryMethod");
		model.addAttribute("categoryValue", categoryValue);
		model.addAttribute("category", "deliveryMethod");
		return "category/CategoryList";
	}
	
	/**
	 * Agent Ver
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/category/agentVer")
	public String agentVer(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "카테고리 - Agent Ver");
		List<String> categoryValue = categoryService.getSelectInput("agentVer");
		model.addAttribute("categoryValue", categoryValue);
		model.addAttribute("category", "agentVer");
		return "category/CategoryList";
	}
	
	/**
	 * Agent OS
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/category/agentOS")
	public String agentOS(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "카테고리 - Agent OS");
		List<String> categoryValue = categoryService.getSelectInput("agentOS");
		model.addAttribute("categoryValue", categoryValue);
		model.addAttribute("category", "agentOS");
		return "category/CategoryList";
	}
	
	/**
	 * 고객사명
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/category/customerName")
	public String customerName(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "카테고리 - 고객사명");
		List<String> categoryValue = categoryService.getSelectInput("customerName");
		List<String> customerId = categoryService.getCategoryKeyNum();
		model.addAttribute("categoryValue", categoryValue);
		model.addAttribute("category", "customerName");
		model.addAttribute("customerId", customerId);
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
		List<String> businessName = categoryService.getCategoryCustomerBusinessName(customerName);
		model.addAttribute("businessName", businessName);
		return businessName;
	}
	
	/**
	 * 사업명
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/category/businessName")
	public String businessName(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "카테고리 - 사업명");
		List<String> categoryCustomerName = categoryService.getSelectInput("customerName");
		List<String> categoryBusinessName = categoryService.getCategoryBusinessNameList();
		model.addAttribute("category", "businessName");
		model.addAttribute("categoryCustomerName", categoryCustomerName).addAttribute("categoryBusinessName",categoryBusinessName);
		
		return "category/CategoryBusinessList";
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
		List<String> categoryValue = categoryService.getCategoryValue(category.getCategoryName());
		model.addAttribute("viewType","insert").addAttribute("category", category);
		model.addAttribute("categoryValue", categoryValue);
		
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
		List<String> categoryValue = categoryService.getCategoryValue(category.getCategoryName());
		
		model.addAttribute("viewType","update").addAttribute("category", category);
		model.addAttribute("categoryValue", categoryValue);
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
	
	@ResponseBody
	@PostMapping(value = "/category/existenceCheckInsert")
	public List<String> existenceCheckInsert(Category category, Principal principal) throws IllegalStateException, IOException {
		return categoryService.existenceCheckInsert(category);
	}
	
	@ResponseBody
	@PostMapping(value = "/category/existenceCheckUpdate")
	public List<String> existenceCheckUpdate(Category category, Principal principal) throws IllegalStateException, IOException {
		return categoryService.existenceCheckUpdate(category);
	}
	
	@ResponseBody
	@PostMapping(value = "/categoryBusiness")
	public Map<String, Object> CategoryBusiness(@ModelAttribute("search") CategoryBusiness search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<CategoryBusiness> list = new ArrayList<>(categoryService.getCategoryBusinessList(search));
		
		int totalCount = categoryService.getCategoryBusinessListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float)totalCount/search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@PostMapping(value = "/categoryBusiness/insertView")
	public String InsertCategoryBusinessView(Model model, CategoryBusiness category) {
		List<String> customerName = categoryService.getCategoryValue("customerName");
		model.addAttribute("viewType","insert").addAttribute("customerName", customerName);
		model.addAttribute("category", category);
		
		return "/category/CategoryBusinessView";
	}
	
	@PostMapping(value = "/categoryBusiness/updateView")
	public String UpdateCategoryBusinessView(Model model, CategoryBusiness category) {
		List<String> customerName = categoryService.getCategoryValue("customerName");
		category = categoryService.getCategoryBusinessOne(category.getCategoryBusinessKeyNum());
		model.addAttribute("viewType","update").addAttribute("customerName", customerName);
		model.addAttribute("category", category);
		
		return "/category/CategoryBusinessView";
	}
	
	@ResponseBody
	@PostMapping(value = "/categoryBusiness/existenceCheckInsert")
	public List<String> existenceBusinessCheckInsert(CategoryBusiness category, Principal principal) throws IllegalStateException, IOException {
		return categoryService.existenceBusinessCheckInsert(category);
	}
	
	@ResponseBody
	@PostMapping(value = "/categoryBusiness/existenceCheckUpdate")
	public List<String> existenceBusinessCheckUpdate(CategoryBusiness category, Principal principal) throws IllegalStateException, IOException {
		return categoryService.existenceBusinessCheckUpdate(category);
	}
	
	@ResponseBody
	@PostMapping(value = "/categoryBusiness/insert")
	public String InsertCategoryBusiness(CategoryBusiness category, Principal principal) {
		category.setCategoryBusinessRegistrant(principal.getName());
		// Date formatter 현재 시간
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		category.setCategoryBusinessRegistrationDate(formatter.format(now));

		return categoryService.insertCategoryBusiness(category);
	}
	
	@ResponseBody
	@PostMapping(value = "/categoryBusiness/update")
	public String UpdateCategoryBusiness(CategoryBusiness category, Principal principal) {
		category.setCategoryBusinessModifiedDate(principal.getName());
		// Date formatter 현재 시간
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		category.setCategoryBusinessModifiedDate(formatter.format(now));

		return categoryService.updateCategoryBusiness(category);
	}
	
	@ResponseBody
	@PostMapping(value = "/categoryBusiness/delete")
	public String CategoryBusinessDelete(@RequestParam int[] chkList) {
		return categoryService.delCategoryBusiness(chkList);
	}
	
	
	@PostMapping(value = "/category/mergeView")
	public String MergeView(@RequestParam int[] chkList, String categoryName, Model model) {
		List<String> categoryMergeList = categoryService.getCategoryMergeList(chkList);
		model.addAttribute("categoryMergeList",categoryMergeList);
		model.addAttribute("categoryName", categoryName);
		return "/category/MergeView";
	}
	
	@ResponseBody
	@PostMapping(value = "/category/merge")
	public String Merge(@RequestParam int[] chkList, String categoryName, String categoryValueView) {
		return categoryService.updateMerge(chkList, categoryName, categoryValueView);
	}
	
	@PostMapping(value = "/categoryBusiness/mergeView")
	public String BusinessMergeView(@RequestParam int[] chkList, Model model) {
		List<String> categoryBusinessMergeList = categoryService.getCategoryBusinessMergeList(chkList);
		model.addAttribute("categoryBusinessMergeList",categoryBusinessMergeList);
		return "/category/BusinessMergeView";
	}
	
	@ResponseBody
	@PostMapping(value = "/categoryBusiness/merge")
	public String BusinessMerge(@RequestParam int[] chkList, String categoryBusinessNameView) {
		return categoryService.updateBusinessMerge(chkList, categoryBusinessNameView);
	}
	
	@ResponseBody
	@PostMapping(value = "/categoryBusiness/mergeCheck")
	public String MergeCheck(@RequestParam int[] chkList) {
		return categoryService.mergeCheck(chkList);
	}
}