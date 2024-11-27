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
    private String user_dept;        // user_dept
    private String user_dept_name;   // user_dept_name
    private String res_name;         // pos_code
    private String user_position_name;
    private String joblevel;
    private String user_type_sub;    // user_type_sub
    private String emptype;
    private String other_group_id;   // other_group_id
    private String user_custom01;    // user_custom01
    private String user_custom02;    // user_custom02
    private String user_custom03;    // user_custom03
    private String encodingsalt;
    private String encodingtype;
    private String loginpwd;
    
    private int page = 1;      // 기본 페이지 번호
    private int rows = 25;      // 데이터 보여줄 갯수
    private String sidx = "user_id";   // 기본 정렬 기준 (예시: userId)
    private String sord;
}
