package com.secuve.agentInfo.controller;

import java.security.Principal;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.secuve.agentInfo.service.EmployeeService;
import com.secuve.agentInfo.service.UsersService;
import com.secuve.agentInfo.vo.Employee;
import com.secuve.agentInfo.vo.Users;

@Controller
@RequestMapping(value = "/")
public class UsersController {
	private static final Logger LOGGER = LogManager.getLogger(UsersController.class);
	@Autowired UsersService usersService;
	@Autowired EmployeeService employeeService;
	
	/**
	 * 인덱스
	 * @return
	 */
	@GetMapping("/")
	public String View() {
		return "Index";
	}
	
	/**
	 * 인덱스
	 * @return
	 */
	@GetMapping("/index")
	public String indexView() {
		return "Index";
	}
	
	/**
	 * 로그인
	 * @return
	 */
	@GetMapping("/login")
	public String loginView() {
		LOGGER.info("로그인 페이지");
		return "Login";
	}
	
	/**
	 * 로그인 실패
	 * @return
	 */
	@GetMapping("/failPage")
	public String failView() {
		return "FailPage";
	}
	
	/**
	 * 회원가입 페이지
	 * @return
	 */
	@GetMapping("/signup")
	public String signupView() {
		return "Signup";
	}
	
	/**
	 * 회원가입
	 * @param usersVo
	 * @return
	 */
	@PostMapping("/signup")
	public String signup(Users users) {
		LOGGER.info("회원가입");
		usersService.save(users);
		return "Login";
	}
	
	
	/**
	 * 일반 사용자 정보
	 * @return
	 */
	@GetMapping("/users/info")
	public String userInfoView() {
		return "users/UsersInfo";
	}
	
	/**
	 * 관리자 정보
	 * @return
	 */
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/admin")
	public String adminView() {
		return "users/Admin";
	}
	
	/**
	 * 접속 불가 
	 * @return
	 */
	@GetMapping("/denied")
	public String deniedView() {
		return "Denied";
	}
	
	@GetMapping("/loginFail")
	public String loginFail(Model model) {
		String loc = "/login";
		String msg = "아이디 및 패스워드가 일치하지 않습니다.";

		model.addAttribute("loc", loc).addAttribute("msg", msg);
		return "common/msg";
	}
	
	@PostMapping(value ="/usres/profileView")
	public String UpdateEmployeeView(Model model, Principal principal) {
		Employee employee = employeeService.getEmployeeOne(principal.getName());
		model.addAttribute("employee", employee);
		return "users/ProfileView";
	}

}
