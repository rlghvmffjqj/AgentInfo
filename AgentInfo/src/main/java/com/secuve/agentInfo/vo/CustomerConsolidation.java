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
	private Integer customerConsolidationQuantity;				// 수량
	private String customerConsolidationBusinessPeriodStart;	// 사업기간
	private String customerConsolidationBusinessPeriodEnd;	 	// 사업기간
	private String customerConsolidationContractDate;			// 계약일
	
	private String customerConsolidationLocation;				// 사용처
	private String customerConsolidationEngineer;				// 엔지니어
	private String customerConsolidationEngineerId;
	private String customerConsolidationCustomerManager;		// 고객 담당자
	private String customerConsolidationEmail;					// 이메일
	private String customerConsolidationContact;				// 전화번호
	private String customerConsolidationDepartment; 			// 부서
	
	private String customerConsolidationRegistrant;
	private String customerConsolidationRegistrationDate;
	private String customerConsolidationModifier;
	private String customerConsolidationModifiedDate;
	
	
	
	private String customerConsolidationCustomerView;				// 고객사
	private String customerConsolidationBusinessView;				// 사업명
	private Integer customerConsolidationQuantityView;				// 수량
	private String customerConsolidationBusinessPeriodStartView;	// 사업기간
	private String customerConsolidationBusinessPeriodEndView;		// 사업기간
	private String customerConsolidationContractDateView;			// 계약일
	
	private String customerConsolidationLocationView;				// 사용처
	private String customerConsolidationEngineerView;				// 엔지니어
	private String customerConsolidationEngineerIdView;
	private String customerConsolidationCustomerManagerView;		// 고객 담당자
	private String customerConsolidationEmailView;					// 이메일
	private String customerConsolidationContactView;				// 전화번호
	
	
	private String[] customerConsolidationCustomerArr;				
	private String[] customerConsolidationBusinessArr;
	private String[] customerConsolidationLocationArr;				
	private String[] customerConsolidationEngineerArr;				
	private String[] customerConsolidationCustomerManagerArr;		
	private String[] customerConsolidationEmailArr;					
	private String[] customerConsolidationContactArr;
	private String[] customerConsolidationDepartmentArr;
	
	private String customerConsolidationContractDateStart;
	private String customerConsolidationContractDateEnd;
	
	
	private int page=1;							// 기본 페이지 번호
	private int rows=11;						// 데이터 보여줄 갯수
	private String sidx="customerConsolidationKeyNum";		// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
	
	
	private String employeeId;
	private String employeeName;
	
}
