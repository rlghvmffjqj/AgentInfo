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

import com.secuve.agentInfo.dao.SharedNoteDao;
import com.secuve.agentInfo.vo.SharedNote;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class SharedNoteService {
	@Autowired SharedNoteDao sharedNoteDao;

	public List<SharedNote> getSharedNote(String sharedNoteRegistrant) {
		return sharedNoteDao.getSharedNote(sharedNoteRegistrant);
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public Map insertSharedNote(SharedNote sharedNote, List<MultipartFile> fileInput) throws IllegalStateException, IOException {
		Map map = new HashMap();
		if(sharedNote.getSharedNoteTitleView() == null || sharedNote.getSharedNoteTitleView() == "") {
			map.put("result", "NotTitle");
			return map;
		} else if(sharedNote.getSharedNoteContentsView() == null || sharedNote.getSharedNoteContentsView() == "") {
			map.put("result", "NotContent");
			return map;
		}
		sharedNote.setSharedNoteTreeParentPath(sharedNote.getSharedNoteTreeFullPath().replace("/"+sharedNote.getSharedNoteTreeName(), ""));
		int sharedNoteKeyNum = 0;
		int sharedNoteSort = 0;
		try {
			sharedNoteKeyNum =  sharedNoteDao.sharedNoteKeyNum();
			sharedNoteSort =  sharedNoteDao.sharedNoteSort();
		} catch (Exception e) {
		}
		sharedNote.setSharedNoteKeyNum(++sharedNoteKeyNum);
		sharedNote.setSharedNoteSort(++sharedNoteSort);
		int sucess = sharedNoteDao.insertSharedNote(sharedNote);
		if (sucess <= 0) {
			map.put("result", "FALSE");
			return map;
		}
		for(int num=0; num<sharedNote.getSharedNoteFileName().length; num++) {
			sharedNote.setSharedNoteRegistrationDate(nowDate());
			sharedNoteDao.insertSharedNoteFile(sharedNote, sharedNote.getSharedNoteFileName()[num]);
			fileDownload(sharedNote.getSharedNoteKeyNum(),sharedNote.getSharedNoteFileName()[num], fileInput.get(num));
		}
		map.put("result", "OK");
		map.put("sharedNoteKeyNum", sharedNote.getSharedNoteKeyNum());
		map.put("sharedNoteModifiedDate", sharedNote.getSharedNoteRegistrationDate());
		return map;
	}
	
	/**
	 * 파일 저장 경로(application.properties)
	 */
	@Value("${spring.servlet.multipart.location}")
	String filePath;
	
	public void fileDownload(int getSharedNoteKeyNum, String sharedNoteFileName, MultipartFile fileInput) throws IllegalStateException, IOException {
		File newFileName = new File(filePath + File.separator + "sharedNote",getSharedNoteKeyNum+"_"+sharedNoteFileName);
		fileInput.transferTo(newFileName);
	}
	
	public List<SharedNote> getSharedNoteSearch(String[] sharedNoteTitle, String[] sharedNoteHashTag, String sharedNoteRegistrant, SharedNote sharedNote) {
		return sharedNoteDao.getSharedNoteSearch(sharedNoteTitle, sharedNoteHashTag, sharedNoteRegistrant, sharedNote);
	}

	public SharedNote getSharedNoteOne(String sharedNoteKeyNum, String sharedNoteRegistrant) {
		return sharedNoteDao.getSharedNoteOne(Integer.parseInt(sharedNoteKeyNum), sharedNoteRegistrant);
	}

	public String updateSharedNote(SharedNote sharedNote, Principal principal, List<MultipartFile> fileInput) throws IllegalStateException, IOException {
		if(sharedNote.getSharedNoteTitleView() == null || sharedNote.getSharedNoteTitleView() == "") {
			return "NotTitle";
		} else if(sharedNote.getSharedNoteContentsView() == null || sharedNote.getSharedNoteContentsView() == "") {
			return "NotContent";
		}
		List<String> list = sharedNoteDao.getSharedNoteFileName(sharedNote.getSharedNoteKeyNum());
		for(String sharedNoteFileName : sharedNote.getSharedNoteFileName()) {
			if(list.contains(sharedNoteFileName) == true) {
				return "Existence";
			}
		}
		int sucess = sharedNoteDao.updateSharedNote(sharedNote);
		if (sucess <= 0)
			return "FALSE";
		sharedNote.setSharedNoteRegistrant(principal.getName());
		
		for(int num=0; num<sharedNote.getSharedNoteFileName().length; num++) {
			sharedNote.setSharedNoteRegistrationDate(nowDate());
			sharedNoteDao.insertSharedNoteFile(sharedNote, sharedNote.getSharedNoteFileName()[num]);
			fileDownload(sharedNote.getSharedNoteKeyNum(),sharedNote.getSharedNoteFileName()[num], fileInput.get(num));
		}
		return "OK";
	}

	public String delSharedNote(String sharedNoteKeyNumStr) {
		int sharedNoteKeyNum = Integer.parseInt(sharedNoteKeyNumStr);
		int sucess = sharedNoteDao.delSharedNote(sharedNoteKeyNum);
		if (sucess <= 0)
			return "FALSE";
		List<String> sharedNoteFileNames = sharedNoteDao.getSharedNoteFileName(sharedNoteKeyNum);
		for (String sharedNoteFileName : sharedNoteFileNames) {
			fileDelete(sharedNoteKeyNum, sharedNoteFileName);
		}
		sharedNoteDao.deleteSharedNoteFileKeyNum(sharedNoteKeyNum);
		return "OK";
	}

	public void delAllSharedNote(String sharedNoteRegistrant, String sharedNoteTreeName, String sharedNoteTreeFullPath) {
		sharedNoteDao.delAllSharedNote(sharedNoteRegistrant, sharedNoteTreeName, sharedNoteTreeFullPath);
	}

	public String saveSharedNote(List<Integer> sharedNoteKeyNum) {
		SharedNote sharedNote = new SharedNote();
		int sucess = 1;
		int sharedNoteSort = 0;
		try {
			sharedNoteSort =  sharedNoteDao.sharedNoteSort();
		} catch (Exception e) {
		}
		for(int i=0; i<sharedNoteKeyNum.size(); i++) {
			sucess *= sharedNoteDao.saveSharedNote(sharedNoteKeyNum.get(i), ++sharedNoteSort);
		}
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public List<String> getSharedNoteTitle(String sharedNoteRegistrant) {
		return sharedNoteDao.getSharedNoteTitle(sharedNoteRegistrant);
	}

	public List<String> getSharedNoteHashTag(String sharedNoteRegistrant) {
		List<String> sharedNoteHashTag = new ArrayList<String>();
		String[] str;
		List<String> list = new ArrayList<String>();
		sharedNoteHashTag = sharedNoteDao.getSharedNoteHashTag(sharedNoteRegistrant);
		for(int i=0; i<sharedNoteHashTag.size(); i++) {
			str = sharedNoteHashTag.get(i).split(" ");
			for(int j=0; j<str.length; j++) {
				if(!list.contains(str[j]))
					list.add(str[j]);
			}
		}
		return list;
	}

	public List<SharedNote>  getSharedNoteSearchAll(String[] sharedNoteTitle, String[] sharedNoteHashTag, String sharedNoteRegistrant) {
		return sharedNoteDao.getSharedNoteSearchAll(sharedNoteTitle, sharedNoteHashTag, sharedNoteRegistrant);
	}

	public List<String> getSharedNoteFileName(int sharedNoteKeyNum) {
		List<String> list = sharedNoteDao.getSharedNoteFileName(sharedNoteKeyNum);
		if(list.size() == 0)
			list = null;
		return list;
	}
	
	public List<String> getSharedNoteFileNameStr(String[] sharedNoteFileName) {
		ArrayList<String> list = new ArrayList<String>();
		for (String fileName : sharedNoteFileName) {
			list.add(fileName);
		}
		return list;
	}

	public void deleteSharedNoteFile(int sharedNoteKeyNum, String sharedNoteFileName) {
		sharedNoteDao.deleteSharedNoteFile(sharedNoteKeyNum, sharedNoteFileName);
	}

	public String fileDelete(int sharedNoteKeyNum, String sharedNoteFileName) {
		//파일 경로 지정
		String path = "C:\\AgentInfo\\sharedNote";
				
		//현재 게시판에 존재하는 파일객체를 만듬
		File file = new File(path + "\\" + sharedNoteKeyNum+"_"+sharedNoteFileName);
			
		if(file.exists()) { // 파일이 존재하면
			file.delete(); // 파일 삭제
			return "OK"; 
		}
		return "NotFile";
	}

}
