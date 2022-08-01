package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.ScheduleJob;

@Repository
public class ScheduleJobDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<ScheduleJob> getScheduleJobList(ScheduleJob search) {
		return sqlSession.selectList("scheduleJob.getScheduleJob", search);
	}

	public ScheduleJob getScheduleOne(String scheduleName) {
		return sqlSession.selectOne("scheduleJob.getScheduleOne", scheduleName);
	}

	public int getScheduleJobListCount() {
		return sqlSession.selectOne("scheduleJob.getScheduleJobCount");
	}

	public void setScheduleStateUse(String scheduleName) {
		sqlSession.update("scheduleJob.setScheduleStateUse", scheduleName);
		
	}

	public ScheduleJob getScheduleOneKeyNum(int scheduleKeyNum) {
		return sqlSession.selectOne("scheduleJob.getScheduleOneKeyNum", scheduleKeyNum);
	}

	public void setScheduleStateNotUse(String scheduleName) {
		sqlSession.update("scheduleJob.setScheduleStateNotUse", scheduleName);
	}

	public void updateScheduleJob(String scheduleName, String scheduleState, String scheduleCron) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("scheduleName", scheduleName);
		parameters.put("scheduleState", scheduleState);
		parameters.put("scheduleCron", scheduleCron);
		sqlSession.update("scheduleJob.updateScheduleJob", parameters);
		
	}

}
