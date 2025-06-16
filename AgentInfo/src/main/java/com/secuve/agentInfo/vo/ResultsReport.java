package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class ResultsReport {
	private int resultsReportKeyNum;
	private String resultsReportCustomerName;				// 타이틀
	private String resultsReportNumber;						// 문서번호
	private String resultsReportClient;						// 의뢰자
	private String resultsReportVerifier;					// 검증자
	private String resultsReportReviewer;					// 검토자
	private String resultsReportContent;
	private String resultsReportDate;
	private String resultsReportTestDate;
	private String resultsReportTemplate;
	private String resultsreportDelNote;
	
	private String[] resultsReportNumberArr;
	private String[] resultsReportCustomerNameArr;
	private String resultsReportDateStart;
	private String resultsReportDateEnd;
	
	private String resultsReportRegistrant;
	private String resultsReportRegistrationDate;
	private String resultsReportModifier;
	private String resultsReportModifiedDate;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="resultsReportKeyNum";			// 정렬할 기준 데이터
	private String sord;

}
