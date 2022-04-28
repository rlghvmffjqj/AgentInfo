package com.secuve.agentInfo.core;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum Role {
	ADMIN("ROLE_ADMIN"),
	MEMBER("ROLE_MEMBER"),
	ENGINEER("ROLE_ENGINEER");
	
	private String value;
}
