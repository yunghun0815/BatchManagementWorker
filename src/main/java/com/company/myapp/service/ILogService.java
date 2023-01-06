package com.company.myapp.service;

import java.sql.Date;
import java.util.List;

import com.company.myapp.dto.BatGrpLog;
import com.company.myapp.dto.BatPrmLog;
import com.company.myapp.dto.Pager;

public interface ILogService {
	
	int getBatGrpLogCount(); // 그룹 로그 전체 카운트

	int getBatPrmLogCount(); // 프로그램 로그 전체 카운트

	List<BatGrpLog> getBatGrpLogList(Pager pager); // 전체 그룹 로그 리스트

	List<BatPrmLog> getBatPrmLogList(Pager pager); // 전체 프로그램 로그 리스트
	
	List<BatPrmLog> getBatPrmLogListByBatGrpLogId(String batGrpLogId); // 그룹 로그 상세 -> 모든 회차 프로그램 로그 리스트

	BatGrpLog getBatGrpLogDetail(String batGrpLogId, int batGrpRtyCnt); // 그룹 로그 상세

	BatPrmLog getBatPrmLogDetail(String batGrpLogId, int batGrpRtyCnt, String batPrmId); // 프로그램 로그 상세

	void insertBatGrpLog(BatGrpLog batGrpLog); // 그룹 로그 저장
	
	void insertBatPrmLog(BatPrmLog batPrmLog); // 프로그램 로그 저장
	
	void updateBatGrpLog(BatGrpLog batGrpLog); // 그룹 로그 수정
	
	void updateBatPrmLog(BatPrmLog batPrmLog); // 프로그램 로그 수정


	BatPrmLog getBatPrmLogByFirstFail(BatGrpLog batGrpLog);
}
