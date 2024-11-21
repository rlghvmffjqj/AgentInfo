package com.secuve.agentInfo.vo.empDump;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class ViewNac {
	private String org_cd;		// 부서 코드
	private String org_nm;		// 부서명
	
	private String pos_cd;		// 직급 코드
	private String pos_nm;		// 직급명
	 
	private String chf_sabun;	// 상사 사번
	
	private String sabun;		// 사번
	private String jumin_no;	// 주민번호
	private String NAME;		// 이름
	private String status;		// 상태
	private String office_tel;	// 사무실번호
	private String mail_id;		// 이메일
	
	private int page = 1;      // 기본 페이지 번호
    private int rows = 25;      // 데이터 보여줄 갯수
    private String sidx = "sabun";   // 기본 정렬 기준 (예시: userId)
    private String sord;
}
