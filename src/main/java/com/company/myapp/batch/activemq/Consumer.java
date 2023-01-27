package com.company.myapp.batch.activemq;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.annotation.JmsListener;
import org.springframework.stereotype.Component;

import com.company.myapp.batch.websocket.WebSocketAgent;

import lombok.extern.slf4j.Slf4j;

/**
 * 메시지큐 응답객체
 * @author 정영훈
 *
 */
@Slf4j
@Component
public class Consumer {

	@Autowired
	WebSocketAgent agent;
	
	@JmsListener(destination = "agent")
	public void receiveMessage(String message) {
		
		WebSocketAgent.agentLog.add(message);
		agent.onMessage(message);
	}
	
}
