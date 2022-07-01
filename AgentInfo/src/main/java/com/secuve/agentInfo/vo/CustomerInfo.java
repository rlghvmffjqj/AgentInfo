package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class CustomerInfo {
	private int customerInfoKeyNum;
	private String customerName;				// 고객사 명
	private String businessName;				// 사업명
	private String networkClassification;		// 망 구분
	private String customerManagerName;			// 고객사 담당자
	private String customerPhoneNumber;			// 고객사 전화번호
	private String customerZipCode;				// 고객사 우편번호
	private String customerAddress;				// 고객사 주소	
	private String customerFullAddress;			// 고객사 상세주소
	private String customerDept;				// 고객사 담당자 부서
	private String employeeSeName;				// SE 이름
	private String employeeSalesName;			// 영업팀 이름
	
	private String productCheck;				// 제품 체크(tosms, tosrf, portal)
	private String tosmsVer;					// tosms 버전
	private String tosrfVer;					// tosrf 버전
	private String portalVer;					// portal 버전
	private String javaVer;						// java 버전
	private String webServerVer;				// 웹 서버 버전
	private String databaseVer;					// DB 버전
	private String osType;
	private String logServerVer;				// 로그 서버 버전
	private String scvEaVer;					// ScvEA 버전
	private String scvCaVer;					// ScvCA 버전	
	private String authPkiVer;					// auth & PKI 버전
	
	private String customerInfoRegistrant;			// 추가자
	private String customerInfoRegistrationDate;	// 추가 시간
	private String customerInfoModifier;			// 수정자
	private String customerInfoModifiedDate;		// 수정 시간
	
	private String customerNameSelf;			// Self 고객사명
	private String businessNameSelf;			// Self 사업명

}
