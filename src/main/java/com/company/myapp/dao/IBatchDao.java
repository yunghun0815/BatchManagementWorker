package com.company.myapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.company.myapp.dto.BatGrp;
import com.company.myapp.dto.BatPrm;
import com.company.myapp.dto.Pager;

@Mapper
public interface IBatchDao {

	public int getTotalGroupNum(BatGrp vo);

	public List<BatGrp> getBatGrpListByPage(@Param("pager")Pager pager, @Param("vo")BatGrp vo);

	public BatGrp getBatGrpDetail(String grpId);

	public void insertBatGrp(BatGrp vo);

	public void updateBatGrp(BatGrp vo);

	public void deleteBatGrp(String grpId);

	//public List<BatGrp> searchBatGrp(@Param("pager")Pager pager, @Param("vo")BatGrp vo);
	
	//public int getTotalSearchNum(BatGrp vo);

	public List<BatGrp> getBatGrpList();
	
	public List<BatPrm> getBatPrmList(String grpId);

	public BatPrm getBatPrmDetail(String prmId);

	public void insertBatPrm(BatPrm vo);

	public void deleteBatPrm(String prmId);
	public void deleteBatPrmByGrp(String grpId);

	public void updateBatPrm(BatPrm vo);

	public void sortByRownum(String grpId);
	public void sortByUsers(BatPrm pvo);

	public int getLastExcnOrd(String batGrpId);

	public List<String> getBatGrpIdListByHostId(String hostId);

	public BatGrp getBatGrpByGrpLogId(String batGrpLogId);

	public List<BatPrm> getBatPrmListByLogId(String batGrpLogId);

	public List<BatPrm> getBatPrmListByFailLogId(String batGrpLogId);

	public void rollbackGroup(String batGrpId);

	public void rollbackProgram(String batGrpId);

	//public int checkGrpNm(String batGrpNm);
	
}
