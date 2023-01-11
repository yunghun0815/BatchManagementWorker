package com.company.myapp.service;

import java.util.List;

import com.company.myapp.dto.BatGrp;
import com.company.myapp.dto.BatGrpLog;

public interface IJobService {

	boolean checkJob(String grpId);

	void startSchedule();

	void shutdownSchedule();

	void startJob(String grpId);

	void pauseJob(String grpId);

	void addJob(String grpId);

	void removeJob(String grpId);
	
	void updateJob(BatGrp vo);
	
	String retryJob(String batGrpLogId, String cmd);
	
	List<BatGrpLog> retryJob(String batGrpLogId, BatGrp vo);

	boolean checkExistsJobByGrpId(String batGrpId);

}
