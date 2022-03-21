package com.secuve.agentInfo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.secuve.agentInfo.service.UsersService;
import com.secuve.agentInfo.vo.Users;

@Controller
@RequestMapping(value = "/")
public class UsersController {
	@Autowired UsersService usersService;
	
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
		System.out.println("로그인 페이지");
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
		System.out.println("회원가입");
		usersService.save(users);
		return "Login";
	}
	
	@PostMapping("/sing")
	public String sig(Users users) {
		System.out.println("회원가입");
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
	
	
	
	

}
