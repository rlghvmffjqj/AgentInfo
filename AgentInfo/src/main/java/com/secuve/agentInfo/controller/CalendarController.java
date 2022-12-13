package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.secuve.agentInfo.service.CalendarService;
import com.secuve.agentInfo.service.EmployeeService;
import com.secuve.agentInfo.vo.Calendar;

@Controller
public class CalendarController {
	@Autowired CalendarService calendarService;
	@Autowired EmployeeService employeeService;
	
	@GetMapping(value = "/calendar/list")
	public String CustomerList(Model model, Principal principal) {
		ArrayList<Calendar> calendarList = new ArrayList<>(calendarService.getCalendarList(principal.getName()));
		ArrayList<Calendar> calendar = new ArrayList<>(calendarService.getCalendar(principal.getName()));
		model.addAttribute("calendarList", calendarList);
		model.addAttribute("calendar", new Gson().toJson(calendar));
		return "/calendar/CalendarList";
	}
	
	@ResponseBody
	@PostMapping(value = "/calendarList/insert")
	public Map<String, String> InsertCalendarList(Calendar calendar, Principal principal) {
		calendar.setCalendarListRegistrant(principal.getName());
		calendar.setCalendarListRegistrationDate(calendarService.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		String result = calendarService.InsertCalendarList(calendar, principal);
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/calendar/insert")
	public Map<String, Integer> InsertCalendar(Calendar calendar, Principal principal) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		calendar.setCalendarRegistrant(principal.getName());
		calendar.setCalendarRegistrationDate(calendarService.nowDate());
		calendar.setCalendarStart(formatter.format(calendar.getCalendarStartDate()));
		calendar.setCalendarAlarm("09:00");
		String employeePhone = employeeService.getEmployeeOne(principal.getName()).getEmployeePhone();
		calendar.setCalendarPhone(employeePhone);

		Map<String, Integer> map = new HashMap<String, Integer>();
		int result = calendarService.InsertCalendar(calendar);
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/calendar/move")
	public Map<String, String> MoveCalendar(Calendar calendar, Principal principal) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		calendar.setCalendarRegistrant(principal.getName());
		calendar.setCalendarModifier(principal.getName());
		calendar.setCalendarModifiedDate(calendarService.nowDate());
		calendar.setCalendarStart(formatter.format(calendar.getCalendarStartDate()));
		calendar.setCalendarEnd(formatter.format(calendar.getCalendarEndDate()));
		
		Map<String, String> map = new HashMap<String, String>();
		String result = calendarService.UpdateCalendar(calendar);
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/calendar/delete")
	public Map<String, String> DeleteCalendar(Calendar calendar, Principal principal) {
		Map<String, String> map = new HashMap<String, String>();
		String result = calendarService.DeleteCalendar(calendar.getCalendarKeyNum(), principal.getName());
		map.put("result", result);
		return map;
	}
	
	@PostMapping(value = "/calendar/view")
	public String CalendarView(Model model, int calendarKeyNum, Principal principal) {
		Calendar calendar = calendarService.getCalendarOne(calendarKeyNum, principal.getName());
		String employeePhone = employeeService.getEmployeeOne(principal.getName()).getEmployeePhone();
		model.addAttribute("calendar", calendar);
		model.addAttribute("employeePhone", employeePhone);
		return "/calendar/CalendarView";
	}
	
	@ResponseBody
	@PostMapping(value = "/calendar/save")
	public Map<String, String> SaveCalendar(Calendar calendar, Principal principal) {
		calendar.setCalendarRegistrant(principal.getName());
		calendar.setCalendarModifier(principal.getName());
		calendar.setCalendarModifiedDate(calendarService.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		String result = calendarService.SaveCalendar(calendar);
		map.put("result", result);
		return map;
	}
	
	@Async
	@Scheduled(cron="0 * * * * ?")
	public void cronScheduler() {
		System.out.println("나는 시스템 시간을 기준으로 1분 마다 주기적으로 실행될거야");
		calendarService.calendarScheduler();
	  
	}
	
}
