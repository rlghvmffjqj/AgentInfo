package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class LicenseSetting {
	private String employeeId;
	private String windowsLicenseRoute;
	private String linuxLicense20Route;
	private String linuxLicense50Route;
	private String licenseSettingIP;
}
