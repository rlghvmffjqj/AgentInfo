package com.secuve.agentInfo.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.core.Role;
import com.secuve.agentInfo.dao.EmployeeDao;
import com.secuve.agentInfo.dao.UsersJpaDao;
import com.secuve.agentInfo.vo.Users;

@Service
public class UsersService implements UserDetailsService{
	@Autowired UsersJpaDao usersJpaDao;
	@Autowired HttpSession session;
	@Autowired EmployeeDao employeeDao;
	
	@Override
	public UserDetails loadUserByUsername(String usersId) throws UsernameNotFoundException {
		Optional<Users> usersEntityWrapper = usersJpaDao.findByUsersId(usersId);
		Users usersEntity = usersEntityWrapper.orElse(null);
		
		List<GrantedAuthority> authorities =new ArrayList<>();
		
		if (usersEntity.getUsersRole().equals("ADMIN")) {
			authorities.add(new SimpleGrantedAuthority(Role.ADMIN.getValue()));
			session.setAttribute("usersId", "admin");
		} else if(usersEntity.getUsersRole().equals("ENGINEER")) {
			authorities.add(new SimpleGrantedAuthority(Role.ENGINEER.getValue()));
			session.setAttribute("usersId", "engineer");
		}else {
			authorities.add(new SimpleGrantedAuthority(Role.MEMBER.getValue()));
			session.setAttribute("usersId", "users");
		}
		return new User(usersEntity.getUsersId(), usersEntity.getUsersPw(), authorities);
	}
	
	@Transactional
	public String save(Users users) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		users.setUsersPw(passwordEncoder.encode(users.getUsersPw()));
		String result = usersJpaDao.save(users).getUsersId();
		if(result.isEmpty()) {
			return "FALSE";
		}
		return "OK";
	}

	public String updateUsersPwd(String oldPwd, String changePwd, String confirmPwd, String usersId) {
		if(oldPwd == null && changePwd == null && confirmPwd == null) { // 암호 변경 후 로그인 시 최근 접속 경로를 한번 경유하는 걸로 예상 에러 컴파일 제거 용도로 추가
			return "login";
		}
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String nowPwd = employeeDao.getUsersPw(usersId);
		if(oldPwd.length() <= 0) {
			return "NotOldPwd";
		}
		if(changePwd.length() <= 0) {
			return "NotChangePwd";
		}
		if(confirmPwd.length() <= 0) {
			return "NotConfirmPwd";
		}
		if(!passwordEncoder.matches(oldPwd,nowPwd)) {
			return "NotPassword";
		}
		if(!changePwd.equals(confirmPwd)) {
			return "PwdMisMatch";
		}
		if(changePwd.length() < 8) {
			return "PwdMinLength";
		}
		
		changePwd = passwordEncoder.encode(changePwd);
		int count = employeeDao.updateUserPwd(usersId, changePwd);
		if(count > 0) 
			return "OK";
		return "FALSE";
		
	}

	public String loginIdPwd(String usersId, String usersPw) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String nowPwd = employeeDao.getUsersPw(usersId);
		if(passwordEncoder.matches(usersPw,nowPwd)) {
			return employeeDao.pwdCheck(usersId);
		}
		return "FALSE";
	}

}
