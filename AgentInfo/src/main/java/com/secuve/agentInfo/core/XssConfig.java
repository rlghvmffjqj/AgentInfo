package com.secuve.agentInfo.core;

import java.util.ArrayList;
import java.util.List;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.navercorp.lucy.security.xss.servletfilter.XssEscapeServletFilter;

/**
 * XSS 공격 예방 ISSUE 패이지의 경우 이미지를 저장하기 때문에 제외
 * @author JiEx
 *
 */
@Configuration
public class XssConfig implements WebMvcConfigurer {
	@Bean
	public FilterRegistrationBean<XssEscapeServletFilter> filterRegistrationBean() {
		FilterRegistrationBean<XssEscapeServletFilter> filterRegistration = new FilterRegistrationBean<>();
		filterRegistration.setFilter(new XssEscapeServletFilter());
		filterRegistration.setOrder(1);
		//filterRegistration.addUrlPatterns("/*");
		List<String> urls = new ArrayList<>();
		urls.add("/packages/*");
		urls.add("/license/*");
		urls.add("/serverList/*");
		urls.add("/generalPackage/*");
		urls.add("/customPackage/*");
		urls.add("/employee/*");
		urls.add("/category/*");
		urls.add("/requests/*");
		urls.add("/requestsWrite/*");
		urls.add("/sharedCalendar/*");
		urls.add("/calendar/*");
		urls.add("/sharedCalendar/*");
		urls.add("/serverCalendar/*");
		filterRegistration.setUrlPatterns(urls);
		return filterRegistration;
	}
	
}
