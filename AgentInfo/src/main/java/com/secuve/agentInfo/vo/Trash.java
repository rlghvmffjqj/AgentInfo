package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Trash {
	private int trashKeyNum;
	private String trashCustomerName;
	private String trashBusinessName;
	private String trashRequestDate;
	private String trashDeliveryData;
	private String trashExistingNew;
	private String trashManagementServer;
	private String trashAgentOS;
	private String trashOsDetailVersion;
	private String trashGeneralCustom;
	private String trashOsType;
	private String trashAgentVer;
	private String trashPackageName;
	private String trashManager;
	private String trashRequestProductCategory;
	private String trashDeliveryMethod;
	private String trashNote;
	private String trashUser;
	private String trashTime;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="trashKeyNum";			// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
}
