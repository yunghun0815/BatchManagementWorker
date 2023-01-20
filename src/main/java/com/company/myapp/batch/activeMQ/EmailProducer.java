package com.company.myapp.batch.activeMQ;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.stereotype.Service;

@Service
public class EmailProducer {

	@Autowired
	private JmsTemplate jmsTemplate;
	
	public void sendMsg(String email, String to) {
		
		jmsTemplate.convertAndSend("hoon", new Email(email, to));
	}
}
