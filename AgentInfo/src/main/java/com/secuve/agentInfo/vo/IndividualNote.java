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
	private String individualNoteHashTag;
	private String individualNoteTreeName;				// 부서 이름
	private String individualNoteTreeFullPath;			// 부서 풀 경로
	private String individualNoteTreeParentPath;		// 부서 부모 경로
	private String individualNoteRegistrant;
	private String individualNoteRegistrationDate;
	private String individualNoteModifier;
	private String individualNoteModifiedDate;
	
	private String individualNoteTitleView;
	private String individualNoteContentsView;
	private String individualNoteHashTagView;
}
