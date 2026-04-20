package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class SeleniumGroup {
	private String seleniumGroupFullPath;
	private String seleniumGroupParentPath;
	private String seleniumGroupName;
	
	private String newSeleniumGroupFullPath;
	private String newSeleniumGroupParentPath;
	private String newSeleniumGroupName;
}
