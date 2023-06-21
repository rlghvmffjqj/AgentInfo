package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class FunctionTestSetting {
	private Integer functionTestSettingFormKeyNum;
	private String functionTestSettingFormName;
	private String functionTestSettingDivision;
	private String functionTestSettingFormRegistrant;
	private String functionTestSettingFormRegistrationDate;
	private String functionTestSettingFormModifier;
	private String functionTestSettingFormModifiedDate;

	private Integer functionTestSettingCategoryKeyNum;
	private String functionTestSettingCategoryName;
	private String functionTestSettingCategoryRegistrant;
	private String functionTestSettingCategoryRegistrationDate;
	private String functionTestSettingCategoryModifier;
	private String functionTestSettingCategoryModifiedDate;

	private Integer functionTestSettingSubCategoryKeyNum;
	private String functionTestSettingSubCategoryName;
	private String functionTestSettingSubCategoryState;
	private String functionTestSettingSubCategoryFailReason;
	private String functionTestSettingSubCategoryTortal;
	private String functionTestSettingSubCategoryBasic;
	private String functionTestSettingSubCategoryFoundation;
	private String functionTestSettingSubCategoryRegistrant;
	private String functionTestSettingSubCategoryRegistrationDate;
	private String functionTestSettingSubCategoryModifier;
	private String functionTestSettingSubCategoryModifiedDate;

	private Integer functionTestSettingDetailKeyNum;
	private String functionTestSettingDetailMethod;
	private String functionTestSettingDetailRegistrant;
	private String functionTestSettingDetailRegistrationDate;
	private String functionTestSettingDetailModifier;
	private String functionTestSettingDetailModifiedDate;
}
