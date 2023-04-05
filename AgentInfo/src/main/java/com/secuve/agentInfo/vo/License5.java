package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class License5 {
	private Integer licenseKeyNum;					// Key
	private String productType;							// 제품 유형
	private String customerName;						// 고객사명
	private String businessName;						// 사업명
	private String additionalInformation;				// 추가정보
	private String macAddress;							// MAC 주소
	private String issueDate;							// 시작일
	private String expirationDays;						// 만료일
	private String iGRIFFINAgentCount;						// iGRIFFIN Agent 개수
	private String tos5AgentCount;							// TOS 5.0 Agent 개수
	private String tos2AgentCount;							// TOS 2.0 Agent 개수
	private String dbmsCount;								// DBMS 개수
	private String networkCount;							// Network 개수
	private String managerOsType;						// 관리서버 OS
	private String managerDbmsType;						// 관리서버 DBMS
	private String country;								// 국가
	private String productVersion;						// 제품버전
	private String licenseFilePath;						// 라이선스 파일명
	private String serialNumber;						// 일련 번호
	private String requester;							// 요청자
	private String licenseIssuanceRegistrant;
	private String licenseIssuanceRegistrationDate;
	private String licenseIssuanceModifier;
	private String licenseIssuanceModifiedDate;
	
	private String productTypeSelf;							// 제품 유형
	private String customerNameSelf;						// 고객사명
	private String businessNameSelf;						// 사업명
	private String additionalInformationSelf;				// 추가정보
	private String macAddressSelf;							// MAC 주소
	private String managerOsTypeSelf;						// 관리서버 OS
	private String managerDbmsTypeSelf;						// 관리서버 DBMS
	private String productVersionSelf;						// 제품버전
	private String licenseFilePathSelf;						// 라이선스 파일명
	private String requesterSelf;							// 요청자
	
	private String productTypeView;							// 제품 유형
	private String customerNameView;						// 고객사명
	private String businessNameView;						// 사업명
	private String additionalInformationView;				// 추가정보
	private String macAddressView;							// MAC 주소
	private String issueDateView;							// 시작일
	private String expirationDaysView;						// 만료일
	private String iGRIFFINAgentCountView;						// iGRIFFIN Agent 개수
	private String tos5AgentCountView;							// TOS 5.0 Agent 개수
	private String tos2AgentCountView;							// TOS 2.0 Agent 개수
	private String dbmsCountView;								// DBMS 개수
	private String networkCountView;							// Network 개수
	private String managerOsTypeView;						// 관리서버 OS
	private String managerDbmsTypeView;						// 관리서버 DBMS
	private String countryView;								// 국가
	private String productVersionView;						// 제품버전
	private String licenseFilePathView;						// 라이선스 파일명
	private String serialNumberView;						// 일련 번호
	private String requesterView;							// 요청자
	
	private String[] productTypeArr;							// 제품 유형
	private String[] customerNameArr;						// 고객사명
	private String[] businessNameArr;						// 사업명
	private String[] additionalInformationArr;				// 추가정보
	private String[] macAddressArr;							// MAC 주소
	private String[] managerOsTypeArr;						// 관리서버 OS
	private String[] managerDbmsTypeArr;						// 관리서버 DBMS
	private String[] productVersionArr;						// 제품버전
	private String[] licenseFilePathArr;						// 라이선스 파일명
	private String[] serialNumberArr;						// 일련 번호
	private String[] requesterArr;							// 요청자
	private String[] countryArr;								// 국가
	
	private String expirationDaysYearSelf;
	private String expirationDaysMonthSelf;
	private String expirationDaysDaySelf;
	private String viewType;
	private String btnType;
	
	private Integer page=1;							// 기본 페이지 번호
	private Integer rows=25;						// 데이터 보여줄 갯수
	private String sidx="licenseKeyNum";		// 정렬할 기준 데이터
	private String sord;
}
