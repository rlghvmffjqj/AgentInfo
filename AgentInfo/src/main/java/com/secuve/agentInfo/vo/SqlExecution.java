package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class SqlExecution {
	private String sqlType;
	private String sqlIp;
	private String sqlPort;
	private String sqlUser;
	private String sqlPasswd;
	private String sqlQuery;
}
