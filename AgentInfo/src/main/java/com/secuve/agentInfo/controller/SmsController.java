package com.secuve.agentInfo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.secuve.agentInfo.core.MailService;
import com.secuve.agentInfo.core.SmsService;
import com.secuve.agentInfo.vo.Message;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class SmsController {
private final SmsService smsService;

@Autowired MailService mailService;
	
	@GetMapping(value = "/send")
	public String getSmsPage() {
		return "/calendar/SendSms";
	}
	
	@PostMapping(value = "/sms/send")
	public String sendSms(Message message, Model model) throws Exception {
		smsService.sendSms(message);
		return "/calendar/Result";
	}
	
	@PostMapping(value = "/mail/send")
	public String sendMail(Model model) throws Exception {
		mailService.sendNotiMail("rlghvmffjqj@naver.com","제목","내용");
		return "/calendar/Result";
	}
	
}
