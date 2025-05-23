package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.EmployeeService;
import com.secuve.agentInfo.service.QuestionAnswerService;
import com.secuve.agentInfo.service.UsersService;
import com.secuve.agentInfo.vo.Employee;
import com.secuve.agentInfo.vo.UserAlarm;

@Controller
@RequestMapping(value = "/")
public class UsersController {
	private static final Logger LOGGER = LogManager.getLogger(UsersController.class);
	@Autowired UsersService usersService;
	@Autowired EmployeeService employeeService;
	@Autowired QuestionAnswerService questionAnswerService;
	@Autowired private SessionRegistry sessionRegistry;
	
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
	
	/**
	 * 로그인 실패 알림
	 * @param model
	 * @return
	 */
	@GetMapping("/loginFail")
	public String loginFail(Model model) {
		String loc = "/login";
		String msg = "아이디 및 패스워드가 일치하지 않습니다.";

		model.addAttribute("loc", loc).addAttribute("msg", msg);
		return "common/msg";
	}
	
	/**
	 * 중복 접속 방지
	 * @param model
	 * @return
	 */
	@GetMapping("/sessionExpired")
	public String SessionExpired(Model model) {
		String loc = "/login";
		String msg = "다른 사용자가 현재 접속한 계정으로 로그인하거나 <br> 관리자가 세션을 종료했습니다";

		model.addAttribute("loc", loc).addAttribute("msg", msg);
		return "common/msg";
	}
	
	/**
	 * 프로필 Modal
	 * @param model
	 * @param principal
	 * @return
	 */
	@PostMapping(value ="/users/profileView")
	public String UpdateEmployeeView(Model model, Principal principal) {
		Employee employee = employeeService.getEmployeeOne(principal.getName());
		model.addAttribute("employee", employee);
		return "users/ProfileView";
	}
	
	/**
	 * 아이디 패스워드 일치여부 검사
	 * @param usersId
	 * @param usersPw
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/users/pwdCheck")
	public String PwdCheck(String usersId, String usersPw) {
		String result = usersService.loginIdPwd(usersId, usersPw); 
		return result;
	}
	
	/**
	 * 패스워드 변경 Modal
	 * @return
	 */
	@PostMapping(value = "/users/pwdChangeView")
	public String PwdChange() {
		return "users/PwdChangeView";
	}
	
	/**
	 * 패스워드 변경
	 * @param oldPwd
	 * @param changePwd
	 * @param confirmPwd
	 * @param usersId
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/users/pwdChange")
	public String PwdChange(String oldPwd, String changePwd, String confirmPwd, String usersId) {
		return usersService.updateUsersPwd(oldPwd, changePwd, confirmPwd, usersId);
	}
	
	@ResponseBody
	@PostMapping(value = "/users/alarm")
	public Map Alarm(Principal principal) {
//		String role = employeeService.getUsersRole(principal.getName());
		List<UserAlarm> list = new ArrayList<UserAlarm>();
//		if(role.equals("ADMIN")) {
//			list = questionAnswerService.getQuestionAnswerAlarm();
//		}
		list = usersService.getUserAlarm(principal.getName());
		int notRead = 0;
		for(UserAlarm userAlarm : list) {
			if(userAlarm.getUserAlarmStateN().equals("N"))
				notRead += 1;
		}
		Map map = new HashMap();
		map.put("list", list);
		map.put("notRead", notRead);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/users/lockChange")
	public String LockChange(String employeeId, String type) {
		return usersService.lockChange(employeeId, type);
	}
	
	/**
	 * 로그아웃 시 세션 만료시키기위해 추가
	 * @param request
	 * @return
	 */
	@GetMapping(value = "/users/logout")
	public String  Logout(HttpServletRequest request) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String sessionId = null;
	    if (authentication != null && authentication.getPrincipal() != null) {
	        Object principal = authentication.getPrincipal();
	        if (principal instanceof UserDetails) {
	        	sessionId = request.getSession().getId();
	        }
	    }
		
	    try {
	    	SessionInformation sessionInformation = sessionRegistry.getSessionInformation(sessionId);	
	        if (sessionInformation != null) {
	            sessionInformation.expireNow();
	        }
	    } catch (Exception e) {
			return "redirect:/login";
		}
		return "redirect:/logout"; 
	}
	
	@GetMapping("/errorPage")
	public String errorPage() {
		return "/Error";
	}
	
	@ResponseBody
	@PostMapping("/users/lastTimeUpdate") 
	public void LastTimeUpdate(Principal principal) {
		usersService.setLastTimeUpdate(principal.getName());
	}
	
	@ResponseBody
	@PostMapping("/users/lastTime") 
	public String LastTime(Principal principal) {
		return usersService.getLastTime(principal.getName());
	}
}