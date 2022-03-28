package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Packages {
	private int packagesKeyNum;				// Key Number
	private String customerName;			// 고객사명
	private String requestDate;				// 요청일자
	private String deliveryData;			// 전달일자
	private String existingNew;				// 기존/신규
	private String managementServer;		// 패키지 종류
	private String agentOS;					// Agent OS
	private String osDetailVersion;			// 패키지 상세버전
	private String generalCustom;			// 일반/커스텀
	private String osType;					// OS 종류
	private String agentVer;				// Agent ver
	private String packageName;				// 패키지명
	private String manager;					// 담당자
	private String requestProductCategory;	// 요청 제품구분
	private String deliveryMethod;			// 전달 방법
	private String note;					// 비고
	
	private String deliveryDataStart;		// 전달일자  시작일
	private String deliveryDataEnd;			// 전달일자  종료일
	
	private String packagesRegistrant;		// 데이터 추가 사용자
	private String packagesRegistrationDate;	// 데이터 추가 날짜
	private String packagesModifier;			// 데이터 수정 사용자
	private String packagesModifiedDate;		// 데이터 수정 날짜
	
	private String excelImportYear;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=30;						// 데이터 보여줄 갯수
	private String sidx="packagesKeyNum";			// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
}
