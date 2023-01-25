package com.company.myapp.batch.activeMQ;

import org.springframework.jms.annotation.JmsListener;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class Consumer {
	
	@JmsListener(destination = "hoon")
	public void receiveMessage(String message) {
		log.info("[Agent 로그] {}", message);
	}
}
