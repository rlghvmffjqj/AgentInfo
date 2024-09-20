package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class UserAlarm {
	private int userAlarmKeyNum;
	private String userAlarmEmployeeId;
	private String userAlarmTitle;
	private String userAlarmDate;
	private String userAlarmState;
	private String userAlarmURL;
	private Integer userAlarmParameter;
	private Integer userAlarmParameterSub;
	private String userAlarmRegistrant;
	private String userAlarmRegistrationDate;
	private String userAlarmModifier;
	private String userAlarmModifiedDate;
	
	private String userAlarmStateN;
	
	private String role;
}
