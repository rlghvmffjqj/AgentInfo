package com.secuve.agentInfo.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.core.MailService;
import com.secuve.agentInfo.dao.EmployeeDao;
import com.secuve.agentInfo.dao.ServerCalendarDao;
import com.secuve.agentInfo.vo.Employee;
import com.secuve.agentInfo.vo.ServerCalendar;

@Service
public class ServerCalendarService {
	@Autowired ServerCalendarDao serverCalendarDao;
	@Autowired MailService mailService;
	@Autowired EmployeeDao employeeDao;

	public List<ServerCalendar> getServerCalendarList(String serverCalendarListRegistrant, String serverCalendarListDepartment) {
		List<ServerCalendar> serverCalendarList = serverCalendarDao.getServerCalendarList(serverCalendarListDepartment);
		if(serverCalendarList.size() == 0) {
			String nowDate = nowDate();
			serverCalendarDao.InsertServerCalendarList("정상작동", "#38D11A", serverCalendarListDepartment, serverCalendarListRegistrant, nowDate);
			serverCalendarDao.InsertServerCalendarList("접속불가", "#FF3E3E", serverCalendarListDepartment, serverCalendarListRegistrant, nowDate);
			serverCalendarDao.InsertServerCalendarList("업데이트", "#776D18", serverCalendarListDepartment, serverCalendarListRegistrant, nowDate);
			serverCalendarDao.InsertServerCalendarList("외부반출", "#D9CC00", serverCalendarListDepartment, serverCalendarListRegistrant, nowDate);
			serverCalendarDao.InsertServerCalendarList("장비대여", "#2941FF", serverCalendarListDepartment, serverCalendarListRegistrant, nowDate);
			serverCalendarList = serverCalendarDao.getServerCalendarList(serverCalendarListDepartment);
		}
		return serverCalendarList;
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String InsertServerCalendarList(ServerCalendar serverCalendar) {
		int overlap = serverCalendarDao.overlapServerCalendarList(serverCalendar.getServerCalendarListContents(), serverCalendar.getServerCalendarListDepartment());
		if(overlap >= 1) {
			return "overlap";
		}
		int success = serverCalendarDao.InsertServerCalendarList(serverCalendar.getServerCalendarListContents(), serverCalendar.getServerCalendarListColor(), serverCalendar.getServerCalendarListDepartment(), serverCalendar.getServerCalendarListRegistrant(), serverCalendar.getServerCalendarListRegistrationDate());
		return parameter(success);
	}
	
	public String parameter(int success) {
		if (success <= 0)
			return "FALSE";
		return "OK";
	}

	public int InsertServerCalendar(ServerCalendar serverCalendar) {
		serverCalendar.setServerCalendarEmail(serverCalendar.getServerCalendarEmail());
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		Date start = new Date(serverCalendar.getServerCalendarStart());
		serverCalendar.setServerCalendarStart(formatter.format(start));
		serverCalendar.setServerCalendarEnd(serverCalendar.getServerCalendarStart());
		int result = serverCalendarDao.InsertServerCalendar(serverCalendar);
		if(result > 0) {
			result = serverCalendar.getServerCalendarKeyNum();
		} else {
			throw new RuntimeException();
		}
		return result; 
	}

	public List<ServerCalendar> getServerCalendar(String serverCalendarDepartment) {
		return serverCalendarDao.getServerCalendar(serverCalendarDepartment);
	}

	public String UpdateServerCalendar(ServerCalendar serverCalendar) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		Date start = new Date(serverCalendar.getServerCalendarStart());
		Date end = new Date(serverCalendar.getServerCalendarEnd());
		serverCalendar.setServerCalendarStart(formatter.format(start));
		serverCalendar.setServerCalendarEnd(formatter.format(end));
		
		int success = serverCalendarDao.updateServerCalendar(serverCalendar);
		return parameter(success);
	}

	public String DeleteServerCalendar(int serverCalendarKeyNum, String serverCalendarDepartment) {
		int success = serverCalendarDao.deleteServerCalendar(serverCalendarKeyNum, serverCalendarDepartment);
		return parameter(success);
	}

	public ServerCalendar getServerCalendarOne(int serverCalendarKeyNum, String serverCalendarDepartment) {
		ServerCalendar serverCalendar = serverCalendarDao.getServerCalendarOne(serverCalendarKeyNum, serverCalendarDepartment);
		return serverCalendar;
	}

	public String SaveServerCalendar(ServerCalendar serverCalendar) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		Date start = new Date(serverCalendar.getServerCalendarStart());
		Date end = new Date(serverCalendar.getServerCalendarEnd());
		serverCalendar.setServerCalendarStart(formatter.format(start));
		serverCalendar.setServerCalendarEnd(formatter.format(end));
		int compare = start.compareTo(end);
		if(compare > 0) {
			return "DateOver";
		}	
		
		int success = serverCalendarDao.saveServerCalendar(serverCalendar);
		return parameter(success);
	}

	public void serverCalendarScheduler() {
		Date endtDate = new Date();
		Date now = new Date();
		java.util.Calendar cal = java.util.Calendar.getInstance();
		cal.setTime(endtDate);
		cal.add(java.util.Calendar.DATE, 1);
		SimpleDateFormat serverCalendarEnd = new SimpleDateFormat("yyyy/MM/dd");
		SimpleDateFormat serverCalendarAlarm = new SimpleDateFormat("HH:mm");
		List<ServerCalendar> serverCalendarList = serverCalendarDao.alarmServerCalendar(serverCalendarEnd.format(cal.getTime()), serverCalendarEnd.format(now), serverCalendarAlarm.format(now));
		for (ServerCalendar serverCalendar : serverCalendarList) {
			List<Employee> employeeList = employeeDao.getDepartmentEmail(serverCalendar.getServerCalendarDepartment());
			for (Employee employee : employeeList) {
				try {
					mailService.sendNotiMail(employee.getEmployeeEmail(), "장비대여 일정 만료", "자산번호 : "+serverCalendar.getServerCalendarContents());
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
}
