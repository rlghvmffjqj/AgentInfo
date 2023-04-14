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

import com.secuve.agentInfo.dao.CustomerDao;
import com.secuve.agentInfo.vo.Customer;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class CustomerService {
	@Autowired CustomerDao customerDao;
	@Autowired CategoryService categoryService;

	public List<Customer> getCustomerList(Customer search) {
		return customerDao.getCustomerList(customerSearch(search));
	}

	public int getCustomerListCount(Customer search) {
		return customerDao.getCustomerListCount(customerSearch(search));
	}
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String insertCustomer(Customer customer, Principal principal) {
		if (customer.getCustomerNameSelf().length() > 0) {
			customer.setCustomerNameView(customer.getCustomerNameSelf());
		}
		if (customer.getCustomerNameView().equals("") || customer.getCustomerNameView() == "") { // 고객사명 값이 비어있을 경우
			return "NotCustomerName";
		}
		selfInput(customer);
		int sucess = customerDao.insertCustomer(customer);
		
		// 카테고리 추가 & 고객사 비즈니스 매핑
		if (sucess > 0) {
			categoryService.insertCustomerBusinessMapping(customer.getCustomerNameView(), customer.getBusinessNameView());
			categoryCheck(customer, principal);
		}
		return parameter(sucess);
	}
	
	public Customer selfInput(Customer customer) {
		if(customer.getCustomerNameSelf().length() > 0)
			customer.setCustomerNameView(customer.getCustomerNameSelf());
		if(customer.getBusinessNameSelf().length() > 0)
			customer.setBusinessNameView(customer.getBusinessNameSelf());
		return customer;
	}

	public String delCustomer(int[] chkList, Principal principal) {
		for (int customerKeyNum : chkList) {
			int sucess = customerDao.delCustomer(customerKeyNum);

			if (sucess <= 0)
				return "FALSE";
		}
		return "OK";
	}

	public Customer getCustomerOne(int customerKeyNum) {
		return customerDao.getCustomerOne(customerKeyNum);
	}

	public String updateCustomer(Customer customer, Principal principal) {
		if (customer.getCustomerNameSelf().length() > 0) {
			customer.setCustomerNameView(customer.getCustomerNameSelf());
		}
		if (customer.getCustomerNameView().equals("") || customer.getCustomerNameView() == "") { // 사원 이름이 비어있을 경우 리턴
			return "NotCustomerName";
		}
		selfInput(customer);
		int sucess = customerDao.updateCustomer(customer);
		
		// 카테고리 추가 & 고객사 비즈니스 매핑
		if (sucess > 0) {
			categoryService.insertCustomerBusinessMapping(customer.getCustomerNameView(), customer.getBusinessNameView());
			categoryCheck(customer, principal);
		}
		return parameter(sucess);
	}
	
	public Customer customerSearch(Customer search) {
		search.setCustomerNameArr(search.getCustomerName().split(","));
		search.setBusinessNameArr(search.getBusinessName().split(","));
		return search;
	}
	
	public void categoryCheck(Customer customer, Principal principal) {
		if (categoryService.getCategory("customerName", customer.getCustomerNameView()) == 0) {
			categoryService.setCategory("customerName", customer.getCustomerNameView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("businessName", customer.getBusinessNameView()) == 0) {
			categoryService.setCategory("businessName", customer.getBusinessNameView(), principal.getName(), nowDate());
		}
	}
	
	public String parameter(int sucess) {
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}
}