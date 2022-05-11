package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class CustomerBusinessMapping {
	private String customerName = "";			// 고객사명
	private String businessName = "";			// 사업명
}
