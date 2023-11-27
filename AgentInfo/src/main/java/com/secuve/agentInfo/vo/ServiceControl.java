package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class ServiceControl {
	private int serviceControlKeyNum;
	private String serviceControlPurpose;
	private String serviceControlIp;
	private String serviceControlTomcat;
	private String serviceControlLogServer;
	private String serviceControlScvEA;
	private String serviceControlScvCA;
	private String serviceControlAgent;
	private String serviceControlDB;
	private String serviceControlDisk;
	private String serviceControlMemory;
	private String serviceControlFirewall;
}
