package com.company.myapp.batch.activeMQ;

import org.springframework.jms.annotation.JmsListener;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class Receiver {
	
	@JmsListener(destination = "hoon")
	public void receiveMessage(String email) {
		log.info("[Agent 로그] {}", email);
	}
}
