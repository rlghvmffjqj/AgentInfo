package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class GeneralPackage {
	private int generalPackageKeyNum;			// Key
	private String managementServer;			// 패키지 종류
	private String agentVer;					// Version
	private String releaseNotes;
	
	private String generalPackageRegistrant;			// 데이터 추가 사용자
	private String generalPackageRegistrationDate;	// 데이터 추가 날짜
	private String generalPackageModifier;			// 데이터 수정 사용자
	private String generalPackageModifiedDate;		// 데이터 수정 날짜
	
	private String managementServerView;			// 패키지 종류
	private String agentVerView;					// Version\
	
	
	private String managementServerSelf;			// 패키지 종류
	private String agentVerSelf;					// Version
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="managementServer";		// 정렬할 기준 데이터
	private String sord;
	
}
