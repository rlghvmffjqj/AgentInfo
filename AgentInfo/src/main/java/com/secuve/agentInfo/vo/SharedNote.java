package com.secuve.agentInfo.vo;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class SharedNote {
	private int sharedNoteKeyNum;
	private String sharedNoteTitle;
	private String sharedNoteContents;
	private String sharedNoteHashTag;
	private int sharedNoteSort;
	private String sharedNoteColor;
	private String sharedNoteTreeName;				// 부서 이름
	private String sharedNoteTreeFullPath;			// 부서 풀 경로
	private String sharedNoteTreeParentPath;		// 부서 부모 경로
	private String sharedNoteDepartment;
	private String sharedNoteRegistrant;
	private String sharedNoteRegistrationDate;
	private String sharedNoteModifier;
	private String sharedNoteModifiedDate;
	
	private String sharedNoteTitleView;
	private String sharedNoteContentsView;
	private String sharedNoteHashTagView;
	
	private String[] sharedNoteFileName;
	

}
