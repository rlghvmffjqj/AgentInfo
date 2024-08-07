package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.EmployeeService;
import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.vo.Employee;

@Controller
public class EmployeeController {
	@Autowired EmployeeService employeeService;
	@Autowired Employee employee;
	@Autowired FavoritePageService favoritePageService;
	
	/**
	 * 사원 리스트 페이지 이동
	 * @return
	 */
	@GetMapping(value = "/employee/list")
	public String EmployeeList(Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "사용자 정보");
		return "employee/EmployeeList";
	}
	
	/**
	 * 사원 리스트 테이블 정보 조회
	 * @param search
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/employee")
	public Map<String, Object> Employee(@ModelAttribute("search") Employee search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<Employee> list = new ArrayList<>(employeeService.getEmployeeList(search));
		int totalCount = employeeService.getEmployeeListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float)totalCount/search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	/**
	 * 사원 정보 삭제
	 * @param chkList
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/employee/delete")
	public String EmployeeDelete(@RequestParam String[] chkList) {
		return employeeService.delEmployee(chkList);
	}
	
	/**
	 * 사원 추가 모달
	 * @param model
	 * @return
	 */
	@PostMapping(value = "/employee/insertView")
	public String InsertEmployeeView(Model model, Employee employee) {
		model.addAttribute("viewType","insert").addAttribute("employee", employee);
		return "/employee/EmployeeView";
	}
	
	/**
	 * 사원 추가
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/employee/insert")
	public Map<String,String> InsertEmployee(Employee employee, Principal principal) {
		employee.setEmployeeRegistrant(principal.getName());
		// Date formatter 현재 시간
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		employee.setEmployeeRegistrationDate(formatter.format(now));

		Map<String,String> map = new HashMap<String,String>();
		String result = employeeService.insertEmployee(employee);
		map.put("result", result);
		return map;
	}
	
	/**
	 * 사원 정보 수정 Modal
	 * @param model
	 * @param departmentId
	 * @return
	 */
	@PostMapping(value ="employee/updateView")
	public String UpdateEmployeeView(Model model, String employeeId) {
		Employee employee = employeeService.getEmployeeOne(employeeId);
		model.addAttribute("viewType","update").addAttribute("employee", employee);
		return "/employee/EmployeeView";
	}
	
	/**
	 * 사원 정보 수정
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/employee/update")
	public Map<String,String> UpdateEmployee(Employee employee, Principal principal) {
		employee.setEmployeeModifier(principal.getName());
		// Date formatter 현재 시간
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		employee.setEmployeeModifiedDate(formatter.format(now));
		
		Map<String,String> map = new HashMap<String,String>();
		String result = employeeService.updateEmployee(employee);
		map.put("result", result);
		return map;
	}
	
	/**
	 * 부서 이동
	 * @param chkList
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/employee/departmentMove")
	public String departmentMove(@RequestParam String[] chkList, Employee employee) {
		return employeeService.updateDepartmentMove(chkList, employee);
	}
	
	/**
	 * 로그인 세션 만료 조회
	 * @param loginSession
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/employee/loginSession")
	public String loginSession(@RequestParam int loginSession, Principal principal) {
		return employeeService.loginSession(loginSession, principal.getName());
	}
}