package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class MailSend {
	private String mailTo;
	private String[] mailCc;
	private String mailSubject;
	private String mailText;
}
