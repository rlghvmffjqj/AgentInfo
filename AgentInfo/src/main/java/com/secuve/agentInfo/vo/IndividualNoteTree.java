package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class IndividualNoteTree {
	private String individualNoteTreeFullPath;
	private String individualNoteTreeParentPath;
	private String individualNoteTreeName;
	private String individualNoteTreeRegistrant;
	private String individualNoteTreeRegistrationDate;
	private String individualNoteTreeModifier;
	private String individualNoteTreeModifiedDate;
	
	private String newIndividualNoteTreeFullPath;
	private String newIndividualNoteTreeParentPath;
	private String newIndividualNoteTreeName;
}
