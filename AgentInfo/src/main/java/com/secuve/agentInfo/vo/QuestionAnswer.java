package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class QuestionAnswer {
	private Integer questionAnswerKeyNum;
	private String questionAnswerTitle;
	private String questionAnswerDetail;
	private String employeeId;
	private String questionAnswerDate;
	private int questionAnswerCount;
	private String questionAnswerState;
	private String questionAnswerRegistrant;
	private String questionAnswerRegistrationDate;
	private String questionAnswerModifier;
	private String questionAnswerModifiedDate;
	
	private String employeeName;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="questionAnswerCount";		// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
}
