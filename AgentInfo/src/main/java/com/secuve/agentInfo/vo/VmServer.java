package com.secuve.agentInfo.vo;

import java.util.List;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class VmServer {
	private int vmServerKeyNum;
	private String vmServerHostName;
	private String vmServerName;
	private String vmServerMemory;
	private String vmServerTime;
	private String vmServerStatus;
	
	private String[] vmServerHostNameArr;
	private String[] vmServerNameArr;
	private String[] vmServerStatusArr;
	
	private List<String> vmServerHostNameList;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="vmServerKeyNum";		// 정렬할 기준 데이터
	private String sord;
}
