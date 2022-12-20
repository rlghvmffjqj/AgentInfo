package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.SharedNote;

@Repository
public class SharedNoteDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<SharedNote> getSharedNote(String sharedNoteDepartment) {
		return sqlSession.selectList("sharedNote.getSharedNote", sharedNoteDepartment);
	}

	public int insertSharedNote(SharedNote sharedNote) {
		return sqlSession.insert("sharedNote.insertSharedNote", sharedNote);
	}

	public List<SharedNote> getSharedNoteSearch(String[] sharedNoteTitle, String[] sharedNoteHashTag, String sharedNoteDepartment, SharedNote sharedNote) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("sharedNoteTitle", sharedNoteTitle);
		parameters.put("sharedNoteHashTag", sharedNoteHashTag);
		parameters.put("sharedNoteDepartment", sharedNoteDepartment);
		parameters.put("sharedNoteTitleCount", sharedNoteTitle.length);
		parameters.put("sharedNoteHashTagCount", sharedNoteHashTag.length);
		parameters.put("sharedNoteTreeFullPath", sharedNote.getSharedNoteTreeFullPath());
		parameters.put("sharedNoteTreeName", sharedNote.getSharedNoteTreeName());
		return sqlSession.selectList("sharedNote.getSharedNoteSearch", parameters);
	}

	public SharedNote getSharedNoteOne(int sharedNoteKeyNum, String sharedNoteRegistrant) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("sharedNoteKeyNum", sharedNoteKeyNum);
		parameters.put("sharedNoteRegistrant", sharedNoteRegistrant);
		return sqlSession.selectOne("sharedNote.getSharedNoteOne", parameters);
	}

	public int updateSharedNote(SharedNote sharedNote) {
		return sqlSession.update("sharedNote.updateSharedNote", sharedNote);
	}

	public int delSharedNote(int sharedNoteKeyNum) {
		return sqlSession.delete("sharedNote.delSharedNote", sharedNoteKeyNum);
	}

	public void delAllSharedNote(String sharedNoteRegistrant, String sharedNoteTreeName, String sharedNoteTreeFullPath) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("sharedNoteRegistrant", sharedNoteRegistrant);
		parameters.put("sharedNoteTreeName", sharedNoteTreeName);
		parameters.put("sharedNoteTreeFullPath", sharedNoteTreeFullPath);
		sqlSession.delete("sharedNote.delAllSharedNote", parameters);
	}

	public List<String> getSharedNoteTitle(String sharedNoteDepartment) {
		return sqlSession.selectList("sharedNote.getSharedNoteTitle", sharedNoteDepartment);
	}

	public List<String> getSharedNoteHashTag(String sharedNoteDepartment) {
		return sqlSession.selectList("sharedNote.getSharedNoteHashTag", sharedNoteDepartment);
	}

	public void updateTree(String ordSharedNoteTreeFullPath, String sharedNoteTreeFullPath,
		String sharedNoteTreeParentPath, String sharedNoteTreeName, String sharedNoteTreeModifier, String sharedNoteTreeModifiedDate, String sharedNoteTreeRegistrant) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("ordSharedNoteTreeFullPath", ordSharedNoteTreeFullPath);
		parameters.put("sharedNoteTreeFullPath", sharedNoteTreeFullPath);
		parameters.put("sharedNoteTreeParentPath", sharedNoteTreeParentPath);
		parameters.put("sharedNoteTreeName", sharedNoteTreeName);
		parameters.put("sharedNoteTreeModifier", sharedNoteTreeModifier);
		parameters.put("sharedNoteTreeModifiedDate", sharedNoteTreeModifiedDate);
		parameters.put("sharedNoteTreeRegistrant", sharedNoteTreeRegistrant);
		sqlSession.update("sharedNote.updateTree", parameters);	
	}

	public List<SharedNote> getSharedNoteSearchAll(String[] sharedNoteTitle, String[] sharedNoteHashTag, String sharedNoteDepartment) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("sharedNoteTitle", sharedNoteTitle);
		parameters.put("sharedNoteHashTag", sharedNoteHashTag);
		parameters.put("sharedNoteDepartment", sharedNoteDepartment);
		parameters.put("sharedNoteTitleCount", sharedNoteTitle.length);
		parameters.put("sharedNoteHashTagCount", sharedNoteHashTag.length);
		return sqlSession.selectList("sharedNote.getSharedNoteSearchAll",parameters);
	}

	public int sharedNoteSort() {
		return sqlSession.selectOne("sharedNote.getSharedNoteSort");
	}

	public int saveSharedNote(int sharedNoteKeyNum, int sharedNoteSort) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("sharedNoteKeyNum", sharedNoteKeyNum);
		parameters.put("sharedNoteSort", sharedNoteSort);
		return sqlSession.update("sharedNote.saveSharedNote",parameters);
	}

	public void insertSharedNoteFile(SharedNote sharedNote, String sharedNoteFileName) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("sharedNoteKeyNum", sharedNote.getSharedNoteKeyNum());
		parameters.put("sharedNoteFileRegistrant", sharedNote.getSharedNoteRegistrant());
		parameters.put("sharedNoteFileRegistrationDate", sharedNote.getSharedNoteRegistrationDate());
		parameters.put("sharedNoteFileName", sharedNoteFileName);
		sqlSession.insert("sharedNote.insertSharedNoteFile",parameters);
	}

	public List<String> getSharedNoteFileName(int sharedNoteKeyNum) {
		return sqlSession.selectList("sharedNote.getSharedNoteFileName",sharedNoteKeyNum);
	}

	public void deleteSharedNoteFile(int sharedNoteKeyNum, String sharedNoteFileName) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("sharedNoteKeyNum", sharedNoteKeyNum);
		parameters.put("sharedNoteFileName", sharedNoteFileName);
		sqlSession.delete("sharedNote.deleteSharedNoteFile",parameters);
	}

	public void deleteSharedNoteFileKeyNum(int sharedNoteKeyNum) {
		sqlSession.delete("sharedNote.deleteSharedNoteFileKeyNum",sharedNoteKeyNum);
	}

}
