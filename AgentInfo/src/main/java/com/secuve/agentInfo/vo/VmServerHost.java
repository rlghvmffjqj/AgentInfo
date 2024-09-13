package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class VmServerHost {
	private int vmServerHostKeyNum;
	private String vmServerHostName;
	private String vmServerHostIp;
	private String vmServerHostRegistrant;
	private String vmServerHostRegistrationDate;
	private String vmServerHostModifier;
	private String vmServerHostModifiedDate;
	
	private String vmServerHostNameView;
	private String vmServerHostIpView;
}
