package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class License5UidLog {
	private Integer license5UidLogKeyNum;
	private String productType;
	private String customerName;
	private String businessName;
	private String additionalInformation;
	private String macAddress;
	private String issueDate;
	private String expirationDays;
	private String igriffinAgentCount;
	private String tos5AgentCount;
	private String tos2AgentCount;
	private String dbmsCount;
	private String networkCount;
	private Integer aixCount;
	private Integer hpuxCount;
	private Integer solarisCount;
	private Integer linuxCount;
	private Integer windowsCount;
	private String managerOsType;
	private String managerDbmsType;
	private String country;
	private String productVersion;
	private String licenseFilePath;
	private String serialNumber;
	private String requester;
	private String license5UidLogEvent;
	private String license5UidUser;
	private String license5UidTime;
	private String license5IssuanceRegistrant;
	private String license5IssuanceRegistrationDate;
	private String license5IssuanceModifier;
	private String license5IssuanceModifiedDate;
	
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
	private String[] license5UidLogEventArr;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="license5UidLogKeyNum";		// 정렬할 기준 데이터
	private String sord;
}
