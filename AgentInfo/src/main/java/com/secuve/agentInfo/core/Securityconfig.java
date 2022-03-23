package com.secuve.agentInfo.core;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(securedEnabled = true)
public class Securityconfig extends WebSecurityConfigurerAdapter{
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		
		// 접속 권한
		http.authorizeRequests()
			.antMatchers("/employee/**").hasAnyRole("ADMIN")
			.antMatchers("/category/**").hasAnyRole("ADMIN")
			.antMatchers("/uidLog/**").hasAnyRole("ADMIN")
			.antMatchers("/packages/**").hasAnyRole("ADMIN","MEMBER")
			.antMatchers("/index").hasAnyRole("MEMBER","ADMIN")
			.antMatchers("/").hasAnyRole("MEMBER","ADMIN");
		
		// 로그인 설정
		http.formLogin()
			.loginPage("/login")
			.usernameParameter("usersId")
			.passwordParameter("usersPw")
			.defaultSuccessUrl("/index")
			.failureUrl("/loginFail")
			.permitAll();
		
		// 로그아웃 설정
		http.logout()
			.logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
			.logoutSuccessUrl("/login")
			.invalidateHttpSession(true);
		
		// 권한이 없는 사용자가 접속한 경우
		http.exceptionHandling()
			.accessDeniedPage("/denied");
		
		http.headers().frameOptions().sameOrigin();
		
		http.csrf().disable();
	}
	
	@Bean 
	public BCryptPasswordEncoder bCryptPasswordEncoder() { 
		return new BCryptPasswordEncoder(); 
	}
	
}
