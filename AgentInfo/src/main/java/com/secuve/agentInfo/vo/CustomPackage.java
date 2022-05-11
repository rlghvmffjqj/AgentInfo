package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class CustomPackage {
	private int customPackageKeyNum;			// Key
	private String customerName;				// 고객사
	private String businessName;				// 사업명
	private String managementServer;			// 패키지 종류
	private String agentVer;					// Version
	private String releaseNotes;				// 릴리즈 노트
	
	private String customPackageRegistrant;			// 데이터 추가 사용자
	private String customPackageRegistrationDate;	// 데이터 추가 날짜
	private String customPackageModifier;			// 데이터 수정 사용자
	private String customPackageModifiedDate;		// 데이터 수정 날짜
	
	private String customerNameView;				// View 고객사
	private String businessNameView;				// View 사업명
	private String managementServerView;			// View 패키지 종류
	private String agentVerView;					// View Version
	
	private String customerNameSelf;				// Self 고객사
	private String businessNameSelf;				// Self 사업명
	private String managementServerSelf;			// Self 패키지 종류
	private String agentVerSelf;					// Self Version
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="customerName";		// 정렬할 기준 데이터
	private String sord;
}

