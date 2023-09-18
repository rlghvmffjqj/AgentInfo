package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Question {
	private Integer questionKeyNum;
	private String questionTitle;
	private String questionDetail;
	private String employeeId;
	private String questionDate;
	private int questionCount;
	private String questionState;
	private String questionRegistrant;
	private String questionRegistrationDate;
	private String questionModifier;
	private String questionModifiedDate;
	
	private String employeeName;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="questionCount";		// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
}
