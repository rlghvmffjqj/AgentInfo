package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class RGRIFFIN {
	private String rGRIFFINKeyNum;
	private String rGRIFFINCompany;
	private String rGRIFFINCategory;
	private String rGRIFFINExpire;
	private String rGRIFFINQuantity;
	private String rGRIFFINRgmsid;
	private String rGRIFFINPassword;
	private String rGRIFFINFilePath;
	private String rGRIFFINRequester;
	
	private String rGRIFFINRegistrant;
	private String rGRIFFINRegistrationDate;
	private String rGRIFFINModifier;
	private String rGRIFFINModifiedDate;
	
	private String rGRIFFINCompanyView;
	private String rGRIFFINCategoryView;
	private String rGRIFFINExpireView;
	private String rGRIFFINQuantityView;
	private String rGRIFFINRgmsidView;
	private String rGRIFFINPasswordView;
	private String rGRIFFINFilePathView;
	private String rGRIFFINRequesterView;
	
	private String rGRIFFINExpireStart;
	private String rGRIFFINExpireEnd;
	
	private Integer page=1;							// 기본 페이지 번호
	private Integer rows=25;						// 데이터 보여줄 갯수
	private String sidx="rGRIFFINKeyNum";		// 정렬할 기준 데이터
	private String sord;
}
