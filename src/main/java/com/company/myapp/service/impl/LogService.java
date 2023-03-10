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
		public int getBatGrpLogCount(BatGrpLog log) {
			return logDao.getBatGrpLogCount(log);
		}

		@Override
		public List<BatGrpLog> getBatGrpLogList(Pager pager, BatGrpLog log) {
			return logDao.getBatGrpLogList(pager, log);
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
		public List<BatPrmLog> getBatPrmLogListByGrpLog(String batGrpLogId, int batGrpRtyCnt) {
			return logDao.getBatPrmLogListByGrpLog(batGrpLogId, batGrpRtyCnt);
		}

		@Override
		public int getCountjob(String code, String date) {
			String paramDate = date.substring(0,2) + "/" + date.substring(2,4) + "/" + date.substring(4,6);
			return logDao.getCountJob(code, paramDate);
		}

		@Override
		public int getAllCountJob(String date) {
			String paramDate = date.substring(0,2) + "/" + date.substring(2,4) + "/" + date.substring(4,6);
			
			return logDao.getAllCountJob(paramDate);
		}

		@Override
		public List<BatGrpLog> getBatGrpLogListByDate(String date) {
			return logDao.getBatGrpLogListByDate(date);
		}

		@Override
		public List<BatPrmLog> getBatPrmLogListByGrpIdAndDate(String batGrpId, String date) {
			return logDao.getBatPrmLogListByGrpIdAndDate(batGrpId, date);
		}

		@Override
		public String getStcdByGrpLogId(String batGrpLogId) {
			return logDao.getStcdByGrpLogId(batGrpLogId);
		}



}
