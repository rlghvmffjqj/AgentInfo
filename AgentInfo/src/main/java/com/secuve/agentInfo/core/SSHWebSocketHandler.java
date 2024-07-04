package com.secuve.agentInfo.core;

import com.jcraft.jsch.ChannelExec;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class SSHWebSocketHandler extends TextWebSocketHandler {

    private Map<String, Session> sshSessions = new HashMap<>();
    private Map<String, ChannelExec> sshChannels = new HashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        // 클라이언트 연결 시 고유한 connectionId를 생성하여 맵에 추가
        String connectionId = UUID.randomUUID().toString();
        sshSessions.put(connectionId, null); // 초기에는 세션을 추가하지 않음
        sshChannels.put(connectionId, null); // 초기에는 채널을 추가하지 않음
        session.getAttributes().put("connectionId", connectionId);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String[] parts = message.getPayload().split(",");
        String host = parts[0];
        int port = Integer.parseInt(parts[1]);
        String user = parts[2];
        String password = parts[3];
        String filePath = parts[4];
        String connectionId = (String) session.getAttributes().get("connectionId");

        // 기존에 SSH 세션이 존재할 경우 연결 종료
        if (sshSessions.containsKey(connectionId) && sshSessions.get(connectionId) != null && sshSessions.get(connectionId).isConnected()) {
            sshSessions.get(connectionId).disconnect();
        }
        
        // 기존에 SSH 채널이 존재할 경우 연결 종료
        if (sshChannels.containsKey(connectionId) && sshChannels.get(connectionId) != null && sshChannels.get(connectionId).isConnected()) {
            sshChannels.get(connectionId).disconnect();
        }

        // SSH 세션 생성 및 명령 실행
        JSch jsch = new JSch();
        Session sshSession = jsch.getSession(user, host, port);
        sshSession.setPassword(password);
        sshSession.setConfig("StrictHostKeyChecking", "no");
        sshSession.connect();

        ChannelExec channel = (ChannelExec) sshSession.openChannel("exec");
        channel.setCommand("tail -f " + filePath);
        channel.setErrStream(System.err);

        InputStream in = channel.getInputStream();
        channel.connect();

        BufferedReader reader = new BufferedReader(new InputStreamReader(in));
        String line;
        int numLine = 1;

        while ((line = reader.readLine()) != null) {
            session.sendMessage(new TextMessage("<span style='width: 45px; float: inline-start;'>"+numLine + " : </span>" + line.replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;").replaceAll("\\s+", "&nbsp;")));
            numLine++;

        }

        // SSH 세션을 맵에 저장
        sshSessions.put(connectionId, sshSession);
        sshChannels.put(connectionId, channel);
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String connectionId = (String) session.getAttributes().get("connectionId");
        
        System.out.println("Connection closed for connectionId: " + connectionId);
        
        // 연결이 종료된 경우 SSH 세션을 해제
        if (sshSessions.containsKey(connectionId) && sshSessions.get(connectionId) != null && sshSessions.get(connectionId).isConnected()) {
            sshSessions.get(connectionId).disconnect();
        }

        // 연결이 종료된 경우 SSH 채널을 해제
        if (sshChannels.containsKey(connectionId) && sshChannels.get(connectionId) != null && sshChannels.get(connectionId).isConnected()) {
            sshChannels.get(connectionId).disconnect();
        }

        // 맵에서 해당 connectionId 제거
        sshSessions.remove(connectionId);
        sshChannels.remove(connectionId);
    }
}
