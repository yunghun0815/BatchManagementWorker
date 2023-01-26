package com.company.myapp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.myapp.dao.ILogDao;
import com.company.myapp.dto.BatGrpLog;
import com.company.myapp.dto.BatPrmLog;
import com.company.myapp.dto.Pager;
import com.company.myapp.service.ILogService;

@Service
public class LogService implements ILogService {

		@Autowired
		ILogDao logDao;

		@Override
		public int getBatGrpLogCount() {
			return logDao.getBatGrpLogCount();
		}

		@Override
		public int getBatPrmLogCount() {
			return logDao.getBatPrmLogCount();
		}

		@Override
		public List<BatGrpLog> getBatGrpLogList(Pager pager) {
			return logDao.getBatGrpLogList(pager);
		}

		@Override
		public List<BatPrmLog> getBatPrmLogList(Pager pager) {
			return logDao.getBatPrmLogList(pager);
		}

		@Override
		public BatGrpLog getBatGrpLogDetail(String batGrpLogId, int batGrpRtyCnt) {
			return logDao.getBatGrpLogDetail(batGrpLogId, batGrpRtyCnt);
		}
		
		@Override
		public List<BatGrpLog> getBatGrpLogDetailList(String batGrpLogId) {
			return logDao.getBatGrpLogDetailList(batGrpLogId);
		}
		
		@Override
		public BatPrmLog getBatPrmLogDetail(String batGrpLogId, int batGrpRtyCnt, String batPrmId) {
			return logDao.getBatPrmLogDetail(batGrpLogId, batGrpRtyCnt, batPrmId);
		}

		@Override
		public void insertBatGrpLog(BatGrpLog batGrpLog) {
			logDao.insertBatGrpLog(batGrpLog);
		}

		@Override
		public void insertBatPrmLog(BatPrmLog batPrmLog) {
			logDao.insertBatPrmLog(batPrmLog);
		}

		@Override
		public void updateBatGrpLog(BatGrpLog batGrpLog) {
			logDao.updateBatGrpLog(batGrpLog);
		}

		@Override
		public void updateBatPrmLog(BatPrmLog batPrmLog) {
			logDao.updateBatPrmLog(batPrmLog);
		}

		@Override
		public BatPrmLog getBatPrmLogByFirstFail(BatGrpLog batGrpLog) {
			return logDao.getBatPrmLogByFirstFail(batGrpLog);
		}
		
		@Override
		public void insertRtyBatGrpLog(BatGrpLog batGrpLog) {
			logDao.insertRtyBatGrpLog(batGrpLog);
			
		}

		@Override
		public int getBatGrpLogCountBySearch(BatGrpLog log) {
			return logDao.getBatGrpLogCountBySearch(log);
		}

		@Override
		public List<BatGrpLog> searchBatGrpLog(Pager pager, BatGrpLog log) {
			return logDao.searchBatGrpLog(pager, log);
		}

		@Override
		public List<BatPrmLog> getBatPrmLogListByGrpLog(String batGrpLogId, int batGrpRtyCnt) {
			return logDao.getBatPrmLogListByGrpLog(batGrpLogId, batGrpRtyCnt);
		}

		@Override
		public int getCountjob(String code) {
			return logDao.getCountJob(code);
		}

		@Override
		public int getAllCountJob() {
			return logDao.getAllCountJob();
		}



}
