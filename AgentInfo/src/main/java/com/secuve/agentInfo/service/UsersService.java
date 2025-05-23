package com.secuve.agentInfo.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.core.Role;
import com.secuve.agentInfo.dao.EmployeeDao;
import com.secuve.agentInfo.dao.UsersJpaDao;
import com.secuve.agentInfo.vo.LoginSession;
import com.secuve.agentInfo.vo.UserAlarm;
import com.secuve.agentInfo.vo.Users;

@Service
public class UsersService implements UserDetailsService{
	@Autowired UsersJpaDao usersJpaDao;
	@Autowired HttpSession session;
	@Autowired EmployeeDao employeeDao;
	@Autowired HttpServletRequest request;
	@Autowired EmployeeUidLogService employeeUidLogService;
	
	boolean enabled = true;
    boolean accountNonExpired = true;
    boolean credentialsNonExpired = true;
    boolean accountNonLocked = true;
	
	@Override
	public UserDetails loadUserByUsername(String usersId) throws UsernameNotFoundException {
		Optional<Users> usersEntityWrapper = usersJpaDao.findByUsersId(usersId);
		Users usersEntity = usersEntityWrapper.orElse(null);
		
		List<GrantedAuthority> authorities =new ArrayList<>();
		
		// 권한 세션 저장
		if (usersEntity.getUsersRole().equals("ADMIN")) {
			authorities.add(new SimpleGrantedAuthority(Role.ADMIN.getValue()));
			session.setAttribute("usersId", "admin");
		} else if(usersEntity.getUsersRole().equals("ENGINEER")) {
			authorities.add(new SimpleGrantedAuthority(Role.ENGINEER.getValue()));
			session.setAttribute("usersId", "engineer");
		} else if(usersEntity.getUsersRole().equals("QA")) {
			authorities.add(new SimpleGrantedAuthority(Role.QA.getValue()));
			session.setAttribute("usersId", "qa");
		} else if(usersEntity.getUsersRole().equals("LICENSE")) {
			authorities.add(new SimpleGrantedAuthority(Role.LICENSE.getValue()));
			session.setAttribute("usersId", "license");
		} else if(usersEntity.getUsersRole().equals("ENGINEERLEADER")) {
			authorities.add(new SimpleGrantedAuthority(Role.ENGINEERLEADER.getValue()));
			session.setAttribute("usersId", "engineerleader");
		} else if(usersEntity.getUsersRole().equals("SALES")) {
			authorities.add(new SimpleGrantedAuthority(Role.SALES.getValue()));
			session.setAttribute("usersId", "sales");
		} else {
			authorities.add(new SimpleGrantedAuthority(Role.MEMBER.getValue()));
			session.setAttribute("usersId", "users");
		}
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:dd");
		String loginId = usersEntity.getUsersId();
		String loginIp = request.getRemoteAddr();
		String loginTime = df.format(new Date());
		
		// 접속 세션 목록 저장을 위해 추가
		LoginSession loingSession = new LoginSession(
				usersEntity.getUsersId(),
				usersEntity.getUsersPw(), enabled, accountNonExpired, credentialsNonExpired, accountNonLocked,
				authorities, loginId, loginIp, loginTime
		);
		
		return loingSession;
		// return new User(usersEntity.getUsersId(), usersEntity.getUsersPw(), authorities);  // 기존 코드
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
		Optional<Users> usersEntityWrapper = usersJpaDao.findByUsersId(usersId);
		Users usersEntity = usersEntityWrapper.orElse(null);
		if(usersEntity.isUsersLockStatus() && usersEntity.getUsersLoginFailCount() < 5) {
			employeeUidLogService.insertEmployeeUidLog(usersEntity.getUsersId(), "LOCK FALSE");
			return "CountLock";
		} else if(usersEntity.isUsersLockStatus() && usersEntity.getUsersLoginFailCount() > 4) {
			employeeUidLogService.insertEmployeeUidLog(usersEntity.getUsersId(), "LOCK FALSE");
			return "LOCK";
		}
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String nowPwd = employeeDao.getUsersPw(usersId);
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(passwordEncoder.matches(usersPw,nowPwd)) {
			employeeDao.lastLogin(formatter.format(now), usersId);
			usersEntity.setUsersLoginFailCount(0);
			usersJpaDao.save(usersEntity);
			employeeUidLogService.insertEmployeeUidLog(usersEntity.getUsersId(), "SUCCESS");
			return employeeDao.pwdCheck(usersId);
		}
		
		if(usersEntity.getUsersLoginFailCount() > 4) {
			usersEntity.setUsersLockStatus(true);
			usersJpaDao.save(usersEntity);
			return "LOCK";
		}
		usersEntity.setUsersLoginFailCount(usersEntity.getUsersLoginFailCount() + 1);
		usersJpaDao.save(usersEntity);
		// 로그인 로그 저장
		employeeUidLogService.insertEmployeeUidLog(usersEntity.getUsersId(), "FALSE");
		return "FALSE";
	}

	public List<UserAlarm> getUserAlarm(String userAlarmEmployeeId) {
		return employeeDao.getUserAlarm(userAlarmEmployeeId);
	}

	public String lockChange(String employeeId, String type) {
		Optional<Users> usersEntityWrapper = usersJpaDao.findByUsersId(employeeId);
		Users usersEntity = usersEntityWrapper.orElse(null);
		if(type.equals("lock")) {
			usersEntity.setUsersLockStatus(true);
		} else {
			usersEntity.setUsersLockStatus(false);
			usersEntity.setUsersLoginFailCount(0);
		}
		try {
			usersJpaDao.save(usersEntity);
			return "OK";
		} catch (Exception e) {
			return "FALSE";
		}
	}

	public void setLastTimeUpdate(String usersId) {
		employeeDao.setLastTimeUpdate(usersId);
	}

	public String getLastTime(String usersId) {
		return employeeDao.getLastTime(usersId);
	}
}