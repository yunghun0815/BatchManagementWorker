package com.company.myapp.batch.websocket.job;

import java.util.ArrayList;

import org.quartz.CronScheduleBuilder;
import org.quartz.Job;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.company.myapp.batch.websocket.WebSocketAgent;
import com.company.myapp.batch.websocket.WebSocketManagement;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class ResetLogJob implements Job{
	@Autowired
	Scheduler scheduler;
	
	/**
	 * 모니터링 로그 초기화 JOB
	 */
	public void initJob() {
		JobDetail job = JobBuilder.newJob(ResetLogJob.class)
				.withIdentity("log", "monitor")
				.build();
		Trigger trigger = TriggerBuilder.newTrigger()
				.withIdentity("log", "monitor")
				.withSchedule(CronScheduleBuilder.cronSchedule("0 0 0 * * ? "))
				.build();
		try {
			scheduler.scheduleJob(job,trigger);
		} catch (SchedulerException e) {
			log.error("[모니터링 초기화 JOB 생성 에러]" + e.getMessage());
		}
	}
	
	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		WebSocketManagement.managementLog = new ArrayList<>();
		WebSocketAgent.agentLog = new ArrayList<>();
	}
}
