package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class LogGriffin {
	private Integer logGriffinKeyNum;	
	private String licenseType;
	private String customerName;			// 발급대상(고객사)
	private String businessName;			// 사업명
	private String macAddress;				// MAC
	private String productName;				// 제품명
	private String productVersion;			// 제품 버전
	private String agentCount;				// 에이전트
	private String agentLisCount;			// 에이전트리스 
	private String issueDate;				// 발급일
	private String expirationDays;			// 만료일
	private String additionalInformation;	// 추가정보
	private String serialNumber;			// KEY
	private String licenseFilePath;			// 라이선스 파일명
	private String requester;				// 요청자
	private String salesManagerName;
			
	private String customerNameView;			// 발급대상(고객사)
	private String businessNameView;			// 사업명
	private String macAddressView;				// MAC
	private String productNameView;				// 제품명
	private String productVersionView;			// 제품 버전
	private String agentCountView;				// 에이전트
	private String agentLisCountView;			// 에이전트리스 
	private String issueDateView;				// 발급일
	private String expirationDaysView;			// 만료일
	private String additionalInformationView;	// 추가정보
	private String serialNumberView;			// KEY
	private String licenseFilePathView;			// 라이선스 파일명
	private String requesterView;				// 요청자
	private String salesManagerId;
	private String salesManagerNameView;
	private String requesterId;
	
	private String licenseTypeView;
	private String[] customerNameArr;
	private String[] businessNameArr;
	private String[] macAddressArr;
	private String[] productNameArr;
	private String[] productVersionArr;
	private String[] serialNumberArr;
	private String[] licenseFilePathArr;
	private String[] requesterArr;
	
	private String issueDateStart;
	private String issueDateEnd;
	private String expirationDaysStart;
	private String expirationDaysEnd;
	
	private String logGriffinRegistrant;
	private String logGriffinRegistrationDate;
	private String logGriffinModifier;
	private String logGriffinModifiedDate;
	
	private String chkLicenseIssuance;					// 라이선스 발급 여부
	
	
	private Integer page=1;							// 기본 페이지 번호
	private Integer rows=25;						// 데이터 보여줄 갯수
	private String sidx="issueDate";		// 정렬할 기준 데이터
	private String sord;
	
}
