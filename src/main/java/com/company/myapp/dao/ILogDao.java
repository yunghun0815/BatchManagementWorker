package com.company.myapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.company.myapp.dto.BatGrpLog;
import com.company.myapp.dto.BatPrmLog;
import com.company.myapp.dto.Pager;

@Mapper
public interface ILogDao {

	int getBatGrpLogCount();

	int getBatPrmLogCount();

	List<BatGrpLog> getBatGrpLogList(Pager pager);

	List<BatPrmLog> getBatPrmLogList(Pager pager);

	BatGrpLog getBatGrpLogDetail(@Param(value = "batGrpLogId") String batGrpLogId, @Param(value = "batGrpRtyCnt") int batGrpRtyCnt);
	
	List<BatGrpLog> getBatGrpLogDetailList(String batGrpLogId);
	
	BatPrmLog getBatPrmLogDetail(@Param(value = "batGrpLogId") String batGrpLogId, @Param(value = "batGrpRtyCnt") int batGrpRtyCnt, @Param(value = "batPrmId") String batPrmId);

	void insertBatGrpLog(BatGrpLog batGrpLog);

	void insertBatPrmLog(BatPrmLog batPrmLog);

	void updateBatGrpLog(BatGrpLog batGrpLog);

	void updateBatPrmLog(BatPrmLog batPrmLog);

	BatPrmLog getBatPrmLogByFirstFail(BatGrpLog batGrpLog);
	
	int getRtyCnt(String batGrpLogId);

	void insertRtyBatGrpLog(BatGrpLog batGrpLog);

	List<BatPrmLog> getRtyPrmListByLogIdNCnt(@Param(value="logId")String logId, @Param(value="rty")int rty);

	List<BatGrpLog> getRtyBatGrpLogListByLogId(String batGrpLogId);

	int getBatGrpLogCountBySearch(BatGrpLog log);

	List<BatGrpLog> searchBatGrpLog(@Param(value = "pager") Pager pager, @Param(value = "log") BatGrpLog log);

	List<BatPrmLog> getBatPrmLogListByGrpLog(@Param(value = "batGrpLogId") String batGrpLogId, @Param(value = "batGrpRtyCnt") int batGrpRtyCnt);

	String getBatGrpLogSeq();

	int getCountJob(String code, String date);

	int getAllCountJob(String date);

	List<BatGrpLog> getBatGrpLogListByDate(String date);

	List<BatPrmLog> getBatPrmLogListByGrpIdAndDate(@Param(value = "batGrpId") String batGrpId, @Param(value = "date") String date);

	String getStcdByGrpLogId(String batGrpLogId);




}
