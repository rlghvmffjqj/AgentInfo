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
	private Integer seleniumKeyNum;
	private String seleniumTitle;
	private String seleniumAddress;
	private String seleniumDetailNote;
	private String seleniumActionSteps;
	private String seleniumRegistrant;
	private String seleniumRegistrationDate;
	private String seleniumModifier;
	private String seleniumModifiedDate;
	
	private String seleniumGroupName;
	private String seleniumGroupFullPath;
	private String seleniumGroupParentPath;
	
	private String seleniumTitleView;
	private String seleniumAddressView;
	private String seleniumActionStepsView;
	private String seleniumDetailNoteView;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="seleniumKeyNum";		// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
	
}
