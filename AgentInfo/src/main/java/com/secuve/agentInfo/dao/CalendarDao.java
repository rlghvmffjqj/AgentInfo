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

	public List<Calendar> getCalendarList() {
		return sqlSession.selectList("calendar.getCalendarList");
	}

	public int InsertCalendarList(String calendarListContents, String calendarListColor, String calendarListRegistrant, String calendarListRegistrationDate) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("calendarListContents", calendarListContents);
		parameters.put("calendarListColor", calendarListColor);
		parameters.put("calendarListRegistrant", calendarListRegistrant);
		parameters.put("calendarListRegistrationDate", calendarListRegistrationDate);
		return sqlSession.insert("calendar.insertCalendarList", parameters);
	}

	public int overlapCalendarList(String calendarListContents) {
		return sqlSession.selectOne("calendar.overlapCalendarList", calendarListContents);
	}

	public int InsertCalendar(Calendar calendar) {
		return sqlSession.insert("calendar.insertCalendar", calendar);
	}

	public List<Calendar> getCalendar() {
		return sqlSession.selectList("calendar.getCalendar");
	}

	public int updateCalendar(Calendar calendar) {
		return sqlSession.update("calendar.updateCalendar",calendar);
	}

	public int deleteCalendar(int calendarKeyNum) {
		return sqlSession.delete("calendar.deleteCalendar",calendarKeyNum);
	}


}
