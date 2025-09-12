package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class IntegratedManagement {
	private Integer integratedManagementKeyNum;
	private String integratedManagementType;
	private Integer packagesKeyNum;
	private Integer productVersionKeyNum;
	private Integer issuePrimaryKeyNum;
	private Integer resultsReportKeyNum;
	
	private String mainTitle;
	
	private String integratedManagementRegistrant = "";		// 추가자
	private String integratedManagementRegistrationDate = "";	// 추가 시간
	private String integratedManagementModifier = "";			// 수정자
	private String integratedManagementModifiedDate = "";		// 수정 시간
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="integratedManagementKeyNum";			// 정렬할 기준 데이터
	private String sord;
}
