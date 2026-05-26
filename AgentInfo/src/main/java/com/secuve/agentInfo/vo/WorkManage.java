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
	private String workManagePackageName;
	private String workManageEngineer;
	private String workManageDivision;
	private String workManageRequestDate;
	private String workManageCompleteDate;
	private String workManageAuthor;
	private String workManageTester;
	private String workManageProgressStatus;
	private int workManageProgress;
	private String workManageTestScheduleStart;
	private String workManageTestScheduleEnd;
	private String workManageOneLine;
	private String workManageDetailNote;
	private String workManageComment;
	private String workManageRegistrant;
	private String workManageRegistrationDate;
	private String workManageModifier;
	private String workManageModifiedDate;
	
	private String workManageCustomerView;
	private String workManagePackageNameView;
	private String workManageEngineerView;
	private String workManageDivisionView;
	private String workManageRequestDateView;
	private String workManageCompleteDateView;
	private String workManageAuthorView;
	private String workManageTesterView;
	private String workManageProgressStatusView;
	private int workManageProgressView;
	private String workManageOneLineView;
	private String workManageDetailNoteView;
	
	private String workManageProductTypeOne;
	private String workManagePackageNameOne;
	private String workManageProductTypeTwo;
	private String workManagePackageNameTwo;
	private String workManageProductTypeThree;
	private String workManagePackageNameThree;
	private String workManageProductTypeFour;
	private String workManagePackageNameFour;
	private String workManagePackageFileOne;
	private String workManagePackageFileTwo;
	private String workManagePackageFileThree;
	private String workManagePackageFileFour;
	private String workManagePackageSizeOne;
	private String workManagePackageSizeTwo;
	private String workManagePackageSizeThree;
	private String workManagePackageSizeFour;
	
	private String workManageProductTypeOneView;
	private String workManagePackageNameOneView;
	private String workManageProductTypeTwoView;
	private String workManagePackageNameTwoView;
	private String workManageProductTypeThreeView;
	private String workManagePackageNameThreeView;
	private String workManageProductTypeFourView;
	private String workManagePackageNameFourView;
	
	private String workManageRequestDateStart;
	private String workManageRequestDateEnd;
	
	private String[] workManageCustomerArr;
	private String[] workManageDivisionArr;
	private String[] workManageProgressStatusArr;
	
	private String workManageProductTypeList;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="workManageKeyNum";		// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
}
