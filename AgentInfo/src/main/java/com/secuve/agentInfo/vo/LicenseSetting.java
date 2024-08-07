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
	private String windowsLicenseRoute;
	private String linuxLicense20Route;
	private String linuxLicense50Route;
	private String linuxLicense50OldRoute;
	private String licenseSettingIP;
	private String logGriffinRoute;
	private String logGriffinIP;
}
