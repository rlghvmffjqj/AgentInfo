package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class WebControl {
	private String cmdIp;
	private String cmdUser;
	private String cmdPasswd;
	private String command;
}
