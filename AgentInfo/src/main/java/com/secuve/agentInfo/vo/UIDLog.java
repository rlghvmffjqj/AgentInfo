package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class UIDLog {
	private int uidKeyNum;
	private String uidCustomerName;
	private String uidOsDetailVersion;
	private String uidPackageName;
	private String uidEvent;
	private String uidUser;
	private String uidTime;
	
}
