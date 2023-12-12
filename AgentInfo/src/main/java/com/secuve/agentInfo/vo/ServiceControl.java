package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class ServiceControl {
	private int serviceControlKeyNum;
	private String serviceControlPurpose;
	private String serviceControlIp;
	private String serviceControlPcPower;
	private String serviceControlTomcat;
	private String serviceControlLogServer;
	private String serviceControlScvEA;
	private String serviceControlScvCA;
	private String serviceControlAgent;
	private String serviceControlDB;
	private int serviceControlDisk;
	private double serviceControlMemory;
	private String serviceControlFirewall;
	private String serviceControlJavaVersion;
	private String serviceControlTomcatVersion;
	private String serviceControlKernel;
	private String serviceControlRelease;
	private String serviceControlPort;
	private String serviceControlServicePath;
	private String serviceControlTomcatPath;
	private String serviceControlDbType;
	private String serviceControlDate;
	private String serviceControlScvEAPath;
	private String serviceControlScvCAPath;
	private String serviceControlLogServerPath;
	
	
	private String serviceControlPurposeSearch;
	private String serviceControlIpSearch;
	
	private String[] serviceControlPurposeArr;
	private String[] serviceControlIpArr;
	
	private String service;
	private String status;
	private String serviceControlLogDate;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="serviceControlKeyNum";		// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
}
