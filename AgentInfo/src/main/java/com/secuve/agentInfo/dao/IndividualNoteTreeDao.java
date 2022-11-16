package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.IndividualNoteTree;

@Repository
public class IndividualNoteTreeDao {
	@Autowired SqlSessionTemplate sqlSession;
	
	public List<IndividualNoteTree> getIndividualNoteTreeList(String parentPath, String individualNoteTreeRegistrant) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("parentPath", parentPath);
		parameters.put("individualNoteTreeRegistrant", individualNoteTreeRegistrant);
		return sqlSession.selectList("individualNoteTree.getIndividualNoteTreeList", parameters);
	}

	public int insertIndividualNoteTree(IndividualNoteTree individualNoteTree) {
		return sqlSession.insert("individualNoteTree.insertIndividualNoteTree", individualNoteTree);
	}

	public IndividualNoteTree getIndividualNoteTreeFullPath(String individualNoteTreeFullPath, String individualNoteTreeRegistrant) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("individualNoteTreeFullPath", individualNoteTreeFullPath);
		parameters.put("individualNoteTreeRegistrant", individualNoteTreeRegistrant);
		return sqlSession.selectOne("individualNoteTree.getIndividualNoteTreeFullPath",parameters);
	}

	public List<IndividualNoteTree> getIndividualNoteTreeParentPath(IndividualNoteTree individualNoteTree) {
		return sqlSession.selectList("individualNoteTree.getIndividualNoteTreeParentPath",individualNoteTree);
	}

	public int deleteIndividualNoteTree(IndividualNoteTree individualNoteTree) {
		return sqlSession.delete("individualNoteTree.deleteIndividualNoteTree",individualNoteTree);
	}

	public List<IndividualNoteTree> getIndividualNoteTreeFullPathList(String individualNoteTreeFullPath) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("individualNoteTreeFullPath", individualNoteTreeFullPath);
		parameters.put("individualNoteTreeParentPath", individualNoteTreeFullPath + "/%");
		return sqlSession.selectList("individualNoteTree.getIndividualNoteTreeFullPathList", parameters);
	}

	public int updateTree(String ordIndividualNoteTreeFullPath, String individualNoteTreeFullPath, String individualNoteTreeParentPath, String individualNoteTreeName, String individualNoteTreeModifier, String individualNoteTreeModifiedDate, String individualNoteTreeRegistrant) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("ordIndividualNoteTreeFullPath", ordIndividualNoteTreeFullPath);
		parameters.put("individualNoteTreeFullPath", individualNoteTreeFullPath);
		parameters.put("individualNoteTreeParentPath", individualNoteTreeParentPath);
		parameters.put("individualNoteTreeName", individualNoteTreeName);
		parameters.put("individualNoteTreeModifier", individualNoteTreeModifier);
		parameters.put("individualNoteTreeModifiedDate", individualNoteTreeModifiedDate);
		parameters.put("individualNoteTreeRegistrant", individualNoteTreeRegistrant);
		return sqlSession.insert("individualNoteTree.updateTree", parameters);
	}
}
