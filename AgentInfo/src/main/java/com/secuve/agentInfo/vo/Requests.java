package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Requests {
	private int requestsKeyNum;					// 요청 사항 키
	private String employeeId = "";					// 사원 아이디
	private String requestsTitle;				// 요청 제목
	private String requestsDetail;				// 요청 내용
	private String requestsState = "";				// 요청 상태
	private String requestsDate;				// 요청 시간
	private String requestsRegistrant;			// 추가 사용자
	private String requestsRegistrationDate;	// 추가 날짜
	private String requestsModifier;			// 수정 사용자
	private String requestsModifiedDate;		// 수정 날짜
	
	private String employeeName = "";
	private String usersId;
	
	private String[] employeeIdArr;
	private String[] employeeNameArr;
	private String[] requestsStateArr;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="requestsKeyNum";			// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
}