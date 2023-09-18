package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Answer {
	private int answerKeyNum;
	private int questionKeyNum;
	private String answerDetail;
	private String answerDate;
	private String employeeId;
	private String answerRegistrant;
	private String answerRegistrationDate;
	private String answerModifier;
	private String answerModifiedDate;
	
	private String employeeName;
}
