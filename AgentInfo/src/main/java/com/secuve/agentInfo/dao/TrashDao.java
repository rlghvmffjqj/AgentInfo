package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.Trash;

@Repository
public class TrashDao {

	@Autowired SqlSessionTemplate sqlSession;
	
	public List<Trash> getTrashList(Trash search) {
		return sqlSession.selectList("trash.getTrashList", search);
	}

	public int getTrashListCount() {
		return sqlSession.selectOne("trash.getTrashListCount");
	}

	public int trashKeyNum() {
		return sqlSession.selectOne("trash.trashKeyNum");
	}

	public void insertTrash(Trash trash) {
		sqlSession.insert("trash.insertTrash", trash);		
	}
}