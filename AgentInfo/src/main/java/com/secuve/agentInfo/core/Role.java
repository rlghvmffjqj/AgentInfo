package com.secuve.agentInfo.core;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 사용자 권한
 * @author rlghv
 *
 */
@AllArgsConstructor
@Getter
public enum Role {
	ADMIN("ROLE_ADMIN"),
	MEMBER("ROLE_MEMBER"),
	ENGINEER("ROLE_ENGINEER"),
	ENGINEERLEADER("ROLE_ENGINEERLEADER"),
	SALES("ROLE_SALES"),
	LICENSE("ROLE_LICENSE"),
	QA("ROLE_QA");
	
	private String value;
}