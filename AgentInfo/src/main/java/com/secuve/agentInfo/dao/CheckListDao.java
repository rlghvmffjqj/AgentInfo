package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.CheckList;

@Repository
public class CheckListDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<CheckList> getCheckList(CheckList search) {
		return sqlSession.selectList("checkList.getCheckList", search);
	}

	public int getCheckListCount(CheckList search) {
		return sqlSession.selectOne("checkList.getCheckListCount", search);
	}
}
