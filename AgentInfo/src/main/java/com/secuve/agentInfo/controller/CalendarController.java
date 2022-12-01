package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.secuve.agentInfo.service.CalendarService;
import com.secuve.agentInfo.vo.Calendar;

@Controller
public class CalendarController {
	@Autowired CalendarService calendarService;
	
	@GetMapping(value = "/calendar/list")
	public String CustomerList(Model model, Principal principal) {
		ArrayList<Calendar> calendarList = new ArrayList<>(calendarService.getCalendarList(principal));
		ArrayList<Calendar> calendar = new ArrayList<>(calendarService.getCalendar());
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
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
		calendar.setCalendarRegistrant(principal.getName());
		calendar.setCalendarRegistrationDate(calendarService.nowDate());
		calendar.setCalendarStart(formatter.format(calendar.getCalendarStartDate()));

		Map<String, Integer> map = new HashMap<String, Integer>();
		int result = calendarService.InsertCalendar(calendar);
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/calendar/move")
	public Map<String, String> MoveCalendar(Calendar calendar, Principal principal) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
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
		String result = calendarService.DeleteCalendar(calendar.getCalendarKeyNum());
		map.put("result", result);
		return map;
	}
	
}
