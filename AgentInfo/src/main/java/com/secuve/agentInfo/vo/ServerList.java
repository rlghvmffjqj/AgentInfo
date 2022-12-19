package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class ServerList {
	private int serverListKeyNum;				// Key
	private String serverListType;				// 외부망/내부망/Hyper-V
	private String serverListDivision;			// 구분
	private String serverListIp;				// IP
	private String serverListState;				// 상태
	private String serverListMac;				// MAC
	private String serverListAssetNum;			// 자산번호
	private String serverListHostName;			// HostName
	private String serverListPurpose;			// 용도
	private String serverListOs;				// 운영체제
	private String serverListServerClass;		// 서버구분
	private String serverListRackPosition;		// 랙위치
	private String serverListPeriodUse;
	private String serverListPeriodUseEnd;			// 사용기간
	private String serverListPeriodUseStart;
	private String serverListUser;				// 사용자
	private String serverListManager;			// 관리자
	private String serverListLastModifiedDate;	// 최종 수정일
	private String serverListNote;				// 비고
	private int calendarKeyNum;
	
	private String serverListTypeView;				// 외부망/내부망/Hyper-V
	private String serverListDivisionView;			// 구분
	private String serverListIpView;				// IP
	private String serverListStateView;				// 상태
	private String serverListMacView;				// MAC
	private String serverListAssetNumView;			// 자산번호
	private String serverListHostNameView;			// HostName
	private String serverListPurposeView;			// 용도
	private String serverListOsView;				// 운영체제
	private String serverListServerClassView;		// 서버구분
	private String serverListRackPositionView;		// 랙위치
	private String serverListPeriodUseEndView;			// 사용기간
	private String serverListPeriodUseStartView;
	private String serverListUserView;				// 사용자
	private String serverListManagerView;			// 관리자
	private String serverListLastModifiedDateView;	// 최종 수정일
	private String serverListNoteView;				// 비고
	
	private String[] serverListDivisionArr;			// 구분
	private String[] serverListIpArr;					// IP
	private String[] serverListStateArr;				// 상태
	private String[] serverListMacArr;				// MAC
	private String[] serverListAssetNumArr;			// 자산번호
	private String[] serverListHostNameArr;			// HostName
	private String[] serverListPurposeArr;			// 용도
	private String[] serverListOsArr;					// 운영체제
	private String[] serverListServerClassArr;		// 서버구분
	private String[] serverListRackPositionArr;		// 랙위치
	
	private String serverListRegistrant;
	private String serverListRegistrationDate;
	private String serverListModifier;
	private String serverListModifiedDate;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="serverListKeyNum";		// 정렬할 기준 데이터
	private String sord;
}
