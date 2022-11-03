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

	public List<IndividualNote> getIndividualNoteSearch(String[] individualNoteTitle, String individualNoteRegistrant) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("individualNoteTitle", individualNoteTitle);
		parameters.put("individualNoteRegistrant", individualNoteRegistrant);
		parameters.put("count", individualNoteTitle.length);
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

	public void delAllIndividualNote(String individualNoteRegistrant) {
		sqlSession.delete("individualNote.delAllIndividualNote", individualNoteRegistrant);
	}

	public List<String> getIndividualNoteTitle(String individualNoteRegistrant) {
		return sqlSession.selectList("individualNote.getIndividualNoteTitle", individualNoteRegistrant);
	}

}
