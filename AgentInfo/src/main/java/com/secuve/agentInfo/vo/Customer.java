package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Customer {
	private int customerKeyNum;					// 고객사 Key
	private String customerName;				// 고객사 명
	private String businessName;				// 사업명
	private String customerManagerName;			// 고객사 담당자
	private String customerPhoneNumber;			// 고객사 전화번호
	private String customerZipCode;				// 고객사 우편번호
	private String customerAddress;				// 고객사 주소	
	private String customerFullAddress;			// 고객사 상세주소
	private String customerDept;				// 고객사 담당자 부서
	private String packageName;					// 제품 명
	private String osType;						// OS 종류
	private String employeeSeName;				// SE 이름
	private String employeeSalesName;			// 영업팀 이름
	private String customerRegistrant;			// 추가자
	private String customerRegistrationDate;	// 추가 시간
	private String customerModifier;			// 수정자
	private String customerModifiedDate;		// 수정 시간
	
	private String customerNameView;			// View 고객사명
	private String businessNameView;			// View 사업명
	private String customerManagerNameView;		// View 고객사 담당자
	private String customerPhoneNumberView;		// View 고객사 전화번호
	private String customerZipCodeView;			// View 고객사 우편번호
	private String customerAddressView;			// View 고객사 주소	
	private String customerFullAddressView;		// View 고객사 상세주소
	private String customerDeptView;			// View 고객사 담당자 부서
	private String packageNameView;				// View 제품 명
	private String osTypeView;					// View OS 종류
	private String employeeSeNameView;			// View SE 이름
	private String employeeSalesNameView;		// View 영업팀 이름
	
	private String customerNameSelf;			// Self 고객사명
	private String businessNameSelf;			// Self 사업명
	
	private String[] customerNameArr;
	private String[] businessNameArr;	
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="customerName";			// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
}