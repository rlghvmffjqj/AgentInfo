package com.secuve.agentInfo.vo;

import java.util.Map;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class ProductVersion {
	private String productData;
	private int menuKeyNum;
	
	private Map<String, String> paramMap;

	private int page=1;							// 기본 페이지 번호
	private int rows=25;						// 데이터 보여줄 갯수
	private String sidx="1";		// 정렬할 기준 데이터
	private String sord;
}
