package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class UIDLog {
	private int uidKeyNum;
	private String uidCustomerName;
	private String uidOsDetailVersion;
	private String uidPackageName;
	private String uidEvent;
	private String uidUser;
	private String uidTime;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="uidKeyNum";			// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
	
}
