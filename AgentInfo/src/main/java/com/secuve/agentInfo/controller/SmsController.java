package com.secuve.agentInfo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.secuve.agentInfo.service.SmsService;
import com.secuve.agentInfo.vo.Message;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class SmsController {
private final SmsService smsService;
	
	@GetMapping(value = "/send")
	public String getSmsPage() {
		return "/calendar/SendSms";
	}
	
	@PostMapping(value = "/sms/send")
	public String sendSms(Message message, Model model) throws Exception {
		smsService.sendSms(message);
		return "/calendar/Result";
	}
	
}
