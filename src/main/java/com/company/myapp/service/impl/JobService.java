package com.company.myapp.service.impl;

import java.util.List;

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
import com.company.myapp.dao.IBatchDao;
import com.company.myapp.dao.ILogDao;
import com.company.myapp.dto.BatGrp;
import com.company.myapp.dto.BatGrpLog;
import com.company.myapp.dto.BatPrmLog;
import com.company.myapp.service.IJobService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class JobService implements IJobService {

	@Autowired
	Scheduler scheduler;
	@Autowired
	BatchService batchService;
	@Autowired
	IBatchDao batchDao;
	@Autowired
	ILogDao logDao;
	
	@Override
	public boolean checkJob(String grpId) {
		try {
			if(scheduler.getJobDetail(new JobKey(grpId))!=null) return true;
			else return false;
		}catch(SchedulerException e) {
			log.error(e.getMessage());
			throw new RuntimeException();
			//log 저장
		}
	}

	@Override
	public void startSchedule() {
		List<BatGrp> batGrpList = batchService.getBatGrpList();
		try {
			for(BatGrp vo: batGrpList) {
				if(vo.getAutoExcnYn() == 'Y' && batchService.getBatPrmList(vo.getBatGrpId()).size()!=0) {
					scheduler.resumeJob(new JobKey(vo.getBatGrpId()));
				}
			}
		}catch(SchedulerException e) {
			log.error(e.getMessage());
			throw new RuntimeException();
			//log 저장
		}
	}

	@Override
	public void shutdownSchedule() {
		try {
			scheduler.pauseAll();
		}catch(SchedulerException e) {
			log.error(e.getMessage());
			throw new RuntimeException();
			//log저장?
		}
	}

	@Override
	public void startJob(String grpId) {
		JobKey key = JobKey.jobKey(grpId);
		try {
			scheduler.resumeJob(key);
			log.info(key + "를 재실행");
		}catch(SchedulerException e) {
			log.error(e.getMessage());
			throw new RuntimeException();
			//log저장?
		}
	}

	@Override
	public void pauseJob(String grpId) {
		JobKey key = JobKey.jobKey(grpId);
		log.info("1. 그룹Id: " + key.getGroup());
		log.info("2. 이름: " + key.getName());
		try{
			scheduler.pauseJob(key);
			log.info(key + "를 정지");
		}catch(SchedulerException e) {
			log.error(e.getMessage());
			throw new RuntimeException();
			//log저장?
		}
	}

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
			log.info("Job 추가 완료");
		}catch(SchedulerException e) {
			log.error(e.getMessage());
			throw new RuntimeException();
		}
	}

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
			log.error(e.getMessage());
			throw new RuntimeException();
		}
	}

	@Override
	public List<BatGrpLog> retryJob(String batGrpLogId, BatGrp vo) {
		//현재 재실행 회차 세팅
		int rtyCnt = logDao.getRtyCnt(batGrpLogId);
		AgentJob agentJob = new AgentJob();
		
		try {
			agentJob.rtyExecute(batGrpLogId, vo, rtyCnt);
		}catch(Exception e){
			log.error(e.getMessage());
			throw new RuntimeException();
		}
		//재실행회차가 1 이상인 그룹로그List -> For문으로 그룹+재실행 회차에 해당하는 프로그램 로그 select setting
		List<BatGrpLog> rtyBatGrpLogList = logDao.getRtyBatGrpLogListByLogId(batGrpLogId);
		for(BatGrpLog rtyVo: rtyBatGrpLogList) {
			String logId = rtyVo.getBatGrpLogId();
			int rty = rtyVo.getBatGrpRtyCnt();
			List<BatPrmLog> batPrmLogList = logDao.getRtyPrmListByLogIdNCnt(logId, rty);
			rtyVo.setPrmLogList(batPrmLogList);
		}
		return rtyBatGrpLogList;
	}
}
