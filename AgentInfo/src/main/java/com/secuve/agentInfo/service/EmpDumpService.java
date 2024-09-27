package com.secuve.agentInfo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.EmpDumpDao;

@Service
public class EmpDumpService {
	@Autowired EmpDumpDao empDempDao;

	public void create(String empDumpCount, String empDumpCustomer) {
		if(empDumpCustomer.equals("nhlife")) {
			nhlife();
		} else if(empDumpCustomer.equals("kbank")){
			kbank();
		} else if(empDumpCustomer.equals("nhqv")) {
			nhqv();
		}
		
	}
	
	public void nhlife() {
		
	}
	
	public void kbank() {
		
	}
	
	public void nhqv() {
		
	}

}
