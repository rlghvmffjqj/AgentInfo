package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.IndividualNoteDao;
import com.secuve.agentInfo.vo.IndividualNote;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class IndividualNoteService {
	@Autowired IndividualNoteDao individualNoteDao;

	public List<IndividualNote> getIndividualNote(String individualNoteRegistrant) {
		return individualNoteDao.getIndividualNote(individualNoteRegistrant);
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String insertIndividualNote(IndividualNote individualNote) {
		if(individualNote.getIndividualNoteTitleView() == null || individualNote.getIndividualNoteTitleView() == "") {
			return "NotTitle";
		} else if(individualNote.getIndividualNoteContentsView() == null || individualNote.getIndividualNoteContentsView() == "") {
			return "NotContent";
		}
		individualNote.setIndividualNoteTreeParentPath(individualNote.getIndividualNoteTreeFullPath().replace("/"+individualNote.getIndividualNoteTreeName(), ""));
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
	
	public List<IndividualNote> getIndividualNoteSearch(String[] individualNoteTitle, String[] individualNoteHashTag, String individualNoteRegistrant, IndividualNote individualNote) {
		return individualNoteDao.getIndividualNoteSearch(individualNoteTitle, individualNoteHashTag, individualNoteRegistrant, individualNote);
	}

	public IndividualNote getIndividualNoteOne(String individualNoteKeyNum, String individualNoteRegistrant) {
		return individualNoteDao.getIndividualNoteOne(Integer.parseInt(individualNoteKeyNum), individualNoteRegistrant);
	}

	public String updateIndividualNote(IndividualNote individualNote, Principal principal) {
		if(individualNote.getIndividualNoteTitleView() == null || individualNote.getIndividualNoteTitleView() == "") {
			return "NotTitle";
		} else if(individualNote.getIndividualNoteContentsView() == null || individualNote.getIndividualNoteContentsView() == "") {
			return "NotContent";
		}
		int sucess = individualNoteDao.updateIndividualNote(individualNote);
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public String delIndividualNote(String individualNoteKeyNum) {
		int sucess = individualNoteDao.delIndividualNote(Integer.parseInt(individualNoteKeyNum));
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public void delAllIndividualNote(String individualNoteRegistrant, String individualNoteTreeName, String individualNoteTreeFullPath) {
		individualNoteDao.delAllIndividualNote(individualNoteRegistrant, individualNoteTreeName, individualNoteTreeFullPath);
	}

	public String saveIndividualNote(List<String> individualNoteTitle, List<String> individualNoteContents, List<String> individualNoteHashTag, String individualNoteRegistrant, String individualNoteTreeName, String individualNoteTreeFullPath) {
		IndividualNote individualNote = new IndividualNote();
		individualNote.setIndividualNoteRegistrant(individualNoteRegistrant);
		individualNote.setIndividualNoteRegistrationDate(nowDate());
		individualNote.setIndividualNoteModifier(individualNoteRegistrant);
		individualNote.setIndividualNoteModifiedDate(nowDate());
		int sucess = 1;
		int individualNoteKeyNum = 0;
		try {
			individualNoteKeyNum =  individualNoteDao.individualNoteKeyNum();
		} catch (Exception e) {
		}
		for(int i=0; i<individualNoteTitle.size(); i++) {
			individualNote.setIndividualNoteKeyNum(++individualNoteKeyNum);
			individualNote.setIndividualNoteTitleView(individualNoteTitle.get(i));
			individualNote.setIndividualNoteContentsView(individualNoteContents.get(i));
			individualNote.setIndividualNoteHashTagView(individualNoteHashTag.get(i));
			individualNote.setIndividualNoteTreeName(individualNoteTreeName);
			individualNote.setIndividualNoteTreeFullPath(individualNoteTreeFullPath);
			individualNote.setIndividualNoteTreeParentPath(individualNoteTreeFullPath.replace("/"+individualNoteTreeName, ""));
			sucess *= individualNoteDao.insertIndividualNote(individualNote);
		}
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public List<String> getIndividualNoteTitle(String individualNoteRegistrant) {
		return individualNoteDao.getIndividualNoteTitle(individualNoteRegistrant);
	}

	public List<String> getIndividualNoteHashTag(String individualNoteRegistrant) {
		List<String> individualNoteHashTag = new ArrayList<String>();
		String[] str;
		List<String> list = new ArrayList<String>();
		individualNoteHashTag = individualNoteDao.getIndividualNoteHashTag(individualNoteRegistrant);
		for(int i=0; i<individualNoteHashTag.size(); i++) {
			str = individualNoteHashTag.get(i).split(" ");
			for(int j=0; j<str.length; j++) {
				if(!list.contains(str[j]))
					list.add(str[j]);
			}
		}
		return list;
	}

	public List<IndividualNote>  getIndividualNoteSearchAll(String[] individualNoteTitle, String[] individualNoteHashTag, String individualNoteRegistrant) {
		return individualNoteDao.getIndividualNoteSearchAll(individualNoteTitle, individualNoteHashTag, individualNoteRegistrant);
	}
	
}
