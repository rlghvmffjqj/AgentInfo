package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class ServerCalendar {
	private int serverCalendarKeyNum;
	private long serverCalendarStartDate;
	private long serverCalendarEndDate;
	private String serverCalendarStart;
	private String serverCalendarEnd;
	private String serverCalendarContents;
	private String serverCalendarColor;
	private boolean serverCalendarAllDay;
	private String serverCalendarAlarm;
	private boolean serverCalendarAlarmYn;
	private String serverCalendarEmail;
	private String serverCalendarAddress;
	private String serverCalendarDepartment;
	private String serverCalendarRegistrant;
	private String serverCalendarRegistrationDate;
	private String serverCalendarModifier;
	private String serverCalendarModifiedDate;
	
	private String serverCalendarListContents;
	private String serverCalendarListColor;
	private String serverCalendarListDepartment;
	private String serverCalendarListRegistrant;
	private String serverCalendarListRegistrationDate;
}
