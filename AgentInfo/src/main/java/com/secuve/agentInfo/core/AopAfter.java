package com.secuve.agentInfo.core;


import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.secuve.agentInfo.vo.LoginSession;

@Aspect
@Component
public class AopAfter {
	@Autowired HttpServletRequest request;
	
	/**
	 * 컨트롤러 실행 시 동작
	 */
	@Pointcut("execution(public * com.secuve.agentInfo.controller.*.*(..))")
    private void multiplyTarget() { }
	
	/**
	 * @Pointcut 위치 동작 후 작업
	 * @param joinPoint
	 */
	@After("multiplyTarget()")
    public void calcPerformanceAdvice(JoinPoint joinPoint) {
		LoginSession loginUser = getUser();
		if(loginUser != null) // 로그인 전 사용자 정보가 없을 경우
			loginUser.setLastRequestURL(request.getRequestURL().toString());
	}
	
	public LoginSession getUser() {
		return LoginSession.getLoginUser();
	}
}