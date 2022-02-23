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
import com.secuve.agentInfo.dao.UsersJpaDao;
import com.secuve.agentInfo.vo.Users;

@Service
public class UsersService implements UserDetailsService{
    
    
	@Autowired UsersJpaDao usersJpaDao;
	@Autowired HttpSession session;
	
	
	@Override
	public UserDetails loadUserByUsername(String usersId) throws UsernameNotFoundException {
		Optional<Users> usersEntityWrapper = usersJpaDao.findByUsersId(usersId);
		Users usersEntity = usersEntityWrapper.orElse(null);
		
		List<GrantedAuthority> authorities =new ArrayList<>();
		
		if (usersEntity.getUsersRole().equals("ADMIN")) {
			authorities.add(new SimpleGrantedAuthority(Role.ADMIN.getValue()));
			session.setAttribute("usersId", "admin");
		} else {
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
	

}
