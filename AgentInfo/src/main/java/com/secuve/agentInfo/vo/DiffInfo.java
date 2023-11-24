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
	
	public void setTag(int tagIndex, Tag tag) {
        switch (tagIndex) {
            case 1:
                this.tag1 = tag;
                break;
            case 2:
                this.tag2 = tag;
                break;
            case 3:
                this.tag3 = tag;
                break;
            default:
        }
    }
	
	public void setOldLine(int tagIndex, String oldLine) {
        switch (tagIndex) {
            case 1:
                this.oldLine1 = oldLine;
                break;
            case 2:
                this.oldLine2 = oldLine;
                break;
            case 3:
                this.oldLine3 = oldLine;
                break;
            default:
        }
    }

    public void setNewLine(int tagIndex, String newLine) {
        switch (tagIndex) {
            case 1:
                this.newLine1 = newLine;
                break;
            case 2:
                this.newLine2 = newLine;
                break;
            case 3:
                this.newLine3 = newLine;
                break;
            default:
        }
    }
    
}
