package com.secuve.agentInfo.vo;

import java.util.List;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Issue {
	private int issuePrimaryKeyNum;
	private int issueKeyNum;
	private int issueSortNum;
	private String issueCustomer;				// 고객사
	private String issueTitle;					// Title
	private String issueDate;					// 전달일자
	private String issueTosms;					// TOSMS		
	private String issueTosrf;					// TOSRF
	private String issuePortal;					// PORTAL
	private String issueJava;					// JAVA
	private String issueWas;					// WAS
	private String issueDivision;				// 제목
	private String issueOs;						// OS
	private String issueWriter;					// 작성자
	private String issueAward;					// 대항목
	private String issueMiddle;					// 중항목
	private String issueUnder1;					// 소항목1
	private String issueUnder2;					// 소항목2
	private String issueUnder3;					// 소항목3
	private String issueUnder4;					// 소항목4
	private String issueFlawNum;				// 결함번호
	private String issueEffect;					// 영향도
	private String issueTextResult;				// 테스트 결과
	private String issueApplyYn;				// 적용여부
	private String issueConfirm;				// 확인내용
	private String issueObstacle;				// 장애내용
	private String issueNote;					// 비고
	private String issueAnswerStatus;
		
	private String issueRegistrant = "";		// 추가자
	private String issueRegistrationDate = "";	// 추가 시간
	private String issueModifier = "";			// 수정자
	private String issueModifiedDate = "";		// 수정 시간
	
	private String total;						// 전체
	private String solution;					// 해결
	private String unresolved;					// 미해결
	private String hold;						// 보류
	
	private String[] chkSelectBox;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="issueKeyNum";			// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
	
	private String[] issueCustomerArr;
	private String[] issueTitleArr;
	private String[] issueTosmsArr;
	private String[] issueTosrfArr;
	private String[] issuePortalArr;
	private String[] issueJavaArr;
	private String[] issueWasArr;
	
	private List<String> issueDivisionList;			// 제목
	private List<String> issueOsList;				// OS
	private List<String> issueWriterList;			// 작성자
	private List<String> issueAwardList;			// 대항목
	private List<String> issueMiddleList;			// 중항목
	private List<String> issueUnder1List;			// 소항목1
	private List<String> issueUnder2List;			// 소항목2
	private List<String> issueUnder3List;			// 소항목3
	private List<String> issueUnder4List;			// 소항목4
	private List<String> issueFlawNumList;			// 결함번호
	private List<String> issueEffectList;			// 영향도
	private List<String> issueTextResultList;		// 테스트 결과
	private List<String> issueApplyYnList;			// 적용여부
	private List<String> issueConfirmList;			// 확인내용
	private List<String> issueObstacleList;			// 장애내용
	private List<String> issueNoteList;				// 비고
	private List<Integer> issuePrimaryKeyNumList;
	
	private String issueDateStart;			// 전달일자  시작일
	private String issueDateEnd;				// 전달일자  종료일
}
