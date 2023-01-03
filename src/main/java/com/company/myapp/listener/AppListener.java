package com.company.myapp.listener;

import java.io.IOException;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.company.myapp.batch.BatchServer;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class AppListener implements ServletContextListener{

	@Autowired
	BatchServer batchServer;
	
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		try {
			log.info("웹 애플리케이션 실행");
			batchServer.start();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		try {
			log.info("웹 애플리케이션 종료");
			batchServer.shutDown();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
