package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class IssueHistory {
	private int issueHistoryKeyNum;
	private int issueKeyNum;
	private String issueHistoryCustomer;
	private String issueHistoryTitle;
	private String issueHistoryDate;
	private String issueHistoryTosms;
	private String issueHistoryTosrf;
	private String issueHistoryPortal;
	private String issueHistoryJava;
	private String issueHistoryWas;
	private String issueHistoryTotal;
	private String issueHistoryPdf;
	private String issueHistoryRegistrant;			// 추가자
	private String issueHistoryRegistrationDate;	// 추가 시간
	private String issueHistoryModifier;			// 수정자
	private String issueHistoryModifiedDate;		// 수정 시간
}
