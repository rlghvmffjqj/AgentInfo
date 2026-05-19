package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.WorkManage;

@Repository
public class WorkManageDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<WorkManage> getWorkManageList(WorkManage search) {
		return sqlSession.selectList("workManage.getWorkManageList", search);
	}

	public int getWorkManageListCount(WorkManage search) {
		return sqlSession.selectOne("workManage.getWorkManageListCount", search);
	}

	public int insertWorkManage(WorkManage workManage) {
		return sqlSession.insert("workManage.insertWorkManage", workManage);
	}

	public WorkManage getWorkManageOne(int workManageKeyNum) {
		return sqlSession.selectOne("workManage.getWorkManageOne", workManageKeyNum);
	}

	public int updateWorkManage(WorkManage workManage) {
		return sqlSession.update("workManage.updateWorkManage", workManage);
	}

	public int delWorkManage(int workManageKeyNum) {
		return sqlSession.update("workManage.delWorkManage", workManageKeyNum);
	}

}
