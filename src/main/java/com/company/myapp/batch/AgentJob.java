package com.company.myapp.batch;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONObject;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.company.myapp.batch.code.BatchStatusCode;
import com.company.myapp.dto.BatGrp;
import com.company.myapp.dto.BatGrpLog;
import com.company.myapp.dto.BatPrm;
import com.company.myapp.dto.BatPrmLog;
import com.company.myapp.dto.Host;
import com.company.myapp.dto.JsonDto;
import com.company.myapp.service.IBatchService;
import com.company.myapp.service.IHostService;
import com.company.myapp.service.ILogService;

import lombok.extern.slf4j.Slf4j;

/**
 * 배치 그룹에 등록된 주기별로 실행되는 Job 구현체
 * 1. 그룹 로그 및 프로그램 로그 저장 
 * 2. 요청 그룹의 프로그램 정보를 JSONArray 형태로 Agent서버에 전송
 * 
 * @author 정영훈, 김나영
 *
 */
@Slf4j
@Component
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
	      String batGrpId = context.getJobDetail().getKey().getName();
	      
	      List<JsonDto> jsonArray = new ArrayList<>();
	      // 그룹에 등록된 프로그램 조회 
	      List<BatPrm> batPrmList = batchService.getBatPrmList(batGrpId);
	      
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
	         JsonDto jsonObject = new JsonDto();
	         
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
	         jsonObject.setPath(batPrm.getPath());
	         jsonObject.setParam(batPrm.getParam());
	         jsonObject.setBatGrpLogId(batGrpLog.getBatGrpLogId());
	         jsonObject.setBatPrmId(batPrm.getBatPrmId());
	         jsonObject.setBatGrpRtyCnt(0);
	         jsonObject.setExcnOrd(batPrm.getExcnOrd());
	         
	         // JSONArray에 Object 추가
	         jsonArray.add(jsonObject);
	         
	         // 첫 번째 프로그램 '실행중' 저장 이후 다음 순서는 '대기중'으로 저장하기 위해 값 변경
	         statusCode = BatchStatusCode.WAIT.getCode();
	      }
	      // 호스트 정보 조회
	      Host host = hostService.getHostByBatGrpId(batGrpId); 
	      // Agent 서버와 통신 및 JSON 객체 전송
	      batchServer.sendMessage(host, jsonArray);
	      log.info("'{}' 그룹의 작업을 요청하였습니다.", batGrpId);
	   }

	
	/**
	 * 작업 수동 실행
	 * @param batGrpLogId 수동 실행할 그룹 로그 아이디
	 * @param vo 수동 실행할 그룹
	 * @param rtyCnt 해당 그룹 로그의  마지막 차수
	 */
	public void rtyExecute(String batGrpLogId, BatGrp vo, int rtyCnt){
		String batGrpId = vo.getBatGrpId(); 

		List<JsonDto> jsonArray = new ArrayList<>();
		
		// 재실행 할 프로그램 조회
		List<BatPrm> batPrmList = vo.getPrmList();
		// 그룹 로그 저장
		BatGrpLog batGrpLog = new BatGrpLog();
		batGrpLog.setBatGrpLogId(batGrpLogId);
		batGrpLog.setBatGrpRtyCnt(rtyCnt);
		batGrpLog.setBatGrpId(batGrpId); 
		batGrpLog.setBatGrpStCd(BatchStatusCode.RUNNING.getCode());
		logService.insertRtyBatGrpLog(batGrpLog); 

		// 첫 번째 프로그램 로그에 '실행중' 저장하기 위해 변수 선언
		String statusCode = BatchStatusCode.RUNNING.getCode();
		
		// 프로그램 로그 저장 및 Agent 서버로 보낼 JSONArray 생성
		int excnOrd = 1;
		for(BatPrm batPrm : batPrmList) {
			JsonDto jsonDto = new JsonDto();
	         
			 // 프로그램 로그 저장
			 BatPrmLog batPrmLog = new BatPrmLog();
			 batPrmLog.setBatGrpLogId(batGrpLogId);
			 batPrmLog.setBatGrpRtyCnt(rtyCnt);
			 batPrmLog.setBatPrmId(batPrm.getBatPrmId());
			 batPrmLog.setParam(batPrm.getParam());
			 batPrmLog.setBatPrmStCd(statusCode);
			 batPrmLog.setExcnOrd(excnOrd);
			 logService.insertBatPrmLog(batPrmLog);
			 
			 // Agent서버로 보낼 JSON에 값 추가
			 jsonDto.setPath(batPrm.getPath());
			 jsonDto.setParam(batPrm.getParam());
			 jsonDto.setBatGrpLogId(batGrpLogId);
			 jsonDto.setBatPrmId(batPrm.getBatPrmId());
			 jsonDto.setBatGrpRtyCnt(rtyCnt);
			 jsonDto.setExcnOrd(excnOrd);
			 
			 // JSONArray에 Object 추가
			 jsonArray.add(jsonDto);
			 
			 // 첫 번째 프로그램 '실행중' 저장 이후 다음 순서는 '대기중'으로 저장하기 위해 값 변경
			 statusCode = BatchStatusCode.WAIT.getCode();
			 excnOrd++;
      }
      // 호스트 정보 조회
      Host host = hostService.getHostByBatGrpId(batGrpId); 
      // Agent 서버와 통신 및 JSON 객체 전송
      batchServer.sendMessage(host, jsonArray);
	}
}