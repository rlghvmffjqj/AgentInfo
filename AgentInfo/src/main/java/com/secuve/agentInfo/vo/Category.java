package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Category {
	private int categoryKeyNum;					// 번호
	private String categoryName;				// 키
	private String categoryValue;				// 값
	
	private String[] categoryValueArr;
	
	private String categoryRegistrant;			// 데이터 추가 사용자
	private String categoryRegistrationDate;	// 데이터 추가 날짜
	private String categoryModifier;			// 데이터 수정 사용자
	private String categoryModifiedDate;		// 데이터 수정 날짜
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="categoryName";			// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
}