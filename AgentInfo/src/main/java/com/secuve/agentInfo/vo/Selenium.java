package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Selenium {
	private int seleniumKeyNum;
	private String seleniumTitle;
	private String seleniumAddress;
	private String seleniumActionSteps;
	private String seleniumRegistrant;
	private String seleniumRegistrationDate;
	private String seleniumModifier;
	private String seleniumModifiedDate;
	
	private String seleniumTitleView;
	private String seleniumAddressView;
	private String seleniumActionStepsView;
	
}
