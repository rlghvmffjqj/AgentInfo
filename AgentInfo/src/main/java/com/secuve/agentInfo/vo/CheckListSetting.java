package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class CheckListSetting {
	private Integer checkListSettingFormKeyNum;
	private String checkListSettingFormName;
	private String checkListSettingDivision;
	private String checkListSettingFormRegistrant;
	private String checkListSettingFormRegistrationDate;
	private String checkListSettingFormModifier;
	private String checkListSettingFormModifiedDate;

	private Integer checkListSettingCategoryKeyNum;
	private String checkListSettingCategoryName;
	private String checkListSettingCategoryRegistrant;
	private String checkListSettingCategoryRegistrationDate;
	private String checkListSettingCategoryModifier;
	private String checkListSettingCategoryModifiedDate;

	private Integer checkListSettingSubCategoryKeyNum;
	private String checkListSettingSubCategoryName;
	private String checkListSettingSubCategoryState;
	private String checkListSettingSubCategoryFailReason;
	private String checkListSettingSubCategoryRegistrant;
	private String checkListSettingSubCategoryRegistrationDate;
	private String checkListSettingSubCategoryModifier;
	private String checkListSettingSubCategoryModifiedDate;

	private Integer checkListSettingDetailKeyNum;
	private String checkListSettingDetailMethod;
	private String checkListSettingDetailRegistrant;
	private String checkListSettingDetailRegistrationDate;
	private String checkListSettingDetailModifier;
	private String checkListSettingDetailModifiedDate;
}
