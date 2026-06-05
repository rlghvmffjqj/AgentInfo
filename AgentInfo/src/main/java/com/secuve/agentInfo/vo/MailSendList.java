package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class MailSendList {
	private int mailSendListKeyNum;
	private String mailSendListPage;
	private int mailSendListPageNumber;
	private String employeeName;
	
	private String mailSendListRegistrant;
	private String mailSendListRegistrationDate;
}
