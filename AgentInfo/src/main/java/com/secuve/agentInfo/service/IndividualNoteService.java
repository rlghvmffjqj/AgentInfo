package com.secuve.agentInfo.service;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

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

	public Map insertIndividualNote(IndividualNote individualNote, List<MultipartFile> fileInput) throws IllegalStateException, IOException {
		Map map = new HashMap();
		if(individualNote.getIndividualNoteTitleView() == null || individualNote.getIndividualNoteTitleView() == "") {
			map.put("result", "NotTitle");
			return map;
		} else if(individualNote.getIndividualNoteContentsView() == null || individualNote.getIndividualNoteContentsView() == "") {
			map.put("result", "NotContent");
			return map;
		}
		individualNote.setIndividualNoteTreeParentPath(individualNote.getIndividualNoteTreeFullPath().replace("/"+individualNote.getIndividualNoteTreeName(), ""));
		int individualNoteKeyNum = 0;
		int individualNoteSort = 0;
		try {
			individualNoteKeyNum =  individualNoteDao.individualNoteKeyNum();
			individualNoteSort =  individualNoteDao.individualNoteSort();
		} catch (Exception e) {
		}
		individualNote.setIndividualNoteKeyNum(++individualNoteKeyNum);
		individualNote.setIndividualNoteSort(++individualNoteSort);
		int sucess = individualNoteDao.insertIndividualNote(individualNote);
		if (sucess <= 0) {
			map.put("result", "FALSE");
			return map;
		}
		for(int num=0; num<individualNote.getIndividualNoteFileName().length; num++) {
			individualNote.setIndividualNoteRegistrationDate(nowDate());
			individualNoteDao.insertIndividualNoteFile(individualNote, individualNote.getIndividualNoteFileName()[num]);
			fileDownload(individualNote.getIndividualNoteKeyNum(),individualNote.getIndividualNoteFileName()[num], fileInput.get(num));
		}
		map.put("result", "OK");
		map.put("individualNoteKeyNum", individualNote.getIndividualNoteKeyNum());
		map.put("individualNoteModifiedDate", individualNote.getIndividualNoteRegistrationDate());
		return map;
	}
	
	/**
	 * 파일 저장 경로(application.properties)
	 */
	@Value("${spring.servlet.multipart.location}")
	String filePath;
	
	public void fileDownload(int getIndividualNoteKeyNum, String individualNoteFileName, MultipartFile fileInput) throws IllegalStateException, IOException {
		File newFileName = new File(filePath + File.separator + "individualNote",getIndividualNoteKeyNum+"_"+individualNoteFileName);
		fileInput.transferTo(newFileName);
	}
	
	public List<IndividualNote> getIndividualNoteSearch(String[] individualNoteTitle, String[] individualNoteHashTag, String individualNoteRegistrant, IndividualNote individualNote) {
		return individualNoteDao.getIndividualNoteSearch(individualNoteTitle, individualNoteHashTag, individualNoteRegistrant, individualNote);
	}

	public IndividualNote getIndividualNoteOne(String individualNoteKeyNum, String individualNoteRegistrant) {
		return individualNoteDao.getIndividualNoteOne(Integer.parseInt(individualNoteKeyNum), individualNoteRegistrant);
	}

	public String updateIndividualNote(IndividualNote individualNote, Principal principal, List<MultipartFile> fileInput) throws IllegalStateException, IOException {
		if(individualNote.getIndividualNoteTitleView() == null || individualNote.getIndividualNoteTitleView() == "") {
			return "NotTitle";
		} else if(individualNote.getIndividualNoteContentsView() == null || individualNote.getIndividualNoteContentsView() == "") {
			return "NotContent";
		}
		List<String> list = individualNoteDao.getIndividualNoteFileName(individualNote.getIndividualNoteKeyNum());
		for(String individualNoteFileName : individualNote.getIndividualNoteFileName()) {
			if(list.contains(individualNoteFileName) == true) {
				return "Existence";
			}
		}
		int sucess = individualNoteDao.updateIndividualNote(individualNote);
		if (sucess <= 0)
			return "FALSE";
		individualNote.setIndividualNoteRegistrant(principal.getName());
		
		for(int num=0; num<individualNote.getIndividualNoteFileName().length; num++) {
			individualNote.setIndividualNoteRegistrationDate(nowDate());
			individualNoteDao.insertIndividualNoteFile(individualNote, individualNote.getIndividualNoteFileName()[num]);
			fileDownload(individualNote.getIndividualNoteKeyNum(),individualNote.getIndividualNoteFileName()[num], fileInput.get(num));
		}
		return "OK";
	}

	public String delIndividualNote(String individualNoteKeyNumStr) {
		int individualNoteKeyNum = Integer.parseInt(individualNoteKeyNumStr);
		int sucess = individualNoteDao.delIndividualNote(individualNoteKeyNum);
		if (sucess <= 0)
			return "FALSE";
		List<String> individualNoteFileNames = individualNoteDao.getIndividualNoteFileName(individualNoteKeyNum);
		for (String individualNoteFileName : individualNoteFileNames) {
			fileDelete(individualNoteKeyNum, individualNoteFileName);
		}
		individualNoteDao.deleteIndividualNoteFileKeyNum(individualNoteKeyNum);
		return "OK";
	}

	public void delAllIndividualNote(String individualNoteRegistrant, String individualNoteTreeName, String individualNoteTreeFullPath) {
		individualNoteDao.delAllIndividualNote(individualNoteRegistrant, individualNoteTreeName, individualNoteTreeFullPath);
	}

	public String saveIndividualNote(List<Integer> individualNoteKeyNum) {
		IndividualNote individualNote = new IndividualNote();
		int sucess = 1;
		int individualNoteSort = 0;
		try {
			individualNoteSort =  individualNoteDao.individualNoteSort();
		} catch (Exception e) {
		}
		for(int i=0; i<individualNoteKeyNum.size(); i++) {
			sucess *= individualNoteDao.saveIndividualNote(individualNoteKeyNum.get(i), ++individualNoteSort);
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

	public List<String> getIndividualNoteFileName(int individualNoteKeyNum) {
		List<String> list = individualNoteDao.getIndividualNoteFileName(individualNoteKeyNum);
		if(list.size() == 0)
			list = null;
		return list;
	}
	
	public List<String> getIndividualNoteFileNameStr(String[] individualNoteFileName) {
		ArrayList<String> list = new ArrayList<String>();
		for (String fileName : individualNoteFileName) {
			list.add(fileName);
		}
		return list;
	}

	public void deleteIndividualNoteFile(int individualNoteKeyNum, String individualNoteFileName) {
		individualNoteDao.deleteIndividualNoteFile(individualNoteKeyNum, individualNoteFileName);
	}

	public String fileDelete(int individualNoteKeyNum, String individualNoteFileName) {
		//파일 경로 지정
		String path = "C:\\AgentInfo\\individualNote";
				
		//현재 게시판에 존재하는 파일객체를 만듬
		File file = new File(path + "\\" + individualNoteKeyNum+"_"+individualNoteFileName);
			
		if(file.exists()) { // 파일이 존재하면
			file.delete(); // 파일 삭제
			return "OK"; 
		}
		return "NotFile";
	}

}
