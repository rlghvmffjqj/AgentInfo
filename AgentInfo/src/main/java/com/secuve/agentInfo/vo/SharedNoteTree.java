package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class SharedNoteTree {
	private String sharedNoteTreeFullPath;
	private String sharedNoteTreeParentPath;
	private String sharedNoteTreeName;
	private String sharedNoteTreeRegistrant;
	private String sharedNoteTreeRegistrationDate;
	private String sharedNoteTreeModifier;
	private String sharedNoteTreeModifiedDate;
	
	private String newSharedNoteTreeFullPath;
	private String newSharedNoteTreeParentPath;
	private String newSharedNoteTreeName;
}
