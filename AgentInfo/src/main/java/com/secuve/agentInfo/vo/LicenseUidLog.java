package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class LicenseUidLog {
	private int licenseUidLogKeyNum;				// 라이선스 기본 키
	private String licenseUidLogLicenseType;		// 라이선스 타입
	private String licenseUidLogCustomerName;		// 업체명
	private String licenseUidLogBusinessName;		// 사업명
	private String licenseUidLogIssueDate;			// 발급 날짜
	private String licenseUidLogRequester;			// 요청자
	private String licenseUidLogPartners;			// 협력사명
	private String licenseUidLogOsType;				// OS종류
	private String licenseUidLogOsVersion;			// OS버전
	private String licenseUidLogKernelVersion;		// 커널버전
	private String licenseUidLogKernelBit;			// 커널비트
	private String licenseUidLogTosVersion;			// TOS버전
	private String licenseUidLogPeriod;				// 기간
	private String licenseUidLogMacUmlHostId;		// MAC / UML / HostId 정보
	private String licenseUidLogReleaseType;		// 릴리즈타입
	private String licenseUidLogDeliveryMethod;		// 전달 방법
	private String licenseUidLogIssueKey;			// 라이선스 발급 키
	
	private String licenseUidLogEvent = "";				// 로그 발생 이벤트
	private String licenseUidUser;						// 로그 발생 유저
	private String licenseUidTime;						// 로그 발생 시간
	
	private String licenseUidLogRegistrant;
	private String licenseUidLogRegistrationDate;
	private String licenseUidLogModifier;
	private String licenseUidLogModifiedDate;
	
	private String licenseUidLogIssueDateStart;
	private String licenseUidLogIssueDateEnd;
	
	private String[] licenseUidLogCustomerNameArr;
	private String[] licenseUidLogBusinessNameArr;
	private String[] licenseUidLogRequesterArr;
	private String[] licenseUidLogPartnersArr;
	private String[] licenseUidLogOsTypeArr;	
	private String[] licenseUidLogOsVersionArr;
	private String[] licenseUidLogKernelVersionArr;
	private String[] licenseUidLogTosVersionArr;
	private String[] licenseUidLogMacUmlHostIdArr;
	private String[] licenseUidLogReleaseTypeArr;	
	private String[] licenseUidLogDeliveryMethodArr;
	private String[] licenseUidLogEventArr;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="licenseUidLogKeyNum";			// 정렬할 기준 데이터
	private String sord;	
}
