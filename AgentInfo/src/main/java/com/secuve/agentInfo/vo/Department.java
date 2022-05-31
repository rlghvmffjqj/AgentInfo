package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Department {
	private String departmentFullPath;
	private String departmentParentPath;
	private String departmentName;
	
	private String newDepartmentFullPath;
	private String newDepartmentParentPath;
	private String newDepartmentName;
}