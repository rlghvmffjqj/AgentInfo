package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class ServiceControlLog {
	private int serviceControlLogKeyNum;
	private String serviceControlLogIp;
	private String serviceControlLogService;
	private String serviceControlLogDetail;
	private String serviceControlLogDate;
}
