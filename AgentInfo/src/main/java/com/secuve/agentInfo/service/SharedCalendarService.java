package com.secuve.agentInfo.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.core.MailService;
import com.secuve.agentInfo.core.SmsService;
import com.secuve.agentInfo.dao.EmployeeDao;
import com.secuve.agentInfo.dao.SharedCalendarDao;
import com.secuve.agentInfo.vo.Employee;
import com.secuve.agentInfo.vo.SharedCalendar;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class SharedCalendarService {
	@Autowired SharedCalendarDao sharedCalendarDao;
	@Autowired SmsService smsService;
	@Autowired MailService mailService;
	@Autowired EmployeeDao employeeDao;

	public List<SharedCalendar> getSharedCalendarList(String sharedCalendarListRegistrant, String sharedCalendarListDepartment) {
		List<SharedCalendar> sharedCalendarList = sharedCalendarDao.getSharedCalendarList(sharedCalendarListDepartment);
		if(sharedCalendarList.size() == 0) {
			String nowDate = nowDate();
			sharedCalendarDao.InsertSharedCalendarList("회의", "#11c15b", sharedCalendarListDepartment, sharedCalendarListRegistrant, nowDate);
			sharedCalendarDao.InsertSharedCalendarList("외근", "#ff5252", sharedCalendarListDepartment, sharedCalendarListRegistrant, nowDate);
			sharedCalendarDao.InsertSharedCalendarList("연차", "#ffe100", sharedCalendarListDepartment, sharedCalendarListRegistrant, nowDate);
			sharedCalendarDao.InsertSharedCalendarList("반차", "#9261c6", sharedCalendarListDepartment, sharedCalendarListRegistrant, nowDate);
			sharedCalendarDao.InsertSharedCalendarList("휴가", "#64b0f2", sharedCalendarListDepartment, sharedCalendarListRegistrant, nowDate);
			sharedCalendarList = sharedCalendarDao.getSharedCalendarList(sharedCalendarListDepartment);
		}
		return sharedCalendarList;
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String InsertSharedCalendarList(SharedCalendar sharedCalendar) {
		int overlap = sharedCalendarDao.overlapSharedCalendarList(sharedCalendar.getSharedCalendarListContents(), sharedCalendar.getSharedCalendarListDepartment());
		if(overlap >= 1) {
			return "overlap";
		}
		int sucess = sharedCalendarDao.InsertSharedCalendarList(sharedCalendar.getSharedCalendarListContents(), sharedCalendar.getSharedCalendarListColor(), sharedCalendar.getSharedCalendarListDepartment(), sharedCalendar.getSharedCalendarListRegistrant(), sharedCalendar.getSharedCalendarListRegistrationDate());
		return parameter(sucess);
	}
	
	public String parameter(int sucess) {
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public int InsertSharedCalendar(SharedCalendar sharedCalendar) {
		sharedCalendar.setSharedCalendarEmail(sharedCalendar.getSharedCalendarEmail());
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		Date start = new Date(sharedCalendar.getSharedCalendarStart());
		sharedCalendar.setSharedCalendarStart(formatter.format(start));
		sharedCalendar.setSharedCalendarEnd(sharedCalendar.getSharedCalendarStart());
		int result = sharedCalendarDao.InsertSharedCalendar(sharedCalendar);
		if(result > 0) {
			result = sharedCalendar.getSharedCalendarKeyNum();
		} else {
			throw new RuntimeException();
		}
		return result; 
	}

	public List<SharedCalendar> getSharedCalendar(String sharedCalendarDepartment) {
		return sharedCalendarDao.getSharedCalendar(sharedCalendarDepartment);
	}

	public String UpdateSharedCalendar(SharedCalendar sharedCalendar) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		Date start = new Date(sharedCalendar.getSharedCalendarStart());
		Date end = new Date(sharedCalendar.getSharedCalendarEnd());
		sharedCalendar.setSharedCalendarStart(formatter.format(start));
		sharedCalendar.setSharedCalendarEnd(formatter.format(end));
		
		int sucess = sharedCalendarDao.updateSharedCalendar(sharedCalendar);
		return parameter(sucess);
	}

	public String DeleteSharedCalendar(int sharedCalendarKeyNum, String sharedCalendarDepartment) {
		int sucess = sharedCalendarDao.deleteSharedCalendar(sharedCalendarKeyNum, sharedCalendarDepartment);
		return parameter(sucess);
	}

	public SharedCalendar getSharedCalendarOne(int sharedCalendarKeyNum, String sharedCalendarDepartment) {
		SharedCalendar sharedCalendar = sharedCalendarDao.getSharedCalendarOne(sharedCalendarKeyNum, sharedCalendarDepartment);
		return sharedCalendar;
	}

	public String SaveSharedCalendar(SharedCalendar sharedCalendar) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		Date start = new Date(sharedCalendar.getSharedCalendarStart());
		Date end = new Date(sharedCalendar.getSharedCalendarEnd());
		sharedCalendar.setSharedCalendarStart(formatter.format(start));
		sharedCalendar.setSharedCalendarEnd(formatter.format(end));
		int compare = start.compareTo(end);
		if(compare > 0) {
			return "DateOver";
		}	
		
		int sucess = sharedCalendarDao.saveSharedCalendar(sharedCalendar);
		return parameter(sucess);
	}

	public void sharedCalendarScheduler() {
		Date now = new Date();
		SimpleDateFormat sharedCalendarStart = new SimpleDateFormat("yyyy/MM/dd");
		SimpleDateFormat sharedCalendarAlarm = new SimpleDateFormat("HH:mm");
		List<SharedCalendar> sharedCalendarList = sharedCalendarDao.alarmSharedCalendar(sharedCalendarStart.format(now), sharedCalendarAlarm.format(now));
		for (SharedCalendar sharedCalendar : sharedCalendarList) {
			List<Employee> employeeList = employeeDao.getDepartmentEmail(sharedCalendar.getSharedCalendarDepartment());
			for (Employee employee : employeeList) {
				try {
					mailService.sendNotiMail(employee.getEmployeeEmail(), "부서 일정 확인", sharedCalendar.getSharedCalendarContents());
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

}
