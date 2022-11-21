package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.SharedNoteTree;

@Repository
public class SharedNoteTreeDao {
	@Autowired SqlSessionTemplate sqlSession;
	
	public List<SharedNoteTree> getSharedNoteTreeList(String parentPath, String sharedNoteTreeRegistrant) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("parentPath", parentPath);
		parameters.put("sharedNoteTreeRegistrant", sharedNoteTreeRegistrant);
		return sqlSession.selectList("sharedNoteTree.getSharedNoteTreeList", parameters);
	}

	public int insertSharedNoteTree(SharedNoteTree sharedNoteTree) {
		return sqlSession.insert("sharedNoteTree.insertSharedNoteTree", sharedNoteTree);
	}

	public SharedNoteTree getSharedNoteTreeFullPath(String sharedNoteTreeFullPath, String sharedNoteTreeRegistrant) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("sharedNoteTreeFullPath", sharedNoteTreeFullPath);
		parameters.put("sharedNoteTreeRegistrant", sharedNoteTreeRegistrant);
		return sqlSession.selectOne("sharedNoteTree.getSharedNoteTreeFullPath",parameters);
	}

	public List<SharedNoteTree> getSharedNoteTreeParentPath(SharedNoteTree sharedNoteTree) {
		return sqlSession.selectList("sharedNoteTree.getSharedNoteTreeParentPath",sharedNoteTree);
	}

	public int deleteSharedNoteTree(SharedNoteTree sharedNoteTree) {
		return sqlSession.delete("sharedNoteTree.deleteSharedNoteTree",sharedNoteTree);
	}

	public List<SharedNoteTree> getSharedNoteTreeFullPathList(String sharedNoteTreeFullPath) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("sharedNoteTreeFullPath", sharedNoteTreeFullPath);
		parameters.put("sharedNoteTreeParentPath", sharedNoteTreeFullPath + "/%");
		return sqlSession.selectList("sharedNoteTree.getSharedNoteTreeFullPathList", parameters);
	}

	public int updateTree(String ordSharedNoteTreeFullPath, String sharedNoteTreeFullPath, String sharedNoteTreeParentPath, String sharedNoteTreeName, String sharedNoteTreeModifier, String sharedNoteTreeModifiedDate, String sharedNoteTreeRegistrant) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("ordSharedNoteTreeFullPath", ordSharedNoteTreeFullPath);
		parameters.put("sharedNoteTreeFullPath", sharedNoteTreeFullPath);
		parameters.put("sharedNoteTreeParentPath", sharedNoteTreeParentPath);
		parameters.put("sharedNoteTreeName", sharedNoteTreeName);
		parameters.put("sharedNoteTreeModifier", sharedNoteTreeModifier);
		parameters.put("sharedNoteTreeModifiedDate", sharedNoteTreeModifiedDate);
		parameters.put("sharedNoteTreeRegistrant", sharedNoteTreeRegistrant);
		return sqlSession.insert("sharedNoteTree.updateTree", parameters);
	}
}
