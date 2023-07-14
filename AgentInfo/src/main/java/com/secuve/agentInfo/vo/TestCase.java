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
	private int testCaseRouteSortNum;
	private int testCaseRouteGroupNum;
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
	
	private int testCaseContentsKeyNum;
	private String testCaseContentsMainMenu = "";
	private String testCaseContentsMediumMenu = "";
	private String testCaseContentsSmallMenu = "";
	private String testCaseContentsTcCode = "";
	private String testCaseContentsClassificationCode = "";
	private String testCaseContentsPurpose = "";
	private String testCaseContentsPreparation = "";
	private String testCaseContentsItem = "";
	private String testCaseContentsProcedure = "";
	private String testCaseContentsExpectedResult = "";
	private String testCaseContentsTestResult = "";
	private String testCaseContentsResultCode = "";
	private String testCaseContentsInfluence = "";
	private String testCaseContentsManager = "";
	private String testCaseContentsError = "";
	private String testCaseContentsNote = "";
	private String testCaseContentsRegistrant;
	private String testCaseContentsRegistrationDate;
	private String testCaseContentsModifier;
	private String testCaseContentsModifiedDate;
	
	private String testCaseRouteCustomerView;
	private String testCaseRouteNoteView;
	
	private String[] testCaseRouteCustomerArr;
	private String[] testCaseRouteNoteArr;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="testCaseRouteDate";		// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
	
	
	private int startTestCaseRouteSortNum;
	private int endTestCaseRouteSortNum;
	private String hitMode;
}
