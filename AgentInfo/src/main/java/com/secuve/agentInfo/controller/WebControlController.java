package com.secuve.agentInfo.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jcraft.jsch.ChannelExec;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;
import com.secuve.agentInfo.vo.WebControl;

@Controller
public class WebControlController {
	@GetMapping(value = "/webControl/write")
	public String WebControlWrite() {
		return "webControl/WebControl";
	}
	
	@ResponseBody
	@PostMapping(value = "/webControl/connect")
	public String Connect(WebControl webControl) {
		 try {
	            JSch jsch = new JSch();
	            Session session = jsch.getSession(webControl.getCmdUser(), webControl.getCmdIp(), 22);
	            session.setPassword(webControl.getCmdPasswd());
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
	
	@ResponseBody
	@PostMapping(value = "/webControl/excute")
	public String Excute(WebControl webControl) {
		StringBuilder output = new StringBuilder();

        try {
            JSch jsch = new JSch();
            Session session = jsch.getSession(webControl.getCmdUser(), webControl.getCmdIp(), 22);
            session.setPassword(webControl.getCmdPasswd());
            session.setConfig("StrictHostKeyChecking", "no");
            session.connect();

            ChannelExec channel = (ChannelExec) session.openChannel("exec");
            channel.setCommand(webControl.getCommand());
            channel.setErrStream(System.err);

            BufferedReader reader = new BufferedReader(new InputStreamReader(channel.getInputStream()));
            channel.connect();

            String line;
            while ((line = reader.readLine()) != null) {
            	output.append(line.replace(" ", "&nbsp;").replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;")).append("<br>");
            }

            channel.disconnect();
            session.disconnect();
        } catch (Exception e) {
            output.append("Error executing command: ").append(e.getMessage());
        }
        return output.toString();
	}
}
