package com.company.myapp.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.company.myapp.batch.code.BatchStatusCode;
import com.company.myapp.dto.BatGrpLog;
import com.company.myapp.dto.BatPrmLog;
import com.company.myapp.dto.Pager;

public interface ILogService {
	
	int getBatGrpLogCount(); // 그룹 로그 전체 카운트

	int getBatPrmLogCount(); // 프로그램 로그 전체 카운트

	List<BatGrpLog> getBatGrpLogList(Pager pager); // 전체 그룹 로그 리스트

	List<BatPrmLog> getBatPrmLogList(Pager pager); // 전체 프로그램 로그 리스트
	
	BatGrpLog getBatGrpLogDetail(String batGrpLogId, int batGrpRtyCnt); // 그룹 로그 리스트 상세
	
	List<BatGrpLog> getBatGrpLogDetailList(String batGrpLogId);  // 로그ID에 대한 전체 그룹 리스트

	BatPrmLog getBatPrmLogDetail(String batGrpLogId, int batGrpRtyCnt, String batPrmId); // 프로그램 로그 상세

	void insertBatGrpLog(BatGrpLog batGrpLog); // 그룹 로그 저장
	
	void insertBatPrmLog(BatPrmLog batPrmLog); // 프로그램 로그 저장
	
	void updateBatGrpLog(BatGrpLog batGrpLog); // 그룹 로그 수정
	
	void updateBatPrmLog(BatPrmLog batPrmLog); // 프로그램 로그 수정

	BatPrmLog getBatPrmLogByFirstFail(BatGrpLog batGrpLog); // 차수별 그룹 로그 중 처음 실패한 로그 조회

	void insertRtyBatGrpLog(BatGrpLog batGrpLog); // 재실행 로그 저장

	int getBatGrpLogCountBySearch(BatGrpLog log); // 검색 결과 카운트

	List<BatGrpLog> searchBatGrpLog(Pager pager, BatGrpLog log); // 검색 결과 페이징 처리해 조회

	List<BatPrmLog> getBatPrmLogListByGrpLog(String batGrpLogId, int batGrpRtyCnt); // 그룹로그 회차별 프로그램 로그 리스트

	int getCountjob(String code);

	int getAllCountJob();

	List<BatGrpLog> getBatGrpLogListByDate(String date); // 일자별 그룹 로그 리스트 조회

	List<BatPrmLog> getBatPrmLogListByGrpIdAndDate(String batGrpId, String date); // 일자별 해당 그룹 아이디 프로그램 로그 리스트 조회


}
