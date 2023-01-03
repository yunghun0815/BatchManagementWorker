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

	List<BatPrmLog> getBatPrmLogListByBatGrpLogId(String batGrpLogId);
	
	BatGrpLog getBatGrpLogDetail(@Param(value = "batGrpLogId") String batGrpLogId, @Param(value = "batGrpRtyCnt") int batGrpRtyCnt);
	
	BatPrmLog getBatPrmLogDetail(@Param(value = "batGrpLogId") String batGrpLogId, @Param(value = "batGrpRtyCnt") int batGrpRtyCnt, @Param(value = "batPrmId") String batPrmId);

	void insertBatGrpLog(BatGrpLog batGrpLog);

	void insertBatPrmLog(BatPrmLog batPrmLog);

	void updateBatGrpLog(BatGrpLog batGrpLog);

	void updateBatPrmLog(BatPrmLog batPrmLog);
}
