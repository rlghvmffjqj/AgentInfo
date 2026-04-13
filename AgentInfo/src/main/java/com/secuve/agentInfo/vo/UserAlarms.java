package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class UserAlarms {
	private int userAlarmsKeyNum;
	private String userAlarmsEmployeeId;
	private String userAlarmsTitle;
	private String userAlarmsDate;
	private String userAlarmsState;
	private String userAlarmsURL;
	private Integer userAlarmsParameter;
	private Integer userAlarmsParameterSub;
	private String userAlarmsRegistrant;
	private String userAlarmsRegistrationDate;
	private String userAlarmsModifier;
	private String userAlarmsModifiedDate;
	
	private String userAlarmsStateN;
	
	private String role;
}
