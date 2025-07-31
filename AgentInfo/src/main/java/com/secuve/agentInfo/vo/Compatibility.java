package com.secuve.agentInfo.vo;

import java.util.List;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class Compatibility {
	private int productVersionKeyNum;
	private String mainMenuTitle;
	private String subMenuTitle;
	private String packageName;
	private String location;
	private String packageDate;
	private int menuKeyNum;
	private List<String> productVersionTable;
	
	private String mainTitleView;
	private String subTitleView;
	private String packageNameView;
	private String locationView;
	
	private int productVersionKeyNum1;
	private int productVersionKeyNum2;
	private int menuKeyNum1;
	private int menuKeyNum2;
	private int[] productVersionKeyNumArr = new int[0];
	private String mapperType;
	

	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="productVersionKeyNum";		// 정렬할 기준 데이터
	private String sord;
}
