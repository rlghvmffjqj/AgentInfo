package com.secuve.agentInfo.core;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor 
@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class MailService {
	
	private final JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String from;
		
    public void sendNotiMail(String send, String title, String content) throws Exception {
    	 MimeMessage m = mailSender.createMimeMessage();
         MimeMessageHelper h = new MimeMessageHelper(m,"UTF-8");
         h.setFrom(from);
         h.setTo(send);
         h.setSubject(title);
         h.setText(content);
         mailSender.send(m);
    }
}
