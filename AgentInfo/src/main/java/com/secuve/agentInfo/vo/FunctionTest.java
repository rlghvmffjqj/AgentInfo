package com.secuve.agentInfo.vo;

import java.util.List;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class FunctionTest {
	private Integer functionTestKeyNum;
	private Integer functionTestSettingSubCategoryKeyNum;
	private String functionTestCustomer;
	private String functionTestTitle;
	private String functionTestDate;
	private String functionTestSubCategoryState;
	private String functionTestSubCategoryFailReason;
	private String functionTestResult;
	private String functionTestType;
	private String functionTestRegistrant;
	private String functionTestRegistrationDate;
	private String functionTestModifier;
	private String functionTestModifiedDate;
	
	private String functionTestSettingDivision;
	private String functionTestPdfType;
	
	private List<Integer> functionTestSettingSubCategoryKeyNumList;
	private List<String> functionTestSubCategoryStateList;
	private List<String> functionTestSubCategoryFailReasonList;
	
	private String[] functionTestCustomerArr;
	private String[] functionTestTitleArr;
	
	private String functionTestDateStart;
	private String functionTestDateEnd;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="functionTestKeyNum";			// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
}
