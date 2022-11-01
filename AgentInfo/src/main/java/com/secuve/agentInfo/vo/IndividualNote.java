package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class IndividualNote {
	private int individualNoteKeyNum;
	private String individualNoteTitle;
	private String individualNoteContents;
	private String individualNoteRegistrant;
	private String individualNoteRegistrationDate;
	
	private String individualNoteTitleView;
	private String individualNoteContentsView;
}
