package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.CalendarDao;
import com.secuve.agentInfo.vo.Calendar;

@Service
public class CalendarService {
	@Autowired CalendarDao calendarDao;

	public List<Calendar> getCalendarList(Principal principal) {
		List<Calendar> calendarList = calendarDao.getCalendarList();
		if(calendarList.size() == 0) {
			String nowDate = nowDate();
			calendarDao.InsertCalendarList("회의", "#11c15b", principal.getName(), nowDate);
			calendarDao.InsertCalendarList("외근", "#ff5252", principal.getName(), nowDate);
			calendarDao.InsertCalendarList("연차", "#ffe100", principal.getName(), nowDate);
			calendarDao.InsertCalendarList("반차", "#9261c6", principal.getName(), nowDate);
			calendarDao.InsertCalendarList("휴가", "#64b0f2", principal.getName(), nowDate);
			calendarList = calendarDao.getCalendarList();
		}
		return calendarList;
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String InsertCalendarList(Calendar calendar, Principal principal) {
		int overlap = calendarDao.overlapCalendarList(calendar.getCalendarListContents());
		if(overlap >= 1) {
			return "overlap";
		}
		int sucess = calendarDao.InsertCalendarList(calendar.getCalendarListContents(), calendar.getCalendarListColor(), calendar.getCalendarListRegistrant(), calendar.getCalendarListRegistrationDate());
		return parameter(sucess);
	}
	
	public String parameter(int sucess) {
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public int InsertCalendar(Calendar calendar) {
		int result = calendarDao.InsertCalendar(calendar);
		if(result > 0) {
			result = calendar.getCalendarKeyNum();
		} else {
			throw new RuntimeException();
		}
		return result; 
	}

	public List<Calendar> getCalendar() {
		return calendarDao.getCalendar();
	}

	public String UpdateCalendar(Calendar calendar) {
		int sucess = calendarDao.updateCalendar(calendar);
		return parameter(sucess);
	}

	public String DeleteCalendar(int calendarKeyNum) {
		int sucess = calendarDao.deleteCalendar(calendarKeyNum);
		return parameter(sucess);
	}

	public Calendar getCalendarOne(int calendarKeyNum) {
		return calendarDao.getCalendarOne(calendarKeyNum);
	}

	public String SaveCalendar(Calendar calendar) {
		// TODO Auto-generated method stub
		return null;
	}

}
