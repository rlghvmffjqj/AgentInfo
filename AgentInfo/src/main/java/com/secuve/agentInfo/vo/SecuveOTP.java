package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class SecuveOTP {
	private Integer secuveOTPKeyNum;
	private String secuveOTPCreated;
	private String secuveOTPSite;
	private String secuveOTPMac;
	private String secuveOTPExpireym;
	private String secuveOTPLicense;
	private String secuveOTPBigo;
	private String secuveOTPFilePath;
	private String secuveOTPRequester;
	
	private String secuveOTPRegistrant;
	private String secuveOTPRegistrationDate;
	private String secuveOTPModifier;
	private String secuveOTPModifiedDate;
	
	private String secuveOTPCreatedView;
	private String secuveOTPSiteView;
	private String secuveOTPMacView;
	private String secuveOTPExpireymView;
	private String secuveOTPLicenseView;
	private String secuveOTPBigoView;
	private String secuveOTPFilePathView;
	private String secuveOTPRequesterView;
	
	private String secuveOTPCreatedStart;
	private String secuveOTPCreatedEnd;
	
	private Integer page=1;							// 기본 페이지 번호
	private Integer rows=25;						// 데이터 보여줄 갯수
	private String sidx="secuveOTPKeyNum";		// 정렬할 기준 데이터
	private String sord;
}
