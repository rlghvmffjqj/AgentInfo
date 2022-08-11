package com.secuve.agentInfo.core;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.secuve.agentInfo.service.LicenseService;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Component
public class ChatHandler extends TextWebSocketHandler {
	@Autowired LicenseService licenseService;
	
    private static List<WebSocketSession> list = new ArrayList<>();
    
    WebClient webClient = WebClient.create();
    
    public void push(String message) {
    	
    	list.forEach(session -> {
    		TextMessage tm = new TextMessage(message);
    		
    		try {
				session.sendMessage(tm);
			} catch (IOException e) {
				e.printStackTrace();
			}
    		
    	});
    	
    }
    
    
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String msg = message.getPayload();
        log.info(msg);
        
        if(msg.equals("disconnect")) {
        	
        }

        for(WebSocketSession sess: list) {
            sess.sendMessage(message);
        }
        //licenseService.tos2LinuxLicense();
        
    }
    
    /* Client가 접속 시 호출되는 메서드 */
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	log.info("WebSocket Connect!!");
        list.add(session);
    }

    /* Client가 접속 해제 시 호출되는 메서드드 */

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
    	log.info("WebSocket Disconnect!!");
        list.remove(session);
    }
}
