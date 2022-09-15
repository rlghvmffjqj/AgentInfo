package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class PackageUidLog {
	private int uidKeyNum;						// Key
	private String uidCustomerName = "";		// 고객사명
	private String uidOsDetailVersion;			// OS 버전
	private String uidPackageName;				// 패키지명
	private String packagesKeyNum;				// 패키지 Key
	private String uidEvent = "";				// 로그 발생 이벤트
	private String uidUser;						// 로그 발생 유저
	private String uidTime;						// 로그 발생 시간
	
	private String[] uidCustomerNameArr;
	private String[] uidEventArr;
	
	private String uidDateStart;
	private String uidDateEnd;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="uidKeyNum";			// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
}