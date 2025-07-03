package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class MenuSetting {
	private int menuKeyNum;
	private int menuSort;
	private String menuType;
	private String menuTitle;
	private String menuTitleKor;
	private int menuParentKeyNum;
	private String menuItemType;
	private String menuSettingRegistrant;
	private String menuSettingRegistrationDate;
	private String menuSettingModifier;
	private String menuSettingModifiedDate;
	
	private String mainKeyNum;
	private String subKeyNum;
	private String tableName;
	private String menuParentTitle;
	private String oldTitle;
	private int productVersionKeyNum;
	
	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="menuSort";		// 정렬할 기준 데이터
	private String sord;
}
