package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class SharedCalendar {
	private int sharedCalendarKeyNum;
	private long sharedCalendarStartDate;
	private long sharedCalendarEndDate;
	private String sharedCalendarStart;
	private String sharedCalendarEnd;
	private String sharedCalendarContents;
	private String sharedCalendarColor;
	private boolean sharedCalendarAllDay;
	private String sharedCalendarAlarm;
	private boolean sharedCalendarAlarmYn;
	private String sharedCalendarEmail;
	private String sharedCalendarAddress;
	private String sharedCalendarDepartment;
	private String sharedCalendarRegistrant;
	private String sharedCalendarRegistrationDate;
	private String sharedCalendarModifier;
	private String sharedCalendarModifiedDate;
	
	private String sharedCalendarListContents;
	private String sharedCalendarListColor;
	private String sharedCalendarListDepartment;
	private String sharedCalendarListRegistrant;
	private String sharedCalendarListRegistrationDate;
}
