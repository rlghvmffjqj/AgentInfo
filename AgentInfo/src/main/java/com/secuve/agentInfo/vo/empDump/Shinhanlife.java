package com.secuve.agentInfo.vo.empDump;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Shinhanlife {
	private String empNum;
	private String deptCode;
	private String deptName;
	private String appointedStatus;
	
	private int page = 1;      // 기본 페이지 번호
    private int rows = 25;      // 데이터 보여줄 갯수
    private String sidx = "empNum";   // 기본 정렬 기준 (예시: userId)
    private String sord;
}
