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
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="customerName";		// 정렬할 기준 데이터
	private String sord;
}

