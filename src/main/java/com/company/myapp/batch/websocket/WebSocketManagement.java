package com.company.myapp.batch.websocket;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.springframework.stereotype.Service;

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
	
	public static List<String> managementLog = new ArrayList<>();
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<>());

	/**
	 * 메세지 수신  
	 * @param message 
	 * @param session
	 */
	@OnMessage
	public void onMessage(String message){
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
	
	/**
	 * 받은 문자 로그 형식으로 웹소켓 전송 
	 * @param level 레벨
	 * @param message 메시지
	 */
	public void sendLog(String level, String message) {
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		String msg = timestamp + " " + level + " : " + message;
		managementLog.add(msg+"\r\n");
		onMessage(msg);
	}
}
