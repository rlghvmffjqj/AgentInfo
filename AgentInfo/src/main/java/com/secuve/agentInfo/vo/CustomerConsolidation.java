package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class CustomerConsolidation {
	private int customerConsolidationKeyNum;					// 키 값	
	private String customerConsolidationCustomer;				// 고객사
	private String customerConsolidationBusiness;				// 사업명
	private int customerConsolidationQuantity;					// 수량
	private String customerConsolidationBusinessPeriod;			// 사업기간
	private String customerConsolidationContractDate;			// 계약일
	
	private String customerConsolidationLocation;				// 사용처
	private String customerConsolidationEngineer;				// 엔지니어
	private String customerConsolidationCustomerManager;		// 고객 담당자
	private String customerConsolidationEmail;					// 이메일
	private String customerConsolidationContact;				// 전화번호
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="customerConsolidationKeyNum";		// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
}
