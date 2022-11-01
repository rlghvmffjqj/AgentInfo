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

	public List<IndividualNote> getIndividualNote() {
		return sqlSession.selectList("individualNote.getIndividualNote");
	}

	public int insertIndividualNote(IndividualNote individualNote) {
		return sqlSession.insert("individualNote.insertIndividualNote", individualNote);
	}

	public int individualNoteKeyNum() {
		return sqlSession.selectOne("individualNote.getIndividualNoteKeyNum");
	}

	public List<IndividualNote> getIndividualNoteSearch(String individualNoteTitle) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("individualNoteTitle", individualNoteTitle);
		return sqlSession.selectList("individualNote.getIndividualNoteSearch", parameters);
	}

}
