package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.core.SmsService;
import com.secuve.agentInfo.dao.CalendarDao;
import com.secuve.agentInfo.vo.Calendar;
import com.secuve.agentInfo.vo.Message;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class CalendarService {
	@Autowired CalendarDao calendarDao;
	@Autowired SmsService smsService;

	public List<Calendar> getCalendarList(String calendarListRegistrant) {
		List<Calendar> calendarList = calendarDao.getCalendarList(calendarListRegistrant);
		if(calendarList.size() == 0) {
			String nowDate = nowDate();
			calendarDao.InsertCalendarList("회의", "#11c15b", calendarListRegistrant, nowDate);
			calendarDao.InsertCalendarList("외근", "#ff5252", calendarListRegistrant, nowDate);
			calendarDao.InsertCalendarList("연차", "#ffe100", calendarListRegistrant, nowDate);
			calendarDao.InsertCalendarList("반차", "#9261c6", calendarListRegistrant, nowDate);
			calendarDao.InsertCalendarList("휴가", "#64b0f2", calendarListRegistrant, nowDate);
			calendarList = calendarDao.getCalendarList(calendarListRegistrant);
		}
		return calendarList;
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String InsertCalendarList(Calendar calendar, Principal principal) {
		int overlap = calendarDao.overlapCalendarList(calendar.getCalendarListContents(), principal.getName());
		if(overlap >= 1) {
			return "overlap";
		}
		int success = calendarDao.InsertCalendarList(calendar.getCalendarListContents(), calendar.getCalendarListColor(), calendar.getCalendarListRegistrant(), calendar.getCalendarListRegistrationDate());
		return parameter(success);
	}
	
	public String parameter(int success) {
		if (success <= 0)
			return "FALSE";
		return "OK";
	}

	public int InsertCalendar(Calendar calendar) {
		calendar.setCalendarPhone(calendar.getCalendarPhone().replace("-", ""));
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		Date start = new Date(calendar.getCalendarStart());
		calendar.setCalendarStart(formatter.format(start));
		calendar.setCalendarEnd(calendar.getCalendarStart());
		int result = calendarDao.InsertCalendar(calendar);
		if(result > 0) {
			result = calendar.getCalendarKeyNum();
		} else {
			throw new RuntimeException();
		}
		return result; 
	}

	public List<Calendar> getCalendar(String calendarRegistrant) {
		return calendarDao.getCalendar(calendarRegistrant);
	}

	public String UpdateCalendar(Calendar calendar) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		Date start = new Date(calendar.getCalendarStart());
		Date end = new Date(calendar.getCalendarEnd());
		calendar.setCalendarStart(formatter.format(start));
		calendar.setCalendarEnd(formatter.format(end));
		
		int success = calendarDao.updateCalendar(calendar);
		return parameter(success);
	}

	public String DeleteCalendar(int calendarKeyNum, String calendarRegistrant) {
		int success = calendarDao.deleteCalendar(calendarKeyNum, calendarRegistrant);
		return parameter(success);
	}

	public Calendar getCalendarOne(int calendarKeyNum, String calendarRegistrant) {
		Calendar calendar = calendarDao.getCalendarOne(calendarKeyNum, calendarRegistrant);
		return calendar;
	}

	public String SaveCalendar(Calendar calendar) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		Date start = new Date(calendar.getCalendarStart());
		Date end = new Date(calendar.getCalendarEnd());
		calendar.setCalendarStart(formatter.format(start));
		calendar.setCalendarEnd(formatter.format(end));
		int compare = start.compareTo(end);
		if(compare > 0) {
			return "DateOver";
		}	
		
		int success = calendarDao.saveCalendar(calendar);
		return parameter(success);
	}

	public void calendarScheduler() {
		Date now = new Date();
		SimpleDateFormat calendarStart = new SimpleDateFormat("yyyy/MM/dd");
		SimpleDateFormat calendarAlarm = new SimpleDateFormat("HH:mm");
		List<Calendar> list = calendarDao.alarmCalendar(calendarStart.format(now), calendarAlarm.format(now));
		Message message = new Message();
		for (Calendar calendar : list) {
			message.setTo(calendar.getCalendarPhone());
			message.setContent(calendar.getCalendarContents());
			try {
				smsService.sendSms(message); // 문자 전송 기능 활성화 할 경우 월 50건 이상 사용 시 요금 발생
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
