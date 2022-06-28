package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Packages {
	private int packagesKeyNum;					// Key Number
	private int packagesKeyNumOrigin;			// 정렬을 위한 키 값
	private String customerName = "";			// 고객사명
	private String businessName = "";			// 사업명
	private String networkClassification = "";	// 망 구분
	private String requestDate = "";			// 요청일자
	private String deliveryData = "";			// 전달일자
	private String state = "";					// 상태
	private String existingNew = "";			// 기존/신규
	private String managementServer = "";		// 패키지 종류
	private String agentOS = "";				// Agent OS
	private String osDetailVersion = "";		// 패키지 상세버전
	private String generalCustom = "";			// 일반/커스텀
	private String osType = "";					// OS 종류
	private String agentVer = "";				// Agent ver
	private String packageName = "";			// 패키지명
	private String manager = "";				// 담당자
	private String requestProductCategory = "";	// 요청 제품구분
	private String deliveryMethod = "";			// 전달 방법
	private String note = "";					// 비고
	private String statusComment = "";			// 상태변경 의견
	
	// Modal에서 사용
	private String customerNameView;			// View 고객사명
	private String businessNameView;			// View 사업명
	private String networkClassificationView;		// View 망 구분
	private String requestDateView;				// View 요청일자
	private String deliveryDataView;			// View 전달일자
	private String stateView;					// View 상태
	private String existingNewView;				// View 기존/신규
	private String managementServerView;		// View 패키지 종류
	private String agentOSView;					// View Agent OS
	private String osDetailVersionView;			// View 패키지 상세버전
	private String generalCustomView;			// View 일반/커스텀
	private String osTypeView;					// View OS 종류
	private String agentVerView;				// View Agent ver
	private String packageNameView;				// View 패키지명
	private String managerView;					// View 담당자
	private String requestProductCategoryView;	// View 요청 제품구분
	private String deliveryMethodView;			// View 전달 방법
	private String noteView;					// View 비고
	
	// Select를 Input 으로 변경 시 사용
	private String customerNameSelf;			// Self 고객사명
	private String businessNameSelf;			// Self 사업명
	private String requestDateSelf;				// Self 요청일자
	private String deliveryDataSelf;			// Self 전달일자
	private String stateSelf;					// Self 상태
	private String existingNewSelf;				// Self 기존/신규
	private String managementServerSelf;		// Self 패키지 종류
	private String agentOSSelf;					// Self Agent OS
	private String osDetailVersionSelf;			// Self 패키지 상세버전
	private String generalCustomSelf;			// Self 일반/커스텀
	private String osTypeSelf;					// Self OS 종류
	private String agentVerSelf;				// Self Agent ver
	private String packageNameSelf;				// Self 패키지명
	private String managerSelf;					// Self 담당자
	private String requestProductCategorySelf;	// Self 요청 제품구분
	private String deliveryMethodSelf;			// Self 전달 방법
	private String noteSelf;					// Self 비고
	
	// 검색 시 ','를 기준으로 배열로 사용
	private String[] customerNameArr;
	private String[] businessNameArr;	
	private String[] networkClassificationArr;
	private String[] stateArr;
	private String[] existingNewArr;
	private String[] managementServerArr;
	private String[] agentOSArr;
	private String[] osDetailVersionArr;
	private String[] generalCustomArr;
	private String[] osTypeArr;
	private String[] agentVerArr;
	private String[] packageNameArr;
	private String[] managerArr;
	private String[] requestProductCategoryArr;
	private String[] deliveryMethodArr;
	
	private String deliveryDataStart;			// 전달일자  시작일
	private String deliveryDataEnd;				// 전달일자  종료일
	
	private String packagesRegistrant;			// 데이터 추가 사용자
	private String packagesRegistrationDate;	// 데이터 추가 날짜
	private String packagesModifier;			// 데이터 수정 사용자
	private String packagesModifiedDate;		// 데이터 수정 날짜
	
	private String excelImportYear;				// 엑셀 Import 년도
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="packagesKeyNumOrigin";		// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
	
	private String chartName;					// 차트 키
	private int chartCount;						// 차트 값
	
	private int chartColumn1;					// 차트 값1
	private int chartColumn2;					// 차트 값2
	private int chartColumn3;					// 차트 값3
	private int chartColumn4;					// 차트 값4
	private int chartColumn5;					// 차트 값5
}