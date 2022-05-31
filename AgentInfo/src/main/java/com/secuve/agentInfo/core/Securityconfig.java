package com.secuve.agentInfo.core;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
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
			.antMatchers("/department/**").hasAnyRole("ADMIN")
			.antMatchers("/category/**").hasAnyRole("ADMIN")
			.antMatchers("/uidLog/**").hasAnyRole("ADMIN")
			.antMatchers("/packages/**").hasAnyRole("ADMIN","MEMBER","ENGINEER")
			.antMatchers("/customer/**").hasAnyRole("ADMIN","MEMBER","ENGINEER")
			.antMatchers("/index").hasAnyRole("MEMBER","ADMIN","ENGINEER")
			.antMatchers("/releaseNotes/**").hasAnyRole("ADMIN","ENGINEER")
			.antMatchers("/generalPackage/**").hasAnyRole("ADMIN","ENGINEER")
			.antMatchers("/customPackage/**").hasAnyRole("ADMIN","ENGINEER")
			.antMatchers("/trash/**").hasAnyRole("ADMIN")
			.antMatchers("/requests/**").hasAnyRole("ADMIN")
			.antMatchers("/requestsWrite/**").hasAnyRole("ADMIN","MEMBER","ENGINEER")
			.antMatchers("/").hasAnyRole("MEMBER","ADMIN","ENGINEER");
		
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
			.invalidateHttpSession(true)
			.deleteCookies("JSESSIONID")
			.permitAll();
		
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
