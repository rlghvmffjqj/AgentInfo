package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class WorkManage {
	private int workManageKeyNum;
	private String workManageCustomer;
	private String workManageProductName;
	private String workManageEngineer;
	private String workManageDivision;
	private String workManageRequestDate;
	private String workManageAuthor;
	private String workManageTester;
	private String workManageProgressStatus;
	private String workManageTestScheduleStart;
	private String workManageTestScheduleEnd;
	private String workManageOneLine;
	private String workManageDetailNote;
	private String workManageRegistrant;
	private String workManageRegistrationDate;
	private String workManageModifier;
	private String workManageModifiedDate;
	
	private String workManageCustomerView;
	private String workManageProductNameView;
	private String workManageEngineerView;
	private String workManageDivisionView;
	private String workManageRequestDateView;
	private String workManageAuthorView;
	private String workManageTesterView;
	private String workManageProgressStatusView;
	private String workManageOneLineView;
	private String workManageDetailNoteView;
	
	private String workManageRequestDateStart;
	private String workManageRequestDateEnd;
	
	private String[] workManageCustomerArr;
	private String[] workManageDivisionArr;
	private String[] workManageProgressStatusArr;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="workManageKeyNum";		// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
}
