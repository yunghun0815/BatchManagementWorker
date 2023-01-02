package com.company.myapp.service;

import java.util.List;

import com.company.myapp.dto.BatGrp;
import com.company.myapp.dto.Pager;

public interface IBatchService {

	public int getTotalGroupNum();
	
	public List<BatGrp> getBatchGroupList(Pager pager);
	
	public BatGrp getBatchGroupDetail(String grpId);

	public void insertBatchGroup(BatGrp vo);
	public void updateBatchGroup(BatGrp vo);
	public void deleteBatchGroup(String grpId);

	public boolean checkJob(String grpId);
	public void startJob(String grpId);
	public void stopJob(String grpId);

	public List<BatGrp> searchBatGrp(String keyword);
	public List<BatGrp> searchBatGrp(String keyword, List<String> checkBox);

}
