package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class TestCase {
	private int testCaseFormKeyNum;
	private String testCaseFormName;
	private String testCaseFormRegistrant;
	private String testCaseFormRegistrationDate;
	private String testCaseFormModifier;
	private String testCaseFormModifiedDate;
	
	private int testCaseKeyNum;
	private String testCaseFullPath;
	private String testCaseParentPath;
	private String testCaseName;
	
	private String testCaseFormNameOriginal;
}
