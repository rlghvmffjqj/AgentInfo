package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Employee {
	private String employeeId;					// 사원 번호
	private String departmentName;				// 부서 이름
	private String departmentFullPath;			// 부서 풀 경로
	private String departmentParentPath;		// 부서 부모 경로
	private String employeeType;				// ex) 정사원, 외주
	private String employeeRank;				// ex) 연구원, 선임, 대리, 과장
	private String employeeName;				// 사원 이름
	private String employeePhone;				// 휴대폰 번호
	private String employeeEmail;				// 이메일
	private String employeeStatus;				// ex) 휴직, 재직, 퇴사
	private String lastLogin;
	
	private String employeeRegistrant;			// 데이터 추가 사용자
	private String employeeRegistrationDate;	// 데이터 추가 날짜
	private String employeeModifier;			// 데이터 수정 사용자
	private String employeeModifiedDate;		// 데이터 수정 날짜
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="employeeId";			// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
	
	private String usersRole;					// 사용자 역할 ex) 사용자, 관리자, 일반사용자
	private String usersPw;						// 사용자 패스워드
	private String pwdChangeYn;					// 패스워드 변경 유무
	private String usersLockStatus;
}