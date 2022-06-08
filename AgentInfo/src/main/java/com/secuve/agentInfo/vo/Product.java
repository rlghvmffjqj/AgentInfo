package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Product {
	private int productKeyNum;
	private String customerName;
	private String businessName;
	private String productCheck;
	private String tosmsVer;
	private String tosrfVer;
	private String portalVer;
	private String javaVer;
	private String webServerVer;
	private String databaseVer;
	private String logServerVer;
	private String scvEaVer;
	private String scvCaVer;
	private String authPkiVer;
	private String employeeSeName;
	private String employeeSalesName;
	private String productRegistrant;
	private String productRegistrationDate;
	private String productModifier;
	private String productModifiedDate;
	
	private String customerNameView;
	private String businessNameView;
	private String productCheckView;
	private String tosmsVerView;
	private String tosrfVerView;
	private String portalVerView;
	private String javaVerView;
	private String webServerVerView;
	private String databaseVerView;
	private String logServerVerView;
	private String scvEaVerView;
	private String scvCaVerView;
	private String authPkiVerView;
	private String employeeSeNameView;
	private String employeeSalesNameView;
	
	private String customerNameSelf;			// Self 고객사명
	private String businessNameSelf;			// Self 사업명
	
	private String[] customerNameArr;
	private String[] businessNameArr;	
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="customerName";			// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
}
