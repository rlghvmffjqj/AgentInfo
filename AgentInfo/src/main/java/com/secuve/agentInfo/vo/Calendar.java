package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Calendar {
	private int calendarKeyNum;
	private long calendarStartDate;
	private long calendarEndDate;
	private String calendarStart;
	private String calendarEnd;
	private String calendarContents;
	private String calendarColor;
	private String calendarRegistrant;
	private String calendarRegistrationDate;
	private String calendarModifier;
	private String calendarModifiedDate;
	
	private String calendarListContents;
	private String calendarListColor;
	private String calendarListRegistrant;
	private String calendarListRegistrationDate;
}
