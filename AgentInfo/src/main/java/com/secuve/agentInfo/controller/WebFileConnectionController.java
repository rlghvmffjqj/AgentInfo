package com.secuve.agentInfo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;
import com.secuve.agentInfo.vo.WebFileConnection;

@Controller
public class WebFileConnectionController {
	@GetMapping(value = "/webFileConnection/write")
	public String WebControlWrite() {
		return "webFileConnection/WebFileConnection";
	}
	
	@ResponseBody
	@PostMapping(value = "/webFileConnection/connectTest")
	public String Connect(WebFileConnection webFileConnection) {
		 try {
	            JSch jsch = new JSch();
	            Session session = jsch.getSession(webFileConnection.getConnectUser(), webFileConnection.getConnectIp(), 22);
	            session.setPassword(webFileConnection.getConnectPasswd());
	            session.setConfig("StrictHostKeyChecking", "no");
	            session.connect(2000);  // 타임아웃 30초 설정

	            if (session.isConnected()) {
	                session.disconnect();
	                return "OK";
	            } else {
	                return "FALSE";
	            }
	        } catch (Exception e) {
	            return "FALSE";
	        }
	}
}
