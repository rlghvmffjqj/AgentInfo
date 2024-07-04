package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class IssueRelay {
	private int issueRelayKeyNum;
	private String issueRelayUrl;
	private int issueKeyNum;
	private int issuePrimaryKeyNum;
	private String issueRelayDetail;
	private String issueRelayType;
	private String issueRelayStatus;
	private String issueRelayDate;
}
