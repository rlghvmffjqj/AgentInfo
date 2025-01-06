package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.ProductDao;
import com.secuve.agentInfo.vo.Product;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class ProductService {
	@Autowired ProductDao productDao;
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
		int success = productDao.insertProduct(product);
		
		// 카테고리 추가 & 고객사 비즈니스 매핑
		if (success > 0) {
			categoryCheck(product, principal);
		}
		return parameter(success);
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
		int success = productDao.updateProduct(product);
		
		// 카테고리 추가 & 고객사 비즈니스 매핑
		if (success > 0) {
			categoryCheck(product, principal);
		}
		return parameter(success);
	}

	public String delProduct(int[] chkList, Principal principal) {
		for (int productKeyNum : chkList) {
			int success = productDao.delProduct(productKeyNum);

			if (success <= 0)
				return "FALSE";
		}
		return "OK";
	}
	
	public String parameter(int success) {
		if (success <= 0)
			return "FALSE";
		return "OK";
	}

}
