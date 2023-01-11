package com.company.myapp.service;

import java.util.List;

import com.company.myapp.dto.BatGrp;
import com.company.myapp.dto.BatPrm;
import com.company.myapp.dto.Host;
import com.company.myapp.dto.Pager;

public interface IBatchService {

	public int getTotalGroupNum();
	
	public List<BatGrp> getBatGrpList(Pager pager);
	
	public BatGrp getBatGrpDetail(String batGrpId);

	public void insertBatGrp(BatGrp vo);
	
	public void updateBatGrp(BatGrp vo);
	
	public void deleteBatGrp(String batGrpId);

	public List<BatGrp> searchBatGrp(Pager pager, String keyword, List<String> filtering);
	
	public int getTotalSearchNum(String keyword, List<String> filtering);
	
	public List<BatGrp> getBatGrpList();
	
	public List<BatPrm> getBatPrmList(String batGrpId);

	public BatPrm getBatPrmDetail(String batPrmId);

	public void insertBatPrm(BatPrm vo);

	public void deleteBatPrm(String batPrmId, String batGrpId);

	public void updateBatPrm(BatPrm vo);

	public List<String> getAgentBatchPath(Host host);

	public List<String> getBatGrpIdListByHostId(String hostId);

	public void updateExcnOrd(List<BatPrm> prmList);
}
