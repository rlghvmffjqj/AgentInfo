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
	
	private int testCaseRouteKeyNum;
	private String testCaseRouteCustomer;
	private String testCaseRouteNote;
	private String testCaseRouteDate;
	private String testCaseRouteFullPath;
	private String testCaseRouteParentPath;
	private String testCaseRouteName;
	private String testCaseRouteRegistrant;
	private String testCaseRouteRegistrationDate;
	private String testCaseRouteModifier;
	private String testCaseRouteModifiedDate;
	
	private String testCaseFormNameOriginal;
	private String newTestCaseRouteName;
	private String newTestCaseRouteFullPath;
	private String testCaseDateStart;
	private String testCaseDateEnd;
	
	private String[] testCaseRouteCustomerArr;
	private String[] testCaseRouteNoteArr;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="testCaseRouteDate";		// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
}