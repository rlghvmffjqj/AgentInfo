package com.secuve.agentInfo.vo.empDump;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class VwUser {
	private String user_id;          // user_id
    private String user_name;        // user_name
    private String user_email;       // user_email
    private String user_tel;         // user_tel
    private String user_mobile;      // user_mobile
    private String user_dept;        // user_dept
    private String user_dept_name;   // user_dept_name
    private String pos_code;         // pos_code
    private String pos_name;         // pos_name
    private String user_type_sub;    // user_type_sub
    private String approv_type;      // approv_type
    private String other_group_id;   // other_group_id
    private String user_custom01;    // user_custom01
    private String user_custom02;    // user_custom02
    private String user_custom03;    // user_custom03
    
    private int page = 1;      // 기본 페이지 번호
    private int rows = 25;      // 데이터 보여줄 갯수
    private String sidx = "user_id";   // 기본 정렬 기준 (예시: userId)
    private String sord;
}
