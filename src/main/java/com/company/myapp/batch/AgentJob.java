package com.company.myapp.batch;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;

import com.company.myapp.dto.BatGrpLog;
import com.company.myapp.dto.BatPrm;
import com.company.myapp.dto.BatPrmLog;
import com.company.myapp.dto.Host;
import com.company.myapp.service.IBatchService;
import com.company.myapp.service.IHostService;
import com.company.myapp.service.ILogService;

/**
 * 배치 그룹에 등록된 주기별로 실행되는 Job 구현체
 * 1. 그룹 로그 및 프로그램 로그 저장 
 * 2. 프로그램 실행 정보가 담긴 JSON 객체 생성
 * 3. Agent 서버 통신 및 JSON 객체 전송  
 * 
 * @author 정영훈, 김나영
 *
 */
public class AgentJob implements Job{
	
	@Autowired
	BatchServer batchServer;
	
	@Autowired
	IBatchService batchService;
	
	@Autowired
	ILogService logService;
	
	@Autowired
	IHostService hostService;
	
	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		// 잡 키로 그룹아이디 가져옴
		String batGrpId = context.getJobDetail().getKey().toString();
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		
		// 그룹에 등록된 프로그램 조회 ********조회할 때 실행 순서별로(excnOrd) 해야함 **************
		List<BatPrm> batPrmList = new ArrayList<>();//batchService.getBatPrmListBy(batGrpId);
		
		// 그룹 로그 저장
		BatGrpLog batGrpLog = new BatGrpLog();
		batGrpLog.setBatGrpRtyCnt(0);
		batGrpLog.setBatGrpId(batGrpId); 
		batGrpLog.setBatGrpStCd(BatchStatusCode.RUNNING.getCode());
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
		Host host = hostService.getHostByBatGrpId(batGrpId); 
		
		// Agent 서버와 통신 및 JSON 객체 전송
		batchServer.sendMessage(host, jsonObject);
	}
}