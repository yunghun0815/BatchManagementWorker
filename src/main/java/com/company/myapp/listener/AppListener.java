package com.company.myapp.listener;

import java.io.IOException;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.company.myapp.batch.BatchServer;
import com.company.myapp.service.IJobService;

import lombok.extern.slf4j.Slf4j;

/**
 * 웹 애플리케이션 시작, 종료시점 메소드 실행
 * @author 정영훈
 *
 */
@Slf4j
@Component
public class AppListener implements ServletContextListener{

	@Autowired
	BatchServer batchServer;
	@Autowired 
	IJobService jobService;
	
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		try {
			log.info("웹 애플리케이션 실행");
			batchServer.start();		// 소켓, 스레드풀 생성
			jobService.startSchedule();	// 자동실행 'Y' 인 배치 그룹 Job에 등록
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		try {
			log.info("웹 애플리케이션 종료");
			batchServer.shutDown();			// 소켓, 스레드풀 닫음
			jobService.shutdownSchedule(); 	// 등록 된 Job clear
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
