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
		// TODO Auto-generated method stub
		return 0;
	}

}
