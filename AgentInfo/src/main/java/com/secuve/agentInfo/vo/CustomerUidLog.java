package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class CustomerUidLog {
	private int customerUidLogKeyNum;						// Key
	private String customerUidLogCustomerName;				// 고객사 명
	private String customerUidLogBusinessName;				// 사업 명
	private String customerUidLogNetworkClassification;		// 망 구분
	private String customerUidLogCustomerManagerName;		// 담당자 명 
	private String customerUidLogCustomerPhoneNumber;		// 담당자 전화번호
	private String customerUidLogCustomerZipCode;			// 고객사 우편번호
	private String customerUidLogCustomerAddress;			// 고객사 주소
	private String customerUidLogCustomerFullAddress;		// 고객사 상세주소
	private String customerUidLogCustomerDept;				// 담당자 부서
	private String customerUidLogEmployeeSeName;			// SE 명
	private String customerUidLogEmployeeSalesName;			// 영업사원 명
	private String customerUidLogProductCheck;				// 제품 체크
	private String customerUidLogTosmsVer;					// TOSMS
	private String customerUidLogTosrfVer;					// TOSRF
	private String customerUidLogPortalVer;					// PORTAL
	private String customerUidLogJavaVer;					// JAVA
	private String customerUidLogOsType;
	private String customerUidLogWebServerVer;				// WAS
	private String customerUidLogDatabaseVer;				// DB
	private String customerUidLogLogServerVer;				// LogServer
	private String customerUidLogScvEaVer;					// ScvEA
	private String customerUidLogScvCaVer;					// ScvCA
	private String customerUidLogAuthPkiVer;				// Auth/PKI
	private String customerUidLogRegistrant;				// 추가 사용자
	private String customerUidLogRegistrationDate;			// 추가 날짜
	private String customerUidLogModifier;					// 수정 사용자
	private String customerUidLogModifiedDate;				// 수정 날짜
	
	private String customerUidEvent = "";				// 로그 발생 이벤트
	private String customerUidUser;						// 로그 발생 유저
	private String customerUidTime;						// 로그 발생 시간
	
	private String[] customerUidLogCustomerNameArr;
	private String[] customerUidLogBusinessNameArr;
	private String[] customerUidEventArr;
	
	private String customerUidDateStart;
	private String customerUidDateEnd;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="uidKeyNum";			// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
}
