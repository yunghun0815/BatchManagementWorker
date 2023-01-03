package com.company.myapp.batch;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.company.myapp.dto.BatGrpLog;
import com.company.myapp.dto.BatPrmLog;
import com.company.myapp.dto.Host;
import com.company.myapp.service.ILogService;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
/**
 * 1. 스레드풀, 서버소켓 관리
 * 2. Agent 서버 통신 및 메시지 교환
 * @author 정영훈, 김나영
 *
 */
@Slf4j
@Component
public class BatchServer {
	
	@Autowired
	ILogService logService;
	
	Socket socket;
	ServerSocket serverSocket;
	ExecutorService threadPool;
	
	/**
	 * 스레드풀, 서버소켓 생성 및 연결 수락 
	 * @throws IOException
	 */
	public void start() throws IOException {
		log.info("[서버] 시작");
		
		// 스레드풀 생성
		threadPool = Executors.newFixedThreadPool(10);
		
		// 서버소켓 생성 및 포트 바인딩
		serverSocket = new ServerSocket(50000);
		
		// 작업 스레드 생성
		threadPool.execute(new Runnable() {
			
			@Override
			public void run() {
				while(true) {
					try {
						// 연결 수락 및 메세지 처리 메소드 호출
						Socket socket = serverSocket.accept();
						receiveMessage(socket);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		});
	}
	
	/**
	 * 스레드풀 종료, 서버소켓 닫음
	 * @throws IOException
	 */
	public void shutDown() throws IOException {
		log.info("[서버] 종료");
		threadPool.shutdown();
		serverSocket.close();
	}
	
	/**
	 * Agent 서버 연결 및 Json 데이터 전송
	 * @param host 아이피, 포트
	 * @param json 넘길 json 형식 객체 
	 */
	public void sendMessage(Host host, JSONObject json) {
		try {
			// 소켓 생성 및 Agent 서버 연결 요청
			Socket socket = new Socket(host.getHostIp(), host.getHostPt());
			DataOutputStream dos = new DataOutputStream(socket.getOutputStream());
			
			// Agent 서버로 jsonString 전송
			dos.writeUTF(json.toString());
			dos.flush();
			dos.close();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Agent 서버에서 넘어온 데이터 파싱 및 로그 저장
	 * @param socket
	 */
	public void receiveMessage(Socket socket) {
		threadPool.execute(new Runnable() {
			
			@Override
			public void run() {
				try {
					DataInputStream dis = new DataInputStream(socket.getInputStream());
					
					// Agent 서버에서 넘어온 결과 DTO에 저장
					String data = dis.readUTF();
					JSONObject json = new JSONObject(data);
					ObjectMapper mapper = new ObjectMapper();
					BatPrmLog batPrmLog = mapper.readValue(data, BatPrmLog.class);
					
					// 프로그램 로그 DB에 저장
					logService.updateBatPrmLog(batPrmLog);
					
					//List<BatPrmLog> log = mapper.readValue(data, new TypeReference<List<BatPrmLog>>() {});
					
					// 마지막 순번일 경우 그룹 로그 업데이트
					if(json.get("last").equals("Y")) {
						
						// 받은 결과가 속한 그룹 로그 선언
						BatGrpLog batGrpLog = logService.getBatGrpLogDetail(batPrmLog.getBatGrpLogId(), batPrmLog.getBatGrpRtyCnt());
						
						// 그룹 로그의 상태코드, 배치 종료 일자를 업데이트
						batGrpLog.setBatGrpStCd(batPrmLog.getBatPrmStCd());
						batGrpLog.setBatEndDt(batPrmLog.getBatEndDt());
						logService.updateBatGrpLog(batGrpLog);
					}

					dis.close();
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		});
	}
}
