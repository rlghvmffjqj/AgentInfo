package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.Calendar;

@Repository
public class CalendarDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<Calendar> getCalendarList(String calendarListRegistrant) {
		return sqlSession.selectList("calendar.getCalendarList", calendarListRegistrant);
	}

	public int InsertCalendarList(String calendarListContents, String calendarListColor, String calendarListRegistrant, String calendarListRegistrationDate) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("calendarListContents", calendarListContents);
		parameters.put("calendarListColor", calendarListColor);
		parameters.put("calendarListRegistrant", calendarListRegistrant);
		parameters.put("calendarListRegistrationDate", calendarListRegistrationDate);
		return sqlSession.insert("calendar.insertCalendarList", parameters);
	}

	public int overlapCalendarList(String calendarListContents, String calendarListRegistrant) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("calendarListContents", calendarListContents);
		parameters.put("calendarListRegistrant", calendarListRegistrant);
		return sqlSession.selectOne("calendar.overlapCalendarList", parameters);
	}

	public int InsertCalendar(Calendar calendar) {
		return sqlSession.insert("calendar.insertCalendar", calendar);
	}

	public List<Calendar> getCalendar(String calendarRegistrant) {
		return sqlSession.selectList("calendar.getCalendar", calendarRegistrant);
	}

	public int updateCalendar(Calendar calendar) {
		return sqlSession.update("calendar.updateCalendar",calendar);
	}

	public int deleteCalendar(int calendarKeyNum, String calendarRegistrant) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("calendarKeyNum", calendarKeyNum);
		parameters.put("calendarRegistrant", calendarRegistrant);
		return sqlSession.delete("calendar.deleteCalendar",parameters);
	}

	public Calendar getCalendarOne(int calendarKeyNum, String calendarRegistrant) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("calendarKeyNum", calendarKeyNum);
		parameters.put("calendarRegistrant", calendarRegistrant);
		return sqlSession.selectOne("calendar.getCalendarOne",parameters);
	}

	public int saveCalendar(Calendar calendar) {
		return sqlSession.update("calendar.saveCalendar",calendar);
	}

	public List<Calendar> alarmCalendar(String calendarStart, String calendarAlarm) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("calendarStart", calendarStart);
		parameters.put("calendarAlarm", calendarAlarm);
		return sqlSession.selectList("calendar.alarmCalendar", parameters);
	}

	public int insertServerListCalendar(Calendar calendar) {
		sqlSession.insert("calendar.insertServerListCalendar", calendar);
		return calendar.getCalendarKeyNum();
	}

	public int updateServerListCalendar(Calendar calendar) {
		sqlSession.insert("calendar.updateServerListCalendar", calendar);
		return 0;
	}


}
