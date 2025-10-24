package com.secuve.agentInfo.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.License5Dao;
import com.secuve.agentInfo.dao.MailSendDao;
import com.secuve.agentInfo.vo.SendMailSetting;

@Service
public class MailSendService {
	@Autowired MailSendDao mailSendDao;
	@Autowired License5Dao license5Dao;

	public SendMailSetting getTargetSetting(String sendMailSettingTarget) {
		return mailSendDao.getTargetSetting(sendMailSettingTarget);
	}
	
	public String setMailSettingChange(SendMailSetting sendMailSetting) {
		int success = mailSendDao.setMailSettingChange(sendMailSetting);
		if (success <= 0) {
			return "FALSE";
		}
		return "OK";
	}
	
	public String mailSendPeriodScheduleJob(Map<String, String> paramMap, List<String> toList, String[] cc) {
		String host = "mail.secuve.com";                                                                           
		String port = "25";                                                                           
		String password = "";                                                                   
		String from = paramMap.get("licenseManager") + "@secuve.com";
		String[] to = toList.toArray(new String[0]);
		
		for(int i = 0; i < to.length; i++) {
			to[i] = to[i] + "@secuve.com";
			if(isKorean(to[i])) {
				return "Korean";
			}
		}
		
		for(int i = 0; i < cc.length; i++) {
			cc[i] = cc[i] + "@secuve.com";
			if(isKorean(cc[i])) {
				return "Korean";
			}
		}
		String subject = paramMap.get("licenseSubject");
//		String text = xssConfig.sanitize(paramMap.get("text"));
		String text = paramMap.get("text");
		                                                                                                              
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

	public long getRemainingDays(String expirationStr) {
	    // 공백 여부로 날짜 형식 구분
	    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

	    LocalDate expirationDate;
	    if (expirationStr.contains(" ")) {
	        // 날짜 + 시간 형태일 경우
	        expirationDate = LocalDateTime.parse(expirationStr, dateTimeFormatter).toLocalDate();
	    } else {
	        // 날짜만 있는 경우
	        expirationDate = LocalDate.parse(expirationStr, dateFormatter);
	    }

	    // 오늘 날짜
	    LocalDate today = LocalDate.now();

	    // 남은 일수 계산
	    return ChronoUnit.DAYS.between(today, expirationDate);
	}


}
