package com.company.myapp.batch;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.company.myapp.dto.BatGrpLog;
import com.company.myapp.dto.BatPrmLog;
import com.company.myapp.dto.Host;
import com.company.myapp.dto.JsonDto;
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
	
	JSONObject connect = new JSONObject();
	
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
				// 서버소켓이 열려있으면 실행
				if(!serverSocket.isClosed()) {
					try {
						// 연결 수락 및 메세지 처리 메소드 호출
						while(true) {
							Socket socket = serverSocket.accept();
							receiveMessage(socket);
						}
					}
					catch (Exception e) {
						log.info("[응답 에러]" + e.getMessage());
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
		serverSocket.close();
		threadPool.shutdown();
	}
	
	/**
	 * Agent 서버 연결 및 JSON 데이터 전송
	 * @param host 아이피, 포트
	 * @param json 넘길 json 형식 객체 
	 */
	public void sendMessage(Host host, List<JsonDto> jsonArray) {
		// 연결 실패시 로그 실패 처리
		BatGrpLog failGrpLog = new BatGrpLog();
		failGrpLog.setBatBgngDt(new Date());
		
		try {
			// 소켓 생성 및 Agent 서버 연결 요청
			Socket socket = new Socket(host.getHostIp(), host.getHostPt());
			DataOutputStream dos = new DataOutputStream(socket.getOutputStream());
			
			
			// cmd, message 담아 전송
			JSONObject json = new JSONObject();
			json.put("cmd", "run");
			json.put("message", jsonArray);
			String sendDataStr = json.toString();
			
			// Agent 서버로 데이터 전송 후 연결 종료
			dos.writeUTF(sendDataStr);
			dos.flush();
			dos.close();
			socket.close();
			
			
		}catch(Exception e) {
			// Agent 서버로 연결 실패시 로그 실행중 -> 실패로 업데이트
			log.info("[전송 실패] Agent서버로 메시지 전송에 실패하였습니다.");
			for(JsonDto json : jsonArray) {
				BatPrmLog batPrmLog = new BatPrmLog();
				batPrmLog.setBatPrmStCd(BatchStatusCode.FAIL.getCode());
				batPrmLog.setRsltMsg("연결 실패");
				batPrmLog.setBatGrpLogId(json.getBatGrpLogId());
				batPrmLog.setBatGrpRtyCnt(json.getBatGrpRtyCnt());
				batPrmLog.setBatPrmId(json.getBatPrmId());
				logService.updateBatPrmLog(batPrmLog);
			}
			failGrpLog.setBatGrpStCd(BatchStatusCode.FAIL.getCode());
			failGrpLog.setBatEndDt(new Date());
			failGrpLog.setBatGrpLogId(jsonArray.get(0).getBatGrpLogId());
			failGrpLog.setBatGrpRtyCnt(jsonArray.get(0).getBatGrpRtyCnt());
			logService.updateBatGrpLog(failGrpLog);
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
					log.info("데이터 받음");
					// Agent 서버에서 넘어온 결과 DTO에 저장
					String data = dis.readUTF();
					JSONObject json = new JSONObject(data);
					JSONObject message = new JSONObject(json.get("message").toString());
					if(json.get("cmd").equals("log")) {
						ObjectMapper mapper = new ObjectMapper();
						BatPrmLog batPrmLog = mapper.readValue(message.toString(), BatPrmLog.class);
						
						// 프로그램 로그 DB에 저장
						logService.updateBatPrmLog(batPrmLog);
						
						// 마지막 순번일 경우 그룹 로그 업데이트
						if(message.get("lastYn").equals("Y")) {
							
							// 받은 결과가 속한 그룹 로그 조회
							BatGrpLog batGrpLog = logService.getBatGrpLogDetail(batPrmLog.getBatGrpLogId(), batPrmLog.getBatGrpRtyCnt());
							// 그룹 로그의 상태코드, 배치 종료 일자를 업데이트
							batGrpLog.setBatGrpStCd(batPrmLog.getBatPrmStCd());
							batGrpLog.setBatEndDt(batPrmLog.getBatEndDt());
							
							// 마지막 프로그램이 실패일 경우 먼저 실행한 프로그램들 중 가장 먼저 실패한 배치 시작시간 조회
							if(batPrmLog.getBatPrmStCd().equals(BatchStatusCode.FAIL.getCode())) {
								BatPrmLog firstFailLog = logService.getBatPrmLogByFirstFail(batGrpLog);
								batGrpLog.setBatEndDt(firstFailLog.getBatEndDt());
							}
							logService.updateBatGrpLog(batGrpLog);
						}
					}

					dis.close();
					socket.close();
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		});
	}
	/**
	 * Agent 서버 배치 파일 리스트 조회
	 * @param host 연결 정보
	 * @return
	 */
	public List<String> getPath(Host host) {
		JSONObject json = new JSONObject();
		json.put("cmd", "path");
		List<String> pathList = new ArrayList<>();
		try {
			Socket socket = new Socket(host.getHostIp(), host.getHostPt());
			
			// Agent서버로 경로 요청
			DataOutputStream dos = new DataOutputStream(socket.getOutputStream());
			dos.writeUTF(json.toString());  
			dos.flush();
			
			DataInputStream dis = new DataInputStream(socket.getInputStream());
			String data = dis.readUTF();
			ObjectMapper mapper = new ObjectMapper();
			pathList = mapper.readValue(data, List.class); // 경로 저장
			dos.close();
			dis.close();
			socket.close();
		} catch (Exception e) {
			// Agent서버 연결 실패시 경로에 '연결 실패' 추가
			log.info("[연결 실패] Agent서버 연결에 실패해 경로를 받아올 수 없습니다.");
			pathList.add("연결 실패");
		} 
		
		return pathList;
	}
	
	/**
	 * 호스트의 수만큼 쓰레드를 생성해 Agent 서버의 상태 체크 
	 * 1초마다 메소드를 재귀시켜 완료 여부를 확인 
	 * @param host 연결 정보
	 * @return
	 */
	public JSONObject healthCheck(List<Host> hostList, int count) {
		
		if(count == 0) {
			for(Host host : hostList) {
				threadPool.execute(new Runnable() {
					
					@Override
					public void run() {
						try {
							JSONObject json = new JSONObject();
							json.put("cmd", "healthCheck");
							
							Socket socket = new Socket();
							socket.connect(new InetSocketAddress(host.getHostIp(), host.getHostPt()), 2000); // 2초후 소멸
							log.info("[연결 시도] : " + host.getHostIp() + ":" + host.getHostPt()+"("+ host.getHostId() +")");
							
							// healthCheck 요청
							DataOutputStream dos = new DataOutputStream(socket.getOutputStream());
							dos.writeUTF(json.toString());
							dos.flush();
							
							// echo
							DataInputStream dis = new DataInputStream(socket.getInputStream());
							String data = dis.readUTF();
							
							if(socket.isConnected()) {
								connect.put(host.getHostId(), data);
							}else {
								connect.put(host.getHostId(), "off");
							}
							
							dos.close();
							dis.close();
							socket.close();
						} catch (Exception e) {
							log.info("[연결 실패] : " + host.getHostIp() + ":" + host.getHostPt());
							connect.put(host.getHostId(), "off");
						} 
					}	
				});
			}
		}
		
		if(hostList.size() == connect.length()) {
			JSONObject result = connect;
			connect = new JSONObject();
			return result;
		}else {
			try {
				Thread.sleep(1000L);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			// 작업이 완료 안됐으면 재귀시킴
			log.info("[메소드 재실행]" + connect.toString());
			count ++;
			return healthCheck(hostList, count);
		}
		
	}
}
