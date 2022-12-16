package com.secuve.agentInfo.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.core.MailService;
import com.secuve.agentInfo.core.SmsService;
import com.secuve.agentInfo.vo.Message;

@Controller
public class RlghvmffjqjController {
	@Autowired SmsService smsService;
	@Autowired MailService mailService;
	
	@GetMapping(value = "/rlghvmffjqj")
	public String CustomerList(Model model, Principal principal) {
		return "/Rlghvmffjqj";
	}
	
	@ResponseBody
	@PostMapping(value = "/rlghvmffjqj/phone")
	public void phone(String phoneNum, String phoneContent) throws Exception {
		Message message = new Message();
		message.setTo(phoneNum);
		message.setContent(phoneContent);
		smsService.sendSms(message);
	}
	
	@ResponseBody
	@PostMapping(value = "/rlghvmffjqj/email")
	public void email(String emailId, String emailTitle, String emailContent) throws Exception {
		mailService.sendNotiMail(emailId, emailTitle, emailContent);
	}
}
