package com.secuve.agentInfo.vo.empDump;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class NACView {
	private String user_id;
	private String user_name;
	private String user_password;
	private String user_dept;
	private String user_position;

	private String position_code;
	private String position_name;
	
	private String joblevel;
	private String emptype;
	private String empstatus;
	
	private String dept_code;
	private String dept_pcode;
	private String dept_name;
	
	private int page = 1;      // 기본 페이지 번호
    private int rows = 25;      // 데이터 보여줄 갯수
    private String sidx = "USER_ID";   // 기본 정렬 기준 (예시: userId)
    private String sord;
}
