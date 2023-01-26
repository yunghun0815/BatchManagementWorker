package com.company.myapp.batch.websocket;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.springframework.stereotype.Service;

import com.company.myapp.service.impl.JobService;

import lombok.extern.slf4j.Slf4j;

/**
 * 관리서버 로그 전송 웹소켓 생성
 * @author 정영훈
 *
 */
@Slf4j
@Service
@ServerEndpoint(value = "/ws/management")
public class WebSocketManagement {
	
	public static StringBuilder managementLog = new StringBuilder();
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<>());

	/**
	 * 메세지 수신  
	 * @param message 
	 * @param session
	 */
	@OnMessage
	public void onMessage(String message){
		managementLog.append(message);
		try {
			for(Session s : clients) {
				s.getBasicRemote().sendText(message);
			}
		} catch(Exception e) {
			log.error("[WebSocket Error] " + e.getMessage());
		}
	}
	
	/**
	 * 클라이언트 접속 이벤트
	 * @param session
	 */
	@OnOpen
	public void onOpen(Session session) {
		if(!clients.contains(session)) clients.add(session);
	}
	
	/**
	 * 브러우저 종료 또는 경로 이동
	 * @param session
	 */
	@OnClose
	public void onClose(Session session) {
		clients.remove(session);
	}
	
	public void sendLog(String level, String message) {
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		String msg = timestamp + " " + level + " : " + message;
		
		onMessage(msg);
	}
}
