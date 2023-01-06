package com.company.myapp.service;

import java.util.List;

import com.company.myapp.dto.BatGrp;
import com.company.myapp.dto.BatPrm;
import com.company.myapp.dto.Pager;

public interface IBatchService {

	public int getTotalGroupNum();
	
	public List<BatGrp> getBatGrpList(Pager pager);
	
	public BatGrp getBatGrpDetail(String grpId);

	public void insertBatGrp(BatGrp vo);
	public void updateBatGrp(BatGrp vo);
	public void deleteBatGrp(String grpId);

	public List<BatGrp> searchBatGrp(Pager pager, String keyword, List<String> filtering);
	public int getTotalSearchNum(String keyword, List<String> filtering);
	
	public List<BatGrp> getBatGrpList();

	
	
	public List<BatPrm> getBatPrmList(String grpId);

	public BatPrm getBatPrmDetail(String prmId);

	public void insertBatPrm(BatPrm vo);

	public void deleteBatPrm(String prmId, String grpId);

	public void updateBatPrm(BatPrm vo);


}
