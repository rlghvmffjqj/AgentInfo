package com.secuve.agentInfo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.TextMessage;

import com.secuve.agentInfo.core.ChatHandler;

@Controller
public class LicenseController2 {
	
	@Autowired
	ChatHandler chatHandler;
	
	//@GetMapping(value = "/license/issuance")
	//public String ProductList(Model model) {
	//	
	//	return "/license/issuance";
	//}
	
	@ResponseBody
	@PostMapping(value = "/license/button")
	public String InsertProductView() {
		// 원격서버에서 라이선스 발급 request
		
		// listener
		// async
				try {
					chatHandler.handleMessage(null, new TextMessage("OK"));
					
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		
		
		// clinet에게 response
		return null;
	}
		
	@ResponseBody
	@PostMapping(value = "/test1") 
	public String test(String one, String two) {
		System.out.println("테스트");
		return "OK";
	}
	
	@ResponseBody
	@GetMapping(value = "/test2")
	public String test2() {
		System.out.println("테스트2");
		return "FALSE";
	}
}
