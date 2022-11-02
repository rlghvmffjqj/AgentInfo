package com.secuve.agentInfo.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.IndividualNoteDao;
import com.secuve.agentInfo.vo.IndividualNote;

@Service
public class IndividualNoteService {
	@Autowired IndividualNoteDao individualNoteDao;

	public List<IndividualNote> getIndividualNote() {
		return individualNoteDao.getIndividualNote();
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String insertIndividualNote(IndividualNote individualNote) {
		int individualNoteKeyNum = 0;
		try {
			individualNoteKeyNum =  individualNoteDao.individualNoteKeyNum();
		} catch (Exception e) {
		}
		individualNote.setIndividualNoteKeyNum(++individualNoteKeyNum);
		int sucess = individualNoteDao.insertIndividualNote(individualNote);
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}
	
	public List<IndividualNote> getIndividualNoteSearch(String individualNoteTitle) {
		return individualNoteDao.getIndividualNoteSearch(individualNoteTitle);
	}

	public IndividualNote getIndividualNoteOne(String individualNoteKeyNum) {
		return individualNoteDao.getIndividualNoteOne(Integer.parseInt(individualNoteKeyNum));
	}
	
}
