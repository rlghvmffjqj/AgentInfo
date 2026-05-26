package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.WorkManage;

@Repository
public class WorkManageDao {
	@Autowired SqlSessionTemplate sqlSession;
	
	private Map<String, Object> createParameterMap(Object... keyValues) {
        Map<String, Object> parameters = new HashMap<>();
        for (int i = 0; i < keyValues.length; i += 2) {
            parameters.put((String) keyValues[i], keyValues[i + 1]);
        }
        return parameters;
    }

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

	public int progressChange(int workManageKeyNum, String workManageCommentView, String workManageProgressView) {
		Map<String, Object> parameters = createParameterMap(
		    "workManageKeyNum", workManageKeyNum,
		    "workManageCommentView", workManageCommentView,
		    "workManageProgressView", workManageProgressView
		);
		return sqlSession.update("workManage.progressChange", parameters);
	}

}
