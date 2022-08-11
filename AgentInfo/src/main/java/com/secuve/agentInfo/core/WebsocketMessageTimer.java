package com.secuve.agentInfo.core;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class WebsocketMessageTimer implements Runnable {

	@Autowired
	private ChatHandler chatHandler;
	
	public WebsocketMessageTimer() {
		new Thread(this).start();
	}
	
	@Override
	public void run() {
		//while(!Thread.currentThread().isInterrupted()) {
		//	System.out.println("say hello to browser");
		//	if(chatHandler != null) {
		//		chatHandler.push("hello");
		//		System.out.println("push complete");
		//	}
		//	
		//	try {Thread.sleep(3000);} catch (InterruptedException e) {}
		//}
		
	}

}
