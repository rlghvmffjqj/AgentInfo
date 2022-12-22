package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.Calendar;
import com.secuve.agentInfo.vo.ServerCalendar;

@Repository
public class ServerCalendarDao {
	@Autowired SqlSessionTemplate sqlSession;
	
	public List<ServerCalendar> getServerCalendarList(String serverCalendarListDepartment) {
		return sqlSession.selectList("serverCalendar.getServerCalendarList", serverCalendarListDepartment);
	}

	public int InsertServerCalendarList(String serverCalendarListContents, String serverCalendarListColor, String serverCalendarListDepartment, String serverCalendarListRegistrant, String serverCalendarListRegistrationDate) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("serverCalendarListContents", serverCalendarListContents);
		parameters.put("serverCalendarListColor", serverCalendarListColor);
		parameters.put("serverCalendarListDepartment", serverCalendarListDepartment);
		parameters.put("serverCalendarListRegistrant", serverCalendarListRegistrant);
		parameters.put("serverCalendarListRegistrationDate", serverCalendarListRegistrationDate);
		return sqlSession.insert("serverCalendar.insertServerCalendarList", parameters);
	}

	public int overlapServerCalendarList(String serverCalendarListContents, String serverCalendarListDepartment) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("serverCalendarListContents", serverCalendarListContents);
		parameters.put("serverCalendarListDepartment", serverCalendarListDepartment);
		return sqlSession.selectOne("serverCalendar.overlapServerCalendarList", parameters);
	}

	public int InsertServerCalendar(ServerCalendar serverCalendar) {
		return sqlSession.insert("serverCalendar.insertServerCalendar", serverCalendar);
	}

	public List<ServerCalendar> getServerCalendar(String serverCalendarDepartment) {
		return sqlSession.selectList("serverCalendar.getServerCalendar", serverCalendarDepartment);
	}

	public int updateServerCalendar(ServerCalendar serverCalendar) {
		return sqlSession.update("serverCalendar.updateServerCalendar",serverCalendar);
	}

	public int deleteServerCalendar(int serverCalendarKeyNum, String serverCalendarDepartment) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("serverCalendarKeyNum", serverCalendarKeyNum);
		parameters.put("serverCalendarDepartment", serverCalendarDepartment);
		return sqlSession.delete("serverCalendar.deleteServerCalendar",parameters);
	}

	public ServerCalendar getServerCalendarOne(int serverCalendarKeyNum, String serverCalendarDepartment) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("serverCalendarKeyNum", serverCalendarKeyNum);
		parameters.put("serverCalendarDepartment", serverCalendarDepartment);
		return sqlSession.selectOne("serverCalendar.getServerCalendarOne",parameters);
	}

	public int saveServerCalendar(ServerCalendar serverCalendar) {
		return sqlSession.update("serverCalendar.saveServerCalendar",serverCalendar);
	}

	public List<ServerCalendar> alarmServerCalendar(String serverCalendarEnd, String serverCalendarAlarm) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("serverCalendarEnd", serverCalendarEnd);
		parameters.put("serverCalendarAlarm", serverCalendarAlarm);
		return sqlSession.selectList("serverCalendar.alarmServerCalendar", parameters);
	}
	
	public int insertServerListServerCalendar(ServerCalendar serverCalendar) {
		sqlSession.insert("serverCalendar.insertServerListServerCalendar", serverCalendar);
		return serverCalendar.getServerCalendarKeyNum();
	}

	public int updateServerListServerCalendar(ServerCalendar serverCalendar) {
		sqlSession.insert("serverCalendar.updateServerListServerCalendar", serverCalendar);
		return 0;
	}
}
