package com.secuve.agentInfo.vo.empDump;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class IfUser {
    private String user_id;
    private String user_number;
    private String user_name;
    private String user_phone;
    private String user_office;
    private String user_email;
    private String user_type_id;
    private String user_type_name;
    private String user_position_id;
    private String user_position_name;
    private String user_title_id;
    private String user_title_name;
    private String user_status_id;
    private String user_status_name;
    private String dept_id;
    private String dept_name;
    private String hierarchy_id;
    private String hierarchy_name;
    
    private String siteName;
    
    private int page = 1;      // 기본 페이지 번호
    private int rows = 25;      // 데이터 보여줄 갯수
    private String sidx = "user_id";   // 기본 정렬 기준 (예시: userId)
    private String sord;       // 오름차순, 내림차순

}
