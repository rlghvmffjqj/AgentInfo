package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class SendMailSetting {
	private int sendMailSettingKeyNum;
	private String sendMailSettingTarget;
	private String sendMailSettingManager;
	private String sendMailSettingSubject;
	private int sendMailSettingSingle;
	private int sendMailSettingDaily;
	private String sendMailSettingRequester;
	private String sendMailSettingSalesManager;
	private String sendMailSettingIssuance;
}
