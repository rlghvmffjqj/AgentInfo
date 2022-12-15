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
import com.secuve.agentInfo.service.SharedCalendarService;
import com.secuve.agentInfo.service.EmployeeService;
import com.secuve.agentInfo.vo.SharedCalendar;

@Controller
public class SharedCalendarController {
	@Autowired SharedCalendarService sharedCalendarService;
	@Autowired EmployeeService employeeService;
	
	@GetMapping(value = "/sharedCalendar/list")
	public String CustomerList(Model model, Principal principal) {
		String departmentName = employeeService.getEmployeeDepartment(principal.getName());
		ArrayList<SharedCalendar> sharedCalendarList = new ArrayList<>(sharedCalendarService.getSharedCalendarList(principal.getName(), departmentName));
		ArrayList<SharedCalendar> sharedCalendar = new ArrayList<>(sharedCalendarService.getSharedCalendar(departmentName));
		model.addAttribute("sharedCalendarList", sharedCalendarList);
		model.addAttribute("sharedCalendar", new Gson().toJson(sharedCalendar));
		return "/sharedCalendar/SharedCalendarList";
	}
	
	@ResponseBody
	@PostMapping(value = "/sharedCalendarList/insert")
	public Map<String, String> InsertSharedCalendarList(SharedCalendar sharedCalendar, Principal principal) {
		sharedCalendar.setSharedCalendarListRegistrant(principal.getName());
		sharedCalendar.setSharedCalendarListRegistrationDate(sharedCalendarService.nowDate());
		sharedCalendar.setSharedCalendarListDepartment(employeeService.getEmployeeDepartment(principal.getName()));

		Map<String, String> map = new HashMap<String, String>();
		String result = sharedCalendarService.InsertSharedCalendarList(sharedCalendar);
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/sharedCalendar/insert")
	public Map<String, Integer> InsertSharedCalendar(SharedCalendar sharedCalendar, Principal principal) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		sharedCalendar.setSharedCalendarRegistrant(principal.getName());
		sharedCalendar.setSharedCalendarRegistrationDate(sharedCalendarService.nowDate());
		sharedCalendar.setSharedCalendarStart(formatter.format(sharedCalendar.getSharedCalendarStartDate()));
		sharedCalendar.setSharedCalendarAlarm("09:00");
		String employeeEmail = employeeService.getEmployeeOne(principal.getName()).getEmployeeEmail();
		sharedCalendar.setSharedCalendarEmail(employeeEmail);
		sharedCalendar.setSharedCalendarDepartment(employeeService.getEmployeeDepartment(principal.getName()));

		Map<String, Integer> map = new HashMap<String, Integer>();
		int result = sharedCalendarService.InsertSharedCalendar(sharedCalendar);
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/sharedCalendar/move")
	public Map<String, String> MoveSharedCalendar(SharedCalendar sharedCalendar, Principal principal) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		sharedCalendar.setSharedCalendarRegistrant(principal.getName());
		sharedCalendar.setSharedCalendarModifier(principal.getName());
		sharedCalendar.setSharedCalendarModifiedDate(sharedCalendarService.nowDate());
		sharedCalendar.setSharedCalendarStart(formatter.format(sharedCalendar.getSharedCalendarStartDate()));
		sharedCalendar.setSharedCalendarEnd(formatter.format(sharedCalendar.getSharedCalendarEndDate()));
		sharedCalendar.setSharedCalendarDepartment(employeeService.getEmployeeDepartment(principal.getName()));
		
		Map<String, String> map = new HashMap<String, String>();
		String result = sharedCalendarService.UpdateSharedCalendar(sharedCalendar);
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/sharedCalendar/delete")
	public Map<String, String> DeleteSharedCalendar(SharedCalendar sharedCalendar, Principal principal) {
		Map<String, String> map = new HashMap<String, String>();
		String result = sharedCalendarService.DeleteSharedCalendar(sharedCalendar.getSharedCalendarKeyNum(), employeeService.getEmployeeDepartment(principal.getName()));
		map.put("result", result);
		return map;
	}
	
	@PostMapping(value = "/sharedCalendar/view")
	public String SharedCalendarView(Model model, int sharedCalendarKeyNum, Principal principal) {
		SharedCalendar sharedCalendar = sharedCalendarService.getSharedCalendarOne(sharedCalendarKeyNum, employeeService.getEmployeeDepartment(principal.getName()));
		String employeeEmail = employeeService.getEmployeeOne(principal.getName()).getEmployeeEmail();
		model.addAttribute("sharedCalendar", sharedCalendar);
		model.addAttribute("employeeEmail", employeeEmail);
		return "/sharedCalendar/SharedCalendarView";
	}
	
	@ResponseBody
	@PostMapping(value = "/sharedCalendar/save")
	public Map<String, String> SaveSharedCalendar(SharedCalendar sharedCalendar, Principal principal) {
		sharedCalendar.setSharedCalendarRegistrant(principal.getName());
		sharedCalendar.setSharedCalendarModifier(principal.getName());
		sharedCalendar.setSharedCalendarModifiedDate(sharedCalendarService.nowDate());
		sharedCalendar.setSharedCalendarDepartment(employeeService.getEmployeeDepartment(principal.getName()));

		Map<String, String> map = new HashMap<String, String>();
		String result = sharedCalendarService.SaveSharedCalendar(sharedCalendar);
		map.put("result", result);
		return map;
	}
	
	@Async
	@Scheduled(cron="0 * * * * ?")
	public void cronScheduler() {
		sharedCalendarService.sharedCalendarScheduler();
	  
	}
	
}
