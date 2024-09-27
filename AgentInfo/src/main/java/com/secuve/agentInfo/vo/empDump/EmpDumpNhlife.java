package com.secuve.agentInfo.vo.empDump;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class EmpDumpNhlife {
	private String userId;
    private String userNumber;
    private String userName;
    private String userPhone;
    private String userOffice;
    private String userEmail;
    private String userTypeId;
    private String userTypeName;
    private String userPositionId;
    private String userPositionName;
    private String userTitleId;
    private String userTitleName;
    private String userStatusId;
    private String userStatusName;
    private String deptId;
    private String deptName;
    private String hierarchyId;
    private String hierarchyName;
}
