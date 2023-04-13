package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class CategoryBusiness {
	private int categoryBusinessKeyNum;
	private String categoryCustomerName;
	private String categoryBusinessName;
	private String categoryBusinessRegistrant;
	private String categoryBusinessRegistrationDate;
	private String categoryBusinessModifier;
	private String categoryBusinessModifiedDate;
	
	private String categoryCustomerNameView;
	private String categoryBusinessNameView;
	
	private String[] categoryCustomerNameArr;
	private String[] categoryBusinessNameArr;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="categoryCustomerName";			// 정렬할 기준 데이터
	private String sord;

}
