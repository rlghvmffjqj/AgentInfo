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

	public int individualNoteKeyNum() {
		return sqlSession.selectOne("individualNote.getIndividualNoteKeyNum");
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
		String individualNoteTreeParentPath, String individualNoteTreeName, String individualNoteTreeModifier, String individualNoteTreeModifiedDate) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("ordIndividualNoteTreeFullPath", ordIndividualNoteTreeFullPath);
		parameters.put("individualNoteTreeFullPath", individualNoteTreeFullPath);
		parameters.put("individualNoteTreeParentPath", individualNoteTreeParentPath);
		parameters.put("individualNoteTreeName", individualNoteTreeName);
		parameters.put("individualNoteTreeModifier", individualNoteTreeModifier);
		parameters.put("individualNoteTreeModifiedDate", individualNoteTreeModifiedDate);
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

}
