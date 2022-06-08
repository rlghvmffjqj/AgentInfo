package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.ProductDao;
import com.secuve.agentInfo.vo.Product;

@Service
public class ProductService {
	@Autowired ProductDao productDao;
	@Autowired CustomerBusinessMappingService customerBusinessMappingService;
	@Autowired CategoryService categoryService;

	public List<Product> getProductList(Product search) {
		return productDao.getProductList(productSearch(search));
	}
	
	public Product productSearch(Product search) {
		search.setCustomerNameArr(search.getCustomerName().split(","));
		search.setBusinessNameArr(search.getBusinessName().split(","));
		return search;
	}

	public int getProductListCount(Product search) {
		return productDao.getProductListCount(productSearch(search));
	}
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String insertProduct(Product product, Principal principal) {
		if (product.getCustomerNameSelf().length() > 0) {
			product.setCustomerNameView(product.getCustomerNameSelf());
		}
		if (product.getCustomerNameView().equals("") || product.getCustomerNameView() == "") { // 고객사명 값이 비어있을 경우
			return "NotCustomerName";
		}
		selfInput(product);
		product.setProductKeyNum(productKeyNum());
		int sucess = productDao.insertProduct(product);
		
		// 카테고리 추가 & 고객사 비즈니스 매핑
		if (sucess > 0) {
			customerBusinessMappingService.customerBusinessMapping(product.getCustomerNameView(), product.getBusinessNameView());
			categoryCheck(product, principal);
		}
		return parameter(sucess);
	}
	
	public void categoryCheck(Product product, Principal principal) {
		if (categoryService.getCategory("customerName", product.getCustomerNameView()) == 0) {
			categoryService.setCategory("customerName", product.getCustomerNameView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("businessName", product.getBusinessNameView()) == 0) {
			categoryService.setCategory("businessName", product.getBusinessNameView(), principal.getName(), nowDate());
		}
	}
	
	public Product selfInput(Product product) {
		if(product.getCustomerNameSelf().length() > 0)
			product.setCustomerNameView(product.getCustomerNameSelf());
		if(product.getBusinessNameSelf().length() > 0)
			product.setBusinessNameView(product.getBusinessNameSelf());
		return product;
	}
	
	public int productKeyNum() {
		int productKeyNum = 0;
		try {
			productKeyNum = productDao.getProductKeyNum();
		} catch (Exception e) {
			return productKeyNum;
		}
		return ++productKeyNum;
	}

	public Product getProductOne(int productKeyNum) {
		return productDao.getProductOne(productKeyNum);
	}

	public String updateProduct(Product product, Principal principal) {
		if (product.getCustomerNameSelf().length() > 0) {
			product.setCustomerNameView(product.getCustomerNameSelf());
		}
		if (product.getCustomerNameView().equals("") || product.getCustomerNameView() == "") { // 사원 이름이 비어있을 경우 리턴
			return "NotCustomerName";
		}
		selfInput(product);
		int sucess = productDao.updateProduct(product);
		
		// 카테고리 추가 & 고객사 비즈니스 매핑
		if (sucess > 0) {
			customerBusinessMappingService.customerBusinessMapping(product.getCustomerNameView(), product.getBusinessNameView());
			categoryCheck(product, principal);
		}
		return parameter(sucess);
	}

	public String delProduct(int[] chkList, Principal principal) {
		for (int productKeyNum : chkList) {
			int sucess = productDao.delProduct(productKeyNum);

			if (sucess <= 0)
				return "FALSE";
		}
		return "OK";
	}
	
	public String parameter(int sucess) {
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

}
