package com.secuve.agentInfo.vo;

import java.io.Serializable;

import org.springframework.stereotype.Component;

import com.github.difflib.text.DiffRow.Tag;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class DiffInfo implements Serializable{
	private Tag tag1;
	private Tag tag2;
	private Tag tag3;
	private String oldLine1;
	private String oldLine2;
	private String oldLine3;
	private String newLine1;
	private String newLine2;
	private String newLine3;
    
}
