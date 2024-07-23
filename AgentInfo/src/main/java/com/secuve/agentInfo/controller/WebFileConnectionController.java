package com.secuve.agentInfo.controller;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.nio.file.Paths;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;
import com.secuve.agentInfo.vo.WebFileConnection;

import com.hierynomus.smbj.SMBClient;
import com.hierynomus.smbj.auth.AuthenticationContext;
import com.hierynomus.smbj.connection.Connection;

@Controller
public class WebFileConnectionController {
	@GetMapping(value = "/webFileConnection/write")
	public String WebControlWrite() {
		return "webFileConnection/WebFileConnection";
	}
	
	@ResponseBody
	@PostMapping(value = "/webFileConnection/connectTest")
	public String Connect(WebFileConnection webFileConnection) {
		JSch jsch = new JSch();
        Session session = null;
		 try {
	         session = jsch.getSession(webFileConnection.getConnectUser(), webFileConnection.getConnectIp(), 22);
	         session.setPassword(webFileConnection.getConnectPasswd());
	         session.setConfig("StrictHostKeyChecking", "no");
	         session.connect(2000);  // 타임아웃 30초 설정

	         if (session.isConnected()) {
	             return "OK";
	         } else {
	             return "FALSE";
	         }
	     } catch (Exception e) {
	         //e.printStackTrace();
	         return "FALSE";
	     } finally {
	         if (session != null && session.isConnected()) {
	             session.disconnect();
	         }
	     }
	}
	
	@ResponseBody
	@PostMapping(value = "/webFileConnection/connectTestWin")
	public String ConnectWin(WebFileConnection webFileConnection) {
		String host = webFileConnection.getConnectIp();
        String user = webFileConnection.getConnectUser();
        String password = webFileConnection.getConnectPasswd();

        SMBClient client = null;
        Connection connection = null;
        com.hierynomus.smbj.session.Session session = null;

        try {
            client = new SMBClient();
            connection = client.connect(host);
            AuthenticationContext authContext = new AuthenticationContext(user, password.toCharArray(), null);
            session = connection.authenticate(authContext);
            // 인증이 성공하면 "OK"를 반환
            return "OK";
        } catch (Exception e) {
            //e.printStackTrace(); // 로그에 예외 메시지를 기록
            return "FALSE";
        } finally {
        	// 자원 해제
            if (session != null) {
                try {
                    session.close();
                } catch (Exception e) {
                    e.printStackTrace(); // 세션 닫기에서 발생한 예외 로그
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace(); // 연결 닫기에서 발생한 예외 로그
                }
            }
            if (client != null) {
                try {
                    client.close();
                } catch (Exception e) {
                    e.printStackTrace(); // 클라이언트 닫기에서 발생한 예외 로그
                }
            }
        }
	}

}
