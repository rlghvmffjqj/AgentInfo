package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class License {
	private int licenseKeyNum;			// 라이센스 기본 키
	private int licenseKeyNumOrigin;			// 라이센스 정렬 사용
	private String licenseType;			// 라이센스 타입
	private String customerName;		// 업체명
	private String businessName;		// 사업명
	private String issueDate;			// 발급 날짜
	private String requester;			// 요청자
	private String partners;			// 협력사명
	private String osType;				// OS종류
	private String osVersion;			// OS버전
	private String kernelVersion;		// 커널버전
	private String kernelBit;			// 커널비트
	private String tosVersion;			// TOS버전
	private String period;				// 기간
	private String macUmlHostId;		// MAC / UML / HostId 정보
	private String releaseType;			// 릴리즈타입
	private String deliveryMethod;		// 전달 방법
	private String licenseIssueKey;		// 라이센스 발급 키
	private String licenseIssueAnswer;  // 리눅스 라이센스 결과 Full
	private String licenseIssueCommand; // 리눅스 라이센스 발급 명령어
	
	private String periodYearSelf;
	private String periodMonthSelf;
	private String periodDaySelf;
	private String viewType;
	private String btnType;
	
	private String licenseRegistrant;
	private String licenseRegistrationDate;
	private String licenseModifier;
	private String licenseModifiedDate;
	
	private String issueDateStart;
	private String issueDateEnd;
	
	private String customerNameView;
	private String businessNameView;
	private String issueDateView;
	private String requesterView;
	private String partnersView;
	private String osTypeView;
	private String osVersionView;
	private String kernelVersionView;
	private String kernelBitView;
	private String tosVersionView;
	private String periodView;
	private String macUmlHostIdView;
	private String releaseTypeView;
	private String deliveryMethodView;

	private String[] customerNameArr;
	private String[] businessNameArr;
	private String[] requesterArr;
	private String[] partnersArr;
	private String[] osTypeArr;
	private String[] osVersionArr;
	private String[] kernelVersionArr;
	private String[] tosVersionArr;
	private String[] macUmlHostIdArr;
	private String[] releaseTypeArr;
	private String[] deliveryMethodArr;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="licenseKeyNumOrigin";		// 정렬할 기준 데이터
	private String sord;
}
