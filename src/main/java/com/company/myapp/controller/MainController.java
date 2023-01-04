package com.company.myapp.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.company.myapp.batch.BatchServer;
import com.company.myapp.batch.BatchStatusCode;
import com.company.myapp.dto.BatGrpLog;
import com.company.myapp.dto.BatPrm;
import com.company.myapp.dto.BatPrmLog;
import com.company.myapp.dto.Host;
import com.company.myapp.service.ILogService;
import com.company.myapp.service.impl.HostService;

@Controller
public class MainController {
	@GetMapping("/")
	public String main() {
		
		return "main";
	}
	
	
	@Autowired
	BatchServer batchServer;
	
	@Autowired
	ILogService logService;
	
	@Autowired
	HostService hostService;
	
	@GetMapping("/start")
	public String start() throws IOException {
		
		batchServer.start();
		
		return "";
	}
	
	@GetMapping("/test")
	public String test(BatPrmLog log) {
		logService.insertBatPrmLog(log);
		
		return "";
	}
	
	@GetMapping("/test2")
	public String serverTest2() {
		// 잡 키로 그룹아이디 가져옴
		String batGrpId = "BGR00000002";
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		
		// 그룹에 등록된 프로그램 조회 ********조회할 때 실행 순서별로(excnOrd) 해야함 **************
		List<BatPrm> batPrmList = new ArrayList<>();//batchService.getBatPrmListBy(batGrpId);
		
		// 그룹 로그 저장
		BatGrpLog batGrpLog = new BatGrpLog();
		batGrpLog.setBatGrpRtyCnt(0);
		batGrpLog.setBatGrpId(batGrpId); 
		batGrpLog.setBatGrpStCd(BatchStatusCode.RUNNING.getCode());
		System.out.println(batGrpLog.toString());
		logService.insertBatGrpLog(batGrpLog); // 저장 쿼리 실행될 때 PK를 selectKey로 DTO에 SET 시킴
		// 첫 번째 프로그램 로그에 '실행중' 저장하기 위해 변수 선언
		String statusCode = BatchStatusCode.RUNNING.getCode();
		
		// 프로그램 로그 저장 및 Agent 서버로 보낼 JSONArray 생성
		for(BatPrm batPrm : batPrmList) {
			
			// 프로그램 로그 저장
			BatPrmLog batPrmLog = new BatPrmLog();
			batPrmLog.setBatGrpLogId(batGrpLog.getBatGrpLogId());
			batPrmLog.setBatGrpRtyCnt(0);
			batPrmLog.setBatPrmId(batPrm.getBatPrmId());
			batPrmLog.setParam(batPrm.getParam());
			batPrmLog.setBatPrmStCd(statusCode);
			batPrmLog.setExcnOrd(batPrm.getExcnOrd());
			logService.insertBatPrmLog(batPrmLog);
			
			// Agent서버로 보낼 JSON에 값 추가
			jsonObject.put("path", batPrm.getPath());
			jsonObject.put("param", batPrm.getParam());
			jsonObject.put("batGrpLogId", batGrpLog.getBatGrpId());
			jsonObject.put("batPrmId", batPrm.getBatPrmId());
			jsonObject.put("batGrpRtyCnt", 0);
			jsonObject.put("excnOrd", batPrm.getExcnOrd());
			
			// JSONArray에 Object 추가
			jsonArray.put(jsonObject);
			
			// 첫 번째 프로그램 '실행중' 저장 이후 다음 순서는 '대기중'으로 저장하기 위해 값 변경
			statusCode = BatchStatusCode.WAIT.getCode();
		}
		
		// 호스트 정보 조회
	//	Host host = hostService.getHostByBatGrpId(batGrpId); 
		
		// Agent 서버와 통신 및 JSON 객체 전송
	//	batchServer.sendMessage(host, jsonObject);
		
		return "";
	}
}