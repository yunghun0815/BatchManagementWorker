package com.company.myapp.service;

import java.util.List;
import java.util.Map;

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

	public List<BatGrp> searchBatGrp(Pager pager, BatGrp vo);
	
	public int getTotalSearchNum(BatGrp vo);
	
	public List<BatGrp> getBatGrpList();
	
	public List<BatPrm> getBatPrmList(String batGrpId);

	public BatPrm getBatPrmDetail(String batPrmId);

	public void insertBatPrm(BatPrm vo);

	public void deleteBatPrm(String batPrmId, String batGrpId);

	public void updateBatPrm(BatPrm vo);

	public Map<String, Object> getAgentBatchPath(Host host, String dir);

	public List<String> getBatGrpIdListByHostId(String hostId);

	public void updateExcnOrd(List<BatPrm> prmList);

	public void rollback(String batGrpId);
}
