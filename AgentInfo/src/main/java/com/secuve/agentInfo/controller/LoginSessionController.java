package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.vo.LoginSession;

@Controller
public class LoginSessionController {
	@Autowired private SessionRegistry sessionRegistry;
	@Autowired FavoritePageService favoritePageService;
	
	public void setSessionRegistry(SessionRegistry sessionRegistry) {
		this.sessionRegistry = sessionRegistry;
	}

	public SessionRegistry getSessionRegistry() {
		return sessionRegistry;
	}
	
	/**
	 * 접속 세션 목록 이동
	 * @return
	 */
	@GetMapping(value = "/loginSession/list")
	public String getAdminSessionListGet(Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "접속 세션 목록");
		return "/loginSession/LoginSessionList";
	}
	
	/**
	 * 세션 레지스트리에 기록되고 있는 세션목록 출력
	 * @param model
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/loginSession")
	public Object getAdminSessionListPost(Model model)
	{
		List<LoginSession> sessionList = new ArrayList<LoginSession>();
		for(Object principal : getSessionRegistry().getAllPrincipals())
		{
			// 로그인 계정 별 세션 목록 (false 만료된 세션은 제외)
			for(SessionInformation sinfo : getSessionRegistry().getAllSessions(principal, false))
			{
				LoginSession user = (LoginSession)sinfo.getPrincipal();
				user.setSessionId(sinfo.getSessionId());

				// 계정 마지막 접근 시간 (사용 개념. 접속 시간이 아님. 마지막 접근한 URL은 알 수 없음)
				// 마지막 접근 URL은 AOP로 분리
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:dd");
				String lastRequestTime = df.format(sinfo.getLastRequest());
				user.setLastRequestTime(lastRequestTime);

				sessionList.add(user);
			}
		}

		return sessionList;
	}
	
	/**
	 * 세션 종료
	 * @param sessionId
	 * @param model
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/loginSession/killSession")
	public Object killSession(@RequestParam("sessionId") String sessionId, Model model) {
		String result = "";

		SessionInformation sinfo = getSessionRegistry().getSessionInformation(sessionId);
		if ( sinfo != null ) {
			sinfo.expireNow();
			result = "OK";
		} else {
			result = "ERROR : It Does Not Exist(" + sessionId + ")";
		}

		Map<String, String> map = new HashMap<String, String>();
		map.put("result", result);
		return map;
	}
}
