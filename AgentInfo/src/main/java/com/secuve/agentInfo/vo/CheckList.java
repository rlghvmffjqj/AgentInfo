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
public class CheckList {
	private int checkListKeyNum;
	private Integer checkListSettingSubCategoryKeyNum;
	private String checkListCustomer;
	private String checkListTitle;
	private String checkListDate;
	private String checkListSubCategoryState;
	private String checkListSubCategoryFailReason;
	private String checkListRegistrant;
	private String checkListRegistrationDate;
	private String checkListModifier;
	private String checkListModifiedDate;
	
	private List<Integer> checkListSettingSubCategoryKeyNumList;
	private List<String> checkListSubCategoryStateList;
	private List<String> checkListSubCategoryFailReasonList;
	
	private String[] checkListCustomerArr;
	private String[] checkListTitleArr;
	
	private String checkListDateStart;
	private String checkListDateEnd;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="checkListKeyNum";			// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
}
