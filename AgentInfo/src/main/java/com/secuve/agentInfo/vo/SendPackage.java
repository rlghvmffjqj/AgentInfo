package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class SendPackage {
	private Integer sendPackageKeyNum;
	private String sendPackageName;
	private String sendPackageStartDate;
	private String sendPackageEndDate;
	private Integer sendPackageCount;
	private Integer sendPackageLimitCount;
	private String sendPackageRandomUrl;
	private boolean sendPackageFlag;
	private String sendPackageRegistrant;
	private String sendPackageRegistrationDate;
	private String sendPackageModifier;
	private String sendPackageModifiedDate;	
	
	private String employeeNameView;
	private String sendPackageNameView;
	private String sendPackageStartDateView;
	private String sendPackageEndDateView;
	private Integer sendPackageLimitCountView;
	private Integer sendPackageCountView;
	
	private String customerName;
	private String businessName;
	private String networkClassification;
	private String manager;
	private String requestDate;
	private String managementServer;
	
	private String customerNameView;
	private String businessNameView;
	private String networkClassificationView;
	private String managerView;
	private String requestDateView;
	private String managementServerView;
	
	private String[] customerNameArr;
	private String[] businessNameArr;
	private String[] managementServerArr;
	
	private Integer packagesKeyNum;
	private String sendPackageKeyNumList;
	
	
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="sendPackageKeyNum";		// 정렬할 기준 데이터
	private String sord;
}
