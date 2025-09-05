package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Rgriffin {
	private Integer rgriffinKeyNum;
	private String rgriffinCompany;
	private String rgriffinCategory;
	private String rgriffinExpire;
	private String rgriffinQuantity;
	private String rgriffinRgmsid;
	private String rgriffinPassword;
	private String rgriffinFilePath;
	private String rgriffinRequester;
	
	private String rgriffinRegistrant;
	private String rgriffinRegistrationDate;
	private String rgriffinModifier;
	private String rgriffinModifiedDate;
	
	private String rgriffinCompanyView;
	private String rgriffinCategoryView;
	private String rgriffinExpireView;
	private String rgriffinQuantityView;
	private String rgriffinRgmsidView;
	private String rgriffinPasswordView;
	private String rgriffinFilePathView;
	private String rgriffinRequesterView;
	
	private String rgriffinExpireStart;
	private String rgriffinExpireEnd;
	
	private Integer page=1;							// 기본 페이지 번호
	private Integer rows=25;						// 데이터 보여줄 갯수
	private String sidx="rgriffinKeyNum";		// 정렬할 기준 데이터
	private String sord;
}
