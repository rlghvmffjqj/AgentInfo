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
	private String licenseType;
	private String productType;							// 제품 유형
	private String customerName;						// 고객사명
	private String businessName;						// 사업명
	private String additionalInformation;				// 추가정보
	private String macAddress;							// MAC 주소
	private String issueDate;							// 시작일
	private String expirationDays;						// 만료일
	private String igriffinAgentCount;						// iGRIFFIN Agent 개수
	private String tos5AgentCount;							// TOS 5.0 Agent 개수
	private String tos2AgentCount;							// TOS 2.0 Agent 개수
	private String dbmsCount;								// DBMS 개수
	private String networkCount;							// Network 개수
	private Integer aixCount;								// AIX 수량
	private Integer hpuxCount;								// hpux 수량
	private Integer solarisCount;							// solaris 수량
	private Integer linuxCount;								// linux 수량
	private Integer windowsCount;							// windows 수량
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
	
	private String productTypeView;							// 제품 유형
	private String customerNameView;						// 고객사명
	private String businessNameView;						// 사업명
	private String additionalInformationView;				// 추가정보
	private String macAddressView;							// MAC 주소
	private String issueDateView;							// 시작일
	private String expirationDaysView;						// 만료일
	private String igriffinAgentCountView;						// iGRIFFIN Agent 개수
	private String tos5AgentCountView;							// TOS 5.0 Agent 개수
	private String tos2AgentCountView;							// TOS 2.0 Agent 개수
	private String dbmsCountView;								// DBMS 개수
	private String networkCountView;							// Network 개수
	private Integer aixCountView;								// AIX 수량
	private Integer hpuxCountView;								// hpux 수량
	private Integer solarisCountView;							// solaris 수량
	private Integer linuxCountView;								// linux 수량
	private Integer windowsCountView;							// windows 수량
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
	
	private String customerNameSelf;
	private String businessNameSelf;
	
	private String viewType;
	private String btnType;
	
	private String chkLicenseIssuance;					// 라이선스 발급 여부
	
	private Integer page=1;							// 기본 페이지 번호
	private Integer rows=25;						// 데이터 보여줄 갯수
	private String sidx="licenseKeyNum";		// 정렬할 기준 데이터
	private String sord;
}
