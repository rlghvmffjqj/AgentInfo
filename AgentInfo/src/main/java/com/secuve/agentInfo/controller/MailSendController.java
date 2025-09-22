package com.secuve.agentInfo.controller;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.Map;

import javax.mail.internet.MimeMessage;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.secuve.agentInfo.core.XssConfig;
import com.secuve.agentInfo.vo.MailSend;

@Controller
public class MailSendController {
	@Autowired XssConfig xssConfig;
	
	@GetMapping(value = "/mailSend/write")
	public String MailWrite() {
		return "mailSend/MailWrite";
	}
	
	@ResponseBody
	@PostMapping(value = "/mailSend/send")
	public String MailSend(MailSend mailSend, MultipartFile mailAttFile, Principal principal) {
		mailSend.setMailText(xssConfig.sanitize(mailSend.getMailText()));
		String host = "mail.secuve.com";                                                                           
		String port = "25";                                                                           
		String password = "";                                                                   
		String from = principal.getName() + "@secuve.com";   

		String to = mailSend.getMailTo() + "@secuve.com";
		String[] cc = mailSend.getMailCc();
		
		if(isKorean(to)) {
			return "Korean";
		}
		for(int i = 0; i < cc.length; i++) {
			cc[i] = cc[i] + "@secuve.com";
			if(isKorean(cc[i])) {
				return "Korean";
			}
		}
		String subject = mailSend.getMailSubject();
		String text = mailSend.getMailText();
		                                                                                                              
		System.out.println("------------------------------ SecuveMailSender START ------------------------------");    
		System.out.println("server: host=" + host + ", port=" + port);                                                 
		System.out.println("message: " + from + "," + to + "," + subject);                                             
		                                                                                                              
		JavaMailSenderImpl mail = new JavaMailSenderImpl();                                                           
		mail.setHost(host);                                                                                           
		mail.setPort(Integer.parseInt(port));                                                                            
		                                                                                                              
		if (!StringUtils.isEmpty(password)) {                                                                         
			mail.setUsername(from);                                                                                     
			mail.setPassword(password);                                                                                 
		}                                                                                                             
		                                                                                                              
		try {                                                                                                         
			MimeMessage message = mail.createMimeMessage();                                                             
			MimeMessageHelper msg = new MimeMessageHelper(message, true, "UTF-8");                                      
			                                                                                                            
			msg.setFrom(from);                                                                                          
			msg.setTo(to);
			msg.setCc(cc);
			msg.setSubject(subject);                                                                                    
			msg.setText(text, true);
			Path tempFilePath = null;                                                                                                    
			if (mailAttFile != null) { 
				String tempDirPath = System.getProperty("java.io.tmpdir");
		        tempFilePath = Paths.get(tempDirPath, mailAttFile.getOriginalFilename());
		        Files.copy(mailAttFile.getInputStream(), tempFilePath);
		        File attFile = tempFilePath.toFile();
				msg.addAttachment(attFile.getName(), attFile);
				
			}                                                                                                           
			mail.send(message);                                                                                         
			System.out.println("sendMail() success.");                                                                   
			System.out.println("------------------------------ SecuveMailSender END ------------------------------");
			if (tempFilePath != null) {
	            Files.deleteIfExists(tempFilePath);
	        }
			return "OK";                                                                                                
		}                                                                                                             
		catch (Exception e) {
			System.out.println("sendMail() failed.");
			System.out.println(e);
		  	return "False";                                                                                               
		}                                                                                                             
	}
	
	public static boolean isKorean(String str) {
        return str.matches(".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*");
    }
	
	public String MailSendProductVersion(Map<String, String> paramMap, Principal principal) {
		String host = "mail.secuve.com";                                                                           
		String port = "25";                                                                           
		String password = "";                                                                   
		String from = principal.getName() + "@secuve.com";
		String to = paramMap.get("target") + "@secuve.com";
//		String[] cc = mailSend.getMailCc();
		
		if(isKorean(to)) {
			return "Korean";
		}
//		for(int i = 0; i < cc.length; i++) {
//			cc[i] = cc[i] + "@secuve.com";
//			if(isKorean(cc[i])) {
//				return "Korean";
//			}
//		}
		String subject = paramMap.get("packageName");
		String text = xssConfig.sanitize(paramMap.get("updateNote"));
		                                                                                                              
		System.out.println("------------------------------ SecuveMailSender START ------------------------------");    
		System.out.println("server: host=" + host + ", port=" + port);                                                 
		System.out.println("message: " + from + "," + to + "," + subject);                                             
		                                                                                                              
		JavaMailSenderImpl mail = new JavaMailSenderImpl();                                                           
		mail.setHost(host);                                                                                           
		mail.setPort(Integer.parseInt(port));                                                                            
		                                                                                                              
		if (!StringUtils.isEmpty(password)) {                                                                         
			mail.setUsername(from);                                                                                     
			mail.setPassword(password);                                                                                 
		}                                                                                                             
		                                                                                                              
		try {                                                                                                         
			MimeMessage message = mail.createMimeMessage();                                                             
			MimeMessageHelper msg = new MimeMessageHelper(message, true, "UTF-8");                                      
			                                                                                                            
			msg.setFrom(from);                                                                                          
			msg.setTo(to);
//			msg.setCc(cc);
			msg.setSubject(paramMap.get("packageName"));                                                                                    
			msg.setText(text, true);
			Path tempFilePath = null;                                                                                                    
			                                                                                                         
			mail.send(message);                                                                                         
			System.out.println("sendMail() success.");                                                                   
			System.out.println("------------------------------ SecuveMailSender END ------------------------------");
			if (tempFilePath != null) {
	            Files.deleteIfExists(tempFilePath);
	        }
			return "OK";                                                                                                
		}                                                                                                             
		catch (Exception e) {
			System.out.println("sendMail() failed.");
			System.out.println(e);
		  	return "False";                                                                                               
		}
	}

}
