package com.secuve.agentInfo.core;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer   {
//    private final ChatHandler chatHandler;
//    
//    public WebSocketConfig(ChatHandler chatHandler) {
//        this.chatHandler = chatHandler;
//    }
//
//    @Override
//    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
//        registry.addHandler(chatHandler, "/licensSocket").setAllowedOrigins("*");
//    }
	
	@Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(new SSHWebSocketHandler(), "/webFileConnection")
                .setAllowedOrigins("*");
    }
}
