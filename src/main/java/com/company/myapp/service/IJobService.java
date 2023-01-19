package com.company.myapp.service;

import java.util.List;
import java.util.Map;

import com.company.myapp.dto.BatGrp;
import com.company.myapp.dto.BatGrpLog;

public interface IJobService {

	//boolean checkJob(String grpId);

	void startSchedule();

	void shutdownSchedule();

	void startJob(String grpId);

	void pauseJob(String grpId);

	void addJob(String grpId);

	void removeJob(String grpId);
	
	void updateJob(BatGrp vo);
	
	void manuallyRun(String batGrpLogId, String cmd, Map<String, String> param);
	
	void manuallyRun(String batGrpId);

	boolean checkExistsJobByGrpId(String batGrpId);

}
