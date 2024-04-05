package com.secuve.agentInfo.core;


import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.stereotype.Component;

import com.secuve.agentInfo.AgentInfoApplication;
import com.secuve.agentInfo.vo.LoginSession;

@Aspect
@Component
public class AopAfter {
	@Autowired HttpServletRequest request;
	@Autowired private SessionRegistry sessionRegistry;
	private static final Logger LOGGER = LogManager.getLogger(AgentInfoApplication.class);
	
	public void setSessionRegistry(SessionRegistry sessionRegistry) {
		this.sessionRegistry = sessionRegistry;
	}

	public SessionRegistry getSessionRegistry() {
		return sessionRegistry;
	}
	
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
		HttpServletRequest httpRequest = (HttpServletRequest) request;
        String sessionId = httpRequest.getSession().getId();
        String ipAddress = httpRequest.getRemoteAddr();
		for(Object principal : getSessionRegistry().getAllPrincipals())
		{
			// 로그인 계정 별 세션 목록 (false 만료된 세션은 제외)
			for(SessionInformation sinfo : getSessionRegistry().getAllSessions(principal, false))
			{
				LoginSession loginSession = (LoginSession) sinfo.getPrincipal();
				if(sessionId.equals(sinfo.getSessionId())) {
					if(!ipAddress.equals(loginSession.getLoginIp())) {
						LOGGER.info("================= JSSIONID 공격 =================");
						LOGGER.info("JSSIONID : "+ sessionId);
						LOGGER.info("IPADDRES : "+ ipAddress);
						LOGGER.info("===============================================");
						throw new RuntimeException("Session is not valid.");
					}
				}
			}
		}
		
		LoginSession loginUser = getUser();
		if(loginUser != null) // 로그인 전 사용자 정보가 없을 경우
			loginUser.setLastRequestURL(request.getRequestURL().toString());
	}
	
	public LoginSession getUser() {
		return LoginSession.getLoginUser();
	}
}