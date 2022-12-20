package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.IndividualNote;

@Repository
public class IndividualNoteDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<IndividualNote> getIndividualNote(String individualNoteRegistrant) {
		return sqlSession.selectList("individualNote.getIndividualNote", individualNoteRegistrant);
	}

	public int insertIndividualNote(IndividualNote individualNote) {
		return sqlSession.insert("individualNote.insertIndividualNote", individualNote);
	}

	public List<IndividualNote> getIndividualNoteSearch(String[] individualNoteTitle, String[] individualNoteHashTag, String individualNoteRegistrant, IndividualNote individualNote) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("individualNoteTitle", individualNoteTitle);
		parameters.put("individualNoteHashTag", individualNoteHashTag);
		parameters.put("individualNoteRegistrant", individualNoteRegistrant);
		parameters.put("individualNoteTitleCount", individualNoteTitle.length);
		parameters.put("individualNoteHashTagCount", individualNoteHashTag.length);
		parameters.put("individualNoteTreeFullPath", individualNote.getIndividualNoteTreeFullPath());
		parameters.put("individualNoteTreeName", individualNote.getIndividualNoteTreeName());
		return sqlSession.selectList("individualNote.getIndividualNoteSearch", parameters);
	}

	public IndividualNote getIndividualNoteOne(int individualNoteKeyNum, String individualNoteRegistrant) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("individualNoteKeyNum", individualNoteKeyNum);
		parameters.put("individualNoteRegistrant", individualNoteRegistrant);
		return sqlSession.selectOne("individualNote.getIndividualNoteOne", parameters);
	}

	public int updateIndividualNote(IndividualNote individualNote) {
		return sqlSession.update("individualNote.updateIndividualNote", individualNote);
	}

	public int delIndividualNote(int individualNoteKeyNum) {
		return sqlSession.delete("individualNote.delIndividualNote", individualNoteKeyNum);
	}

	public void delAllIndividualNote(String individualNoteRegistrant, String individualNoteTreeName, String individualNoteTreeFullPath) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("individualNoteRegistrant", individualNoteRegistrant);
		parameters.put("individualNoteTreeName", individualNoteTreeName);
		parameters.put("individualNoteTreeFullPath", individualNoteTreeFullPath);
		sqlSession.delete("individualNote.delAllIndividualNote", parameters);
	}

	public List<String> getIndividualNoteTitle(String individualNoteRegistrant) {
		return sqlSession.selectList("individualNote.getIndividualNoteTitle", individualNoteRegistrant);
	}

	public List<String> getIndividualNoteHashTag(String individualNoteRegistrant) {
		return sqlSession.selectList("individualNote.getIndividualNoteHashTag", individualNoteRegistrant);
	}

	public void updateTree(String ordIndividualNoteTreeFullPath, String individualNoteTreeFullPath,
		String individualNoteTreeParentPath, String individualNoteTreeName, String individualNoteTreeModifier, String individualNoteTreeModifiedDate, String individualNoteTreeRegistrant) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("ordIndividualNoteTreeFullPath", ordIndividualNoteTreeFullPath);
		parameters.put("individualNoteTreeFullPath", individualNoteTreeFullPath);
		parameters.put("individualNoteTreeParentPath", individualNoteTreeParentPath);
		parameters.put("individualNoteTreeName", individualNoteTreeName);
		parameters.put("individualNoteTreeModifier", individualNoteTreeModifier);
		parameters.put("individualNoteTreeModifiedDate", individualNoteTreeModifiedDate);
		parameters.put("individualNoteTreeRegistrant", individualNoteTreeRegistrant);
		sqlSession.update("individualNote.updateTree", parameters);	
	}

	public List<IndividualNote> getIndividualNoteSearchAll(String[] individualNoteTitle, String[] individualNoteHashTag, String individualNoteRegistrant) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("individualNoteTitle", individualNoteTitle);
		parameters.put("individualNoteHashTag", individualNoteHashTag);
		parameters.put("individualNoteRegistrant", individualNoteRegistrant);
		parameters.put("individualNoteTitleCount", individualNoteTitle.length);
		parameters.put("individualNoteHashTagCount", individualNoteHashTag.length);
		return sqlSession.selectList("individualNote.getIndividualNoteSearchAll",parameters);
	}

	public int individualNoteSort() {
		return sqlSession.selectOne("individualNote.getIndividualNoteSort");
	}

	public int saveIndividualNote(int individualNoteKeyNum, int individualNoteSort) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("individualNoteKeyNum", individualNoteKeyNum);
		parameters.put("individualNoteSort", individualNoteSort);
		return sqlSession.update("individualNote.saveIndividualNote",parameters);
	}

	public void insertIndividualNoteFile(IndividualNote individualNote, String individualNoteFileName) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("individualNoteKeyNum", individualNote.getIndividualNoteKeyNum());
		parameters.put("individualNoteFileRegistrant", individualNote.getIndividualNoteRegistrant());
		parameters.put("individualNoteFileRegistrationDate", individualNote.getIndividualNoteRegistrationDate());
		parameters.put("individualNoteFileName", individualNoteFileName);
		sqlSession.insert("individualNote.insertIndividualNoteFile",parameters);
	}

	public List<String> getIndividualNoteFileName(int individualNoteKeyNum) {
		return sqlSession.selectList("individualNote.getIndividualNoteFileName",individualNoteKeyNum);
	}

	public void deleteIndividualNoteFile(int individualNoteKeyNum, String individualNoteFileName) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("individualNoteKeyNum", individualNoteKeyNum);
		parameters.put("individualNoteFileName", individualNoteFileName);
		sqlSession.delete("individualNote.deleteIndividualNoteFile",parameters);
	}

	public void deleteIndividualNoteFileKeyNum(int individualNoteKeyNum) {
		sqlSession.delete("individualNote.deleteIndividualNoteFileKeyNum",individualNoteKeyNum);
	}

}
