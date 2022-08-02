package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class EmployeeUidLog {
	private int employeeUidLogKeyNum;				// Key
	private String employeeUidLogEmployeeId;		// 아이디
	private String employeeUidLogEmployeeName;		// 이름
	private String employeeUidLogDepartmentName;	// 부서	
	private String employeeUidLogEmployeeType;		// 타입
	private String employeeUidLogEmployeeRank;		// 직급
	private String employeeUidLogLoginTime;			// 시간
	
	private String[] employeeUidLogEmployeeIdArr;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="employeeUidLogLoginTime";			// 정렬할 기준 데이터
	private String sord;						// 오름차순, 내림차순
}
