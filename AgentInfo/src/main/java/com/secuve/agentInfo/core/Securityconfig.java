package com.secuve.agentInfo.core;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
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
			.antMatchers("/employee/loginSession").hasAnyRole("ADMIN","MEMBER","ENGINEER","QA","ENGINEERLEADER","SALES")
			.antMatchers("/employee/**").hasAnyRole("ADMIN")
			.antMatchers("/department/**").hasAnyRole("ADMIN")
			.antMatchers("/category/**").hasAnyRole("ADMIN","LICENSE")
			.antMatchers("/packageUidLog/**").hasAnyRole("ADMIN")
			.antMatchers("/customerUidLog/**").hasAnyRole("ADMIN")
			.antMatchers("/packages/**").hasAnyRole("ADMIN","MEMBER","ENGINEER","QA","LICENSE","ENGINEERLEADER","SALES")
			.antMatchers("/customer/**").hasAnyRole("ADMIN","MEMBER","ENGINEER","QA","ENGINEERLEADER","SALES")
			.antMatchers("/product/**").hasAnyRole("ADMIN","MEMBER","ENGINEER","QA","ENGINEERLEADER","SALES")
			.antMatchers("/index").hasAnyRole("MEMBER","ADMIN","ENGINEER","QA","LICENSE","ENGINEERLEADER","SALES")
			.antMatchers("/releaseNotes/**").hasAnyRole("ADMIN","ENGINEER","QA","ENGINEERLEADER","SALES")
			.antMatchers("/generalPackage/**").hasAnyRole("ADMIN","ENGINEER","QA","ENGINEERLEADER","SALES")
			.antMatchers("/customPackage/**").hasAnyRole("ADMIN","ENGINEER","QA","ENGINEERLEADER","SALES")
			.antMatchers("/trash/**").hasAnyRole("ADMIN")
			.antMatchers("/requests/**").hasAnyRole("ADMIN","MEMBER","ENGINEER","QA","LICENSE","ENGINEERLEADER","SALES")
			.antMatchers("/requestsWrite/**").hasAnyRole("ADMIN","MEMBER","ENGINEER","QA","LICENSE","ENGINEERLEADER","SALES")
			.antMatchers("/customerInfo/**").hasAnyRole("ADMIN","MEMBER","ENGINEER","QA","ENGINEERLEADER","SALES")
			.antMatchers("/loginSession/**").hasAnyRole("ADMIN")
			.antMatchers("/employeeUidLog/**").hasAnyRole("ADMIN")
			.antMatchers("/schedule/**").hasAnyRole("ADMIN")
			.antMatchers("/license/**").hasAnyRole("ADMIN","LICENSE")
			.antMatchers("/license5/**").hasAnyRole("ADMIN","LICENSE")
			.antMatchers("/licenseUidLog/**").hasAnyRole("ADMIN","LICENSE")
			.antMatchers("/license5UidLog/**").hasAnyRole("ADMIN","LICENSE")
			.antMatchers("/serverList/**").hasAnyRole("ADMIN","QA")
			.antMatchers("/serverListUidLog/**").hasAnyRole("ADMIN","QA")
			.antMatchers("/issue/**").hasAnyRole("ADMIN","QA")
			.antMatchers("/individualNote/**").hasAnyRole("ADMIN","MEMBER","ENGINEER","QA","LICENSE","ENGINEERLEADER","SALES")
			.antMatchers("/individualNoteTree/**").hasAnyRole("ADMIN","MEMBER","ENGINEER","QA","LICENSE","ENGINEERLEADER","SALES")
			.antMatchers("/sharedNote/**").hasAnyRole("ADMIN","MEMBER","ENGINEER","QA","LICENSE","ENGINEERLEADER","SALES")
			.antMatchers("/sharedNoteTree/**").hasAnyRole("ADMIN","MEMBER","ENGINEER","QA","LICENSE","ENGINEERLEADER","SALES")
			.antMatchers("/calendar/**").hasAnyRole("ADMIN","MEMBER","ENGINEER","QA","LICENSE","ENGINEERLEADER","SALES")
			.antMatchers("/sharedCalendar/**").hasAnyRole("ADMIN","MEMBER","ENGINEER","QA","LICENSE","ENGINEERLEADER","SALES")
			.antMatchers("/serverCalendar/**").hasAnyRole("ADMIN","QA","LICENSE")
			.antMatchers("/sendPackage/**").hasAnyRole("ADMIN")
			.antMatchers("/customerLicense/**").hasAnyRole("ADMIN","MEMBER","LICENSE")
			.antMatchers("/functionTestSetting/**").hasAnyRole("ADMIN","QA")
			.antMatchers("/checkListSetting/**").hasAnyRole("ADMIN","QA")
			.antMatchers("/functionTest/**").hasAnyRole("ADMIN","QA")
			.antMatchers("/checkList/**").hasAnyRole("ADMIN","QA")
			.antMatchers("/testCase/**").hasAnyRole("ADMIN","QA")
			.antMatchers("/customerConsolidation/**").hasAnyRole("ADMIN","ENGINEER","LICENSE","ENGINEERLEADER","SALES")
			.antMatchers("/question/**").hasAnyRole("ADMIN","MEMBER","ENGINEER","QA","LICENSE","ENGINEERLEADER","SALES")
			.antMatchers("/questionAnswer/**").hasAnyRole("ADMIN","MEMBER","ENGINEER","QA","LICENSE","ENGINEERLEADER","SALES")
			.antMatchers("/packageAnalysis/**").hasAnyRole("ADMIN","QA")
			.antMatchers("/").hasAnyRole("MEMBER","ADMIN","ENGINEER","QA","LICENSE","ENGINEERLEADER","SALES");
		
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
		
		http.sessionManagement()
	     .maximumSessions(1)	// 동시 접속 가능 세션수
	     .expiredUrl("/duplicateLogin")	// 세션 만료 시 이동 URL
	     .maxSessionsPreventsLogin(false);	// false 일경우 기존 로그인 로그 아웃 후 새로그인
	}
	
	@Bean 
	public BCryptPasswordEncoder bCryptPasswordEncoder() { 
		return new BCryptPasswordEncoder(); 
	}
	
	@Bean
	public SessionRegistry sessionRegistry() {
	  SessionRegistry sessionRegistry = new SessionRegistryImpl();
	  return sessionRegistry;
	}
	
}