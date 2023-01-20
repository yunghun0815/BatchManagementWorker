package com.company.myapp.batch.activeMQ;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.support.converter.MessageConversionException;
import org.springframework.jms.support.converter.MessageConverter;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.ObjectMapper;

@Component
public class JsonMessageConverter implements MessageConverter{
	
	@Autowired
    private ObjectMapper mapper;
	
	@Override
	public Message toMessage(Object object, Session session) throws JMSException, MessageConversionException {
		String json;

        try {
            json = mapper.writeValueAsString(object);
        } catch (Exception e) {
            throw new MessageConversionException("Message cannot be parsed. ", e);
        }

        TextMessage message = session.createTextMessage();
        message.setText(json);

        return message;
	}

	@Override
	public Object fromMessage(Message message) throws JMSException, MessageConversionException {
		
		  return ((TextMessage) message).getText();
	}

}
