package com.company.myapp.batch.activeMQ.config;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.support.converter.MessageConversionException;
import org.springframework.jms.support.converter.MessageConverter;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * from, to 메세시 변환 설정
 * @author 정영훈
 *
 */
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
            throw new MessageConversionException("메세지 변환 실패", e);
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
