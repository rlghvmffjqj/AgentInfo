package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.CategoryService;
import com.secuve.agentInfo.service.ProductService;
import com.secuve.agentInfo.vo.Product;

@Controller
public class ProductController {
	@Autowired ProductService productService;
	@Autowired CategoryService categoryService;
	
	/**
	 * 제품 리스트 페이지 이동
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/product/list")
	public String ProductList(Model model) {
		List<String> customerName = categoryService.getCategoryValue("customerName");
		List<String> categoryBusinessName = categoryService.getCategoryBusinessNameList();
		
		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", categoryBusinessName);
		
		return "/product/ProductList";
	}
	
	/**
	 * 제품 데이터 리스트 조회
	 * @param search
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/product")
	public Map<String, Object> Product(Product search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<Product> list = new ArrayList<>(productService.getProductList(search));
		for (Product product : list) {
			product.setProductCheck(product.getProductCheck().toUpperCase());
		}

		int totalCount = productService.getProductListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	/**
	 * 제품 추가 Modal
	 * @param model
	 * @param product
	 * @return
	 */
	@PostMapping(value = "/product/insertView")
	public String InsertProductView(Model model, Product product) {
		List<String> customerName = categoryService.getCategoryValue("customerName");
		
		model.addAttribute("customerName", customerName);
		model.addAttribute("viewType", "insert").addAttribute("product", product);
		return "/product/ProductView";
	}
	
	/**
	 * 제품 추가
	 * @param product
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/product/insert")
	public Map<String, String> InsertProduct(Product product, Principal principal) {
		product.setProductRegistrant(principal.getName());
		product.setProductRegistrationDate(productService.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		String result = productService.insertProduct(product, principal);
		map.put("result", result);
		return map;
	}
	
	/**
	 * 제품 수정 Modal
	 * @param model
	 * @param productKeyNum
	 * @return
	 */
	@PostMapping(value = "/product/updateView")
	public String UpdateProductView(Model model, int productKeyNum) {
		Product product = productService.getProductOne(productKeyNum);

		List<String> customerName = categoryService.getCategoryValue("customerName");
		List<String> businessName = categoryService.getCategoryValue("businessName", product.getCustomerName());

		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", businessName);
		model.addAttribute("viewType", "update").addAttribute("product", product);
		return "/product/ProductView";
	}
	
	/**
	 * 제품 수정
	 * @param product
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/product/update")
	public Map<String, String> UpdateEmployee(Product product, Principal principal) {
		product.setProductModifier(principal.getName());
		product.setProductModifiedDate(productService.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		String result = productService.updateProduct(product, principal);
		map.put("result", result);
		return map;
	}
	
	/**
	 * 제품 삭제
	 * @param chkList
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/product/delete")
	public String ProductDelete(@RequestParam int[] chkList, Principal principal) {
		return productService.delProduct(chkList, principal);
	}
}
