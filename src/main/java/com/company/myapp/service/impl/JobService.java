package com.company.myapp.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.myapp.batch.AgentJob;
import com.company.myapp.batch.code.BatchStatusCode;
import com.company.myapp.dao.IBatchDao;
import com.company.myapp.dao.ILogDao;
import com.company.myapp.dto.BatGrp;
import com.company.myapp.dto.BatGrpLog;
import com.company.myapp.dto.BatPrm;
import com.company.myapp.dto.BatPrmLog;
import com.company.myapp.service.IBatchService;
import com.company.myapp.service.IJobService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class JobService implements IJobService {

	@Autowired
	Scheduler scheduler;
	@Autowired
	IBatchService batchService;
	@Autowired
	IBatchDao batchDao;
	@Autowired
	ILogDao logDao;
	@Autowired
	AgentJob agentJob;
	
	/**
	 * Job 실행 관련 Service
	 */
	
	/**
	 * 자동실행 여부 체크 후 실행
	 */
	@Override
	public void startSchedule() {
		
		List<BatGrp> batGrpList = batchService.getBatGrpList();
		for(BatGrp vo: batGrpList) {
			if(vo.getAutoExcnYn().equals("Y") && batchService.getBatPrmList(vo.getBatGrpId()).size()!=0) {
				addJob(vo.getBatGrpId());
			}
		}
	}

	/**
	 * 전체 Job을 일시정지 시키고 삭제
	 */
	@Override
	public void shutdownSchedule() {
		try {
			scheduler.pauseAll();
			scheduler.clear();
		}catch(SchedulerException e) {
			log.error(e.getMessage());
			throw new RuntimeException();
		}
	}

	/**
	 * 등록된 Job일 경우 재실행을, 등록되지 않은 Job일 경우에는 Job 등록 실행
	 */
	@Override
	public void startJob(String grpId) {
		try {
			if(checkExistsJobByGrpId(grpId)) {
				JobKey key = JobKey.jobKey(grpId);
				scheduler.resumeJob(key);
				log.info(key + "를 재실행");
			}else {
				addJob(grpId);
			}
		}catch(SchedulerException e) {
			// 그룹 로그 저장
			BatGrpLog batGrpLog = new BatGrpLog();
			batGrpLog.setBatGrpRtyCnt(0);
			batGrpLog.setBatGrpId(grpId); 
			batGrpLog.setBatGrpStCd(BatchStatusCode.FAIL.getCode());
			logDao.insertBatGrpLog(batGrpLog); // 저장 쿼리 실행될 때 PK를 selectKey로 DTO에 SET 시킴
			
			//프로그램 로그 저장 - 에러메시지는 첫번째 실행 프로그램에만 저장
			List<BatPrm> batPrmList = batchService.getBatPrmList(grpId);
			for(BatPrm batPrm : batPrmList) {
				BatPrmLog batPrmLog = new BatPrmLog();
				batPrmLog.setBatGrpLogId(batGrpLog.getBatGrpLogId());
				batPrmLog.setBatGrpRtyCnt(0);
				batPrmLog.setBatPrmId(batPrm.getBatPrmId());
				batPrmLog.setParam(batPrm.getParam());
				batPrmLog.setBatPrmStCd(BatchStatusCode.FAIL.getCode());
				int excnOrd = batPrm.getExcnOrd();
				batPrmLog.setExcnOrd(excnOrd);
				if(excnOrd==1)
					batPrmLog.setRsltMsg("Job 재실행 실패" + e.getMessage());
				logDao.insertBatPrmLog(batPrmLog);
			}
			log.error(e.getMessage());
			throw new RuntimeException();
		}
	}

	/**
	 * 실행 중지하게 되면 Job을 일시정지 시키고 Job 정보 삭제
	 */
	@Override
	public void pauseJob(String grpId) {
		JobKey key = JobKey.jobKey(grpId);
		log.info("1. 그룹Id: " + key.getGroup());
		log.info("2. 이름: " + key.getName());
		try{
			scheduler.pauseJob(key);
			removeJob(grpId);
			log.info(key + "를 정지");
		}catch(SchedulerException e) {
			log.error(e.getMessage());
			throw new RuntimeException();
		}
	}
	
	/**
	 * Job 등록
	 */
	@Override
	public void addJob(String grpId) {
		BatGrp vo = batchService.getBatGrpDetail(grpId);
		
		JobDetail job = JobBuilder.newJob(AgentJob.class)
						.withIdentity(vo.getBatGrpId())
						.build();
		Trigger trigger = TriggerBuilder.newTrigger()
							.withIdentity(vo.getBatGrpId())
							.withSchedule(CronScheduleBuilder.cronSchedule(vo.getCron()))
							.build();
		try {
			scheduler.scheduleJob(job,trigger);
			log.info("Job 추가 완료" );
			log.info(scheduler.getJobDetail(new JobKey(grpId)).toString());
		}catch(SchedulerException e) {
			// 그룹 로그 저장
			BatGrpLog batGrpLog = new BatGrpLog();
			batGrpLog.setBatGrpRtyCnt(0);
			batGrpLog.setBatGrpId(grpId); 
			batGrpLog.setBatGrpStCd(BatchStatusCode.FAIL.getCode());
			logDao.insertBatGrpLog(batGrpLog); // 저장 쿼리 실행될 때 PK를 selectKey로 DTO에 SET 시킴

			//프로그램 로그 저장 - 에러메시지는 첫번째 실행 프로그램에만 저장
			List<BatPrm> batPrmList = batchService.getBatPrmList(grpId);
			for(BatPrm batPrm : batPrmList) {
				BatPrmLog batPrmLog = new BatPrmLog();
				batPrmLog.setBatGrpLogId(batGrpLog.getBatGrpLogId());
				batPrmLog.setBatGrpRtyCnt(0);
				batPrmLog.setBatPrmId(batPrm.getBatPrmId());
				batPrmLog.setParam(batPrm.getParam());
				batPrmLog.setBatPrmStCd(BatchStatusCode.FAIL.getCode());
				int excnOrd = batPrm.getExcnOrd();
				batPrmLog.setExcnOrd(excnOrd);
				if(excnOrd==1)
					batPrmLog.setRsltMsg("Job 등록 실패" + e.getMessage());
				logDao.insertBatPrmLog(batPrmLog);
			}
			log.error(e.getMessage());
			throw new RuntimeException();
		}
	}

	/**
	 * Job 삭제
	 */
	@Override
	public void removeJob(String grpId) {
		try {
			scheduler.pauseTrigger(new TriggerKey(grpId));
			scheduler.unscheduleJob(new TriggerKey(grpId));
			scheduler.deleteJob(new JobKey(grpId));
			log.info("job 제거 완료");
		}catch(SchedulerException e) {
			log.error(e.getMessage());
			throw new RuntimeException();
		}
	}
	
	/**
	 * Job 정보 업데이트
	 */
	@Override
	public void updateJob(BatGrp vo) {
		TriggerKey oldTrigger = TriggerKey.triggerKey(vo.getBatGrpId());
		CronTrigger newTrigger = (CronTrigger)TriggerBuilder.newTrigger()
									.withSchedule(CronScheduleBuilder.cronSchedule(vo.getCron()))
									.build();
		log.info("업데이트 완료");
		try {
			scheduler.rescheduleJob(oldTrigger, newTrigger);
		}catch(SchedulerException e) {
			// 그룹 로그 저장
			BatGrpLog batGrpLog = new BatGrpLog();
			batGrpLog.setBatGrpRtyCnt(0);
			batGrpLog.setBatGrpId(vo.getBatGrpId()); 
			batGrpLog.setBatGrpStCd(BatchStatusCode.FAIL.getCode());
			logDao.insertBatGrpLog(batGrpLog); // 저장 쿼리 실행될 때 PK를 selectKey로 DTO에 SET 시킴

			//프로그램 로그 저장 - 에러메시지는 첫번째 실행 프로그램에만 저장
			List<BatPrm> batPrmList = batchService.getBatPrmList(vo.getBatGrpId());
			for(BatPrm batPrm : batPrmList) {
				BatPrmLog batPrmLog = new BatPrmLog();
				batPrmLog.setBatGrpLogId(batGrpLog.getBatGrpLogId());
				batPrmLog.setBatGrpRtyCnt(0);
				batPrmLog.setBatPrmId(batPrm.getBatPrmId());
				batPrmLog.setParam(batPrm.getParam());
				batPrmLog.setBatPrmStCd(BatchStatusCode.FAIL.getCode());
				int excnOrd = batPrm.getExcnOrd();
				batPrmLog.setExcnOrd(excnOrd);
				if(excnOrd==1)
					batPrmLog.setRsltMsg("Job 업데이트 실패" + e.getMessage());
				logDao.insertBatPrmLog(batPrmLog);
			}
			log.error(e.getMessage());
			throw new RuntimeException();
		}
	}

	
	/**
	 * 프로그램 수동 실행(재실행)
	 */
	@Override
	public void manuallyRun(String batGrpLogId, String cmd, Map<String, String> param) {
		BatGrp vo = batchDao.getBatGrpByGrpLogId(batGrpLogId);
		List<BatPrm> list = new ArrayList<>();
		//현재 재실행 회차 세팅
		int rtyCnt = logDao.getRtyCnt(batGrpLogId);
		
		if(cmd.equals("all")) {		// 전체 재실행 -> 그룹 + 프로그램 전체
			list = batchDao.getBatPrmListByLogId(batGrpLogId);
			log.info("'{}' 로그 {}회차 작업(전부 재실행)을 요청하였습니다.", batGrpLogId, rtyCnt+1);
		}else if(cmd.equals("fail")) {		// 실패한것만 재실행 -> 그룹 + 실패한 프로그램
			list = batchDao.getBatPrmListByFailLogId(batGrpLogId);
			log.info("'{}' 로그 {}회차 작업(실패 재실행)을 요청하였습니다.", batGrpLogId, rtyCnt+1);
		}
		
		for(BatPrm prm : list) {
			prm.setParam(param.get(prm.getBatPrmId()));
		}
		
		vo.setPrmList(list);
		agentJob.manuallyRun(batGrpLogId, vo, rtyCnt);
	}
	
	/**
	 * 프로그램 수동 실행
	 */	
	@Override
	public void manuallyRun(String batGrpId) {
		BatGrp vo = batchDao.getBatGrpDetail(batGrpId);
		List<BatPrm> list = new ArrayList<>();
		
		list = batchDao.getBatPrmList(batGrpId);
		vo.setPrmList(list);
		
		String batGrpLogId = logDao.getBatGrpLogSeq();
		
		log.info("'{}' 그룹을 수동 실행하였습니다.", batGrpId);
		agentJob.manuallyRun(batGrpLogId, vo, 0);
	}
	
	/**
	 * 등록된 Job인지 체크
	 */
	@Override
	public boolean checkExistsJobByGrpId(String batGrpId) {
		try {
			JobKey key = JobKey.jobKey(batGrpId);
			if(scheduler.checkExists(key)) return true;
			else return false;
		} catch (SchedulerException e) {
			e.printStackTrace();
			return false;
		}
	}
}
