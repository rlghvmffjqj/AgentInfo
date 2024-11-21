package com.secuve.agentInfo.vo.empDump;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class ViewSamsung {
	private String empnum;
    private String accountname;
    private String koreanname;
    private String jobposition;
    private String email;
    private String mobilephone;
    private String officephone;
    private String companyname;
    private String employeestatus;

    private String employeeid;
    private String jobresponsibility;
    private String jobduty;
    private String telephonenumber;
    private String departmentcode;

    private String parentdepartmentcode;
    
    private String EmpType;
    private String EmpName;
    private String JobTitle;
    private String JobName;
    private String Mobile;
    private String Phone;
    private String DeptFullPath;
    private String DeptParentPath;
    private String DeptName;
    private String EmpStatus;
    private String Company;
    
    private int page = 1;      // 기본 페이지 번호
    private int rows = 25;      // 데이터 보여줄 갯수
    private String sidx = "accountname";   // 기본 정렬 기준 (예시: userId)
    private String sord;
}
