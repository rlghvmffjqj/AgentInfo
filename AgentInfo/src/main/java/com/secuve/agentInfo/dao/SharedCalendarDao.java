package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.SharedCalendar;

@Repository
public class SharedCalendarDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<SharedCalendar> getSharedCalendarList(String sharedCalendarListDepartment) {
		return sqlSession.selectList("sharedCalendar.getSharedCalendarList", sharedCalendarListDepartment);
	}

	public int InsertSharedCalendarList(String sharedCalendarListContents, String sharedCalendarListColor, String sharedCalendarListDepartment, String sharedCalendarListRegistrant, String sharedCalendarListRegistrationDate) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("sharedCalendarListContents", sharedCalendarListContents);
		parameters.put("sharedCalendarListColor", sharedCalendarListColor);
		parameters.put("sharedCalendarListDepartment", sharedCalendarListDepartment);
		parameters.put("sharedCalendarListRegistrant", sharedCalendarListRegistrant);
		parameters.put("sharedCalendarListRegistrationDate", sharedCalendarListRegistrationDate);
		return sqlSession.insert("sharedCalendar.insertSharedCalendarList", parameters);
	}

	public int overlapSharedCalendarList(String sharedCalendarListContents, String sharedCalendarListDepartment) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("sharedCalendarListContents", sharedCalendarListContents);
		parameters.put("sharedCalendarListDepartment", sharedCalendarListDepartment);
		return sqlSession.selectOne("sharedCalendar.overlapSharedCalendarList", parameters);
	}

	public int InsertSharedCalendar(SharedCalendar sharedCalendar) {
		return sqlSession.insert("sharedCalendar.insertSharedCalendar", sharedCalendar);
	}

	public List<SharedCalendar> getSharedCalendar(String sharedCalendarDepartment) {
		return sqlSession.selectList("sharedCalendar.getSharedCalendar", sharedCalendarDepartment);
	}

	public int updateSharedCalendar(SharedCalendar sharedCalendar) {
		return sqlSession.update("sharedCalendar.updateSharedCalendar",sharedCalendar);
	}

	public int deleteSharedCalendar(int sharedCalendarKeyNum, String sharedCalendarDepartment) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("sharedCalendarKeyNum", sharedCalendarKeyNum);
		parameters.put("sharedCalendarDepartment", sharedCalendarDepartment);
		return sqlSession.delete("sharedCalendar.deleteSharedCalendar",parameters);
	}

	public SharedCalendar getSharedCalendarOne(int sharedCalendarKeyNum, String sharedCalendarDepartment) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("sharedCalendarKeyNum", sharedCalendarKeyNum);
		parameters.put("sharedCalendarDepartment", sharedCalendarDepartment);
		return sqlSession.selectOne("sharedCalendar.getSharedCalendarOne",parameters);
	}

	public int saveSharedCalendar(SharedCalendar sharedCalendar) {
		return sqlSession.update("sharedCalendar.saveSharedCalendar",sharedCalendar);
	}

	public List<SharedCalendar> alarmSharedCalendar(String sharedCalendarStart, String sharedCalendarAlarm) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("sharedCalendarStart", sharedCalendarStart);
		parameters.put("sharedCalendarAlarm", sharedCalendarAlarm);
		return sqlSession.selectList("sharedCalendar.alarmSharedCalendar", parameters);
	}


}
