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
import com.secuve.agentInfo.service.EmployeeService;
import com.secuve.agentInfo.service.ServerCalendarService;
import com.secuve.agentInfo.vo.ServerCalendar;

@Controller
public class ServerCalendarController {
	@Autowired ServerCalendarService serverCalendarService;
	@Autowired EmployeeService employeeService;
	
	@GetMapping(value = "/serverCalendar/list")
	public String ServerCalendarList(Model model, Principal principal) {
		String departmentName = employeeService.getEmployeeDepartment(principal.getName());
		ArrayList<ServerCalendar> serverCalendarList = new ArrayList<>(serverCalendarService.getServerCalendarList(principal.getName(), departmentName));
		ArrayList<ServerCalendar> serverCalendar = new ArrayList<>(serverCalendarService.getServerCalendar(departmentName));
		model.addAttribute("serverCalendarList", serverCalendarList);
		model.addAttribute("serverCalendar", new Gson().toJson(serverCalendar));
		return "/serverCalendar/ServerCalendarList";
	}
	
	@ResponseBody
	@PostMapping(value = "/serverCalendarList/insert")
	public Map<String, String> InsertServerCalendarList(ServerCalendar serverCalendar, Principal principal) {
		serverCalendar.setServerCalendarListRegistrant(principal.getName());
		serverCalendar.setServerCalendarListRegistrationDate(serverCalendarService.nowDate());
		serverCalendar.setServerCalendarListDepartment(employeeService.getEmployeeDepartment(principal.getName()));

		Map<String, String> map = new HashMap<String, String>();
		String result = serverCalendarService.InsertServerCalendarList(serverCalendar);
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/serverCalendar/insert")
	public Map<String, Integer> InsertServerCalendar(ServerCalendar serverCalendar, Principal principal) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		serverCalendar.setServerCalendarRegistrant(principal.getName());
		serverCalendar.setServerCalendarRegistrationDate(serverCalendarService.nowDate());
		serverCalendar.setServerCalendarStart(formatter.format(serverCalendar.getServerCalendarStartDate()));
		serverCalendar.setServerCalendarAlarm("09:00");
		String employeeEmail = employeeService.getEmployeeOne(principal.getName()).getEmployeeEmail();
		serverCalendar.setServerCalendarEmail(employeeEmail);
		serverCalendar.setServerCalendarDepartment(employeeService.getEmployeeDepartment(principal.getName()));

		Map<String, Integer> map = new HashMap<String, Integer>();
		int result = serverCalendarService.InsertServerCalendar(serverCalendar);
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/serverCalendar/move")
	public Map<String, String> MoveServerCalendar(ServerCalendar serverCalendar, Principal principal) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		serverCalendar.setServerCalendarRegistrant(principal.getName());
		serverCalendar.setServerCalendarModifier(principal.getName());
		serverCalendar.setServerCalendarModifiedDate(serverCalendarService.nowDate());
		serverCalendar.setServerCalendarStart(formatter.format(serverCalendar.getServerCalendarStartDate()));
		serverCalendar.setServerCalendarEnd(formatter.format(serverCalendar.getServerCalendarEndDate()));
		serverCalendar.setServerCalendarDepartment(employeeService.getEmployeeDepartment(principal.getName()));
		
		Map<String, String> map = new HashMap<String, String>();
		String result = serverCalendarService.UpdateServerCalendar(serverCalendar);
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/serverCalendar/delete")
	public Map<String, String> DeleteServerCalendar(ServerCalendar serverCalendar, Principal principal) {
		Map<String, String> map = new HashMap<String, String>();
		String result = serverCalendarService.DeleteServerCalendar(serverCalendar.getServerCalendarKeyNum(), employeeService.getEmployeeDepartment(principal.getName()));
		map.put("result", result);
		return map;
	}
	
	@PostMapping(value = "/serverCalendar/view")
	public String ServerCalendarView(Model model, int serverCalendarKeyNum, Principal principal) {
		ServerCalendar serverCalendar = serverCalendarService.getServerCalendarOne(serverCalendarKeyNum, employeeService.getEmployeeDepartment(principal.getName()));
		String employeeEmail = employeeService.getEmployeeOne(principal.getName()).getEmployeeEmail();
		model.addAttribute("serverCalendar", serverCalendar);
		model.addAttribute("employeeEmail", employeeEmail);
		return "/serverCalendar/ServerCalendarView";
	}
	
	@ResponseBody
	@PostMapping(value = "/serverCalendar/save")
	public Map<String, String> SaveServerCalendar(ServerCalendar serverCalendar, Principal principal) {
		serverCalendar.setServerCalendarRegistrant(principal.getName());
		serverCalendar.setServerCalendarModifier(principal.getName());
		serverCalendar.setServerCalendarModifiedDate(serverCalendarService.nowDate());
		serverCalendar.setServerCalendarDepartment(employeeService.getEmployeeDepartment(principal.getName()));

		Map<String, String> map = new HashMap<String, String>();
		String result = serverCalendarService.SaveServerCalendar(serverCalendar);
		map.put("result", result);
		return map;
	}
	
	//@Async
	//@Scheduled(cron="0 * * * * ?")
	//public void cronScheduler() {
	//	serverCalendarService.serverCalendarScheduler();
	//  
	//}

}
