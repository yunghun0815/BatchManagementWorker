package com.company.myapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.company.myapp.dto.BatGrp;
import com.company.myapp.dto.Pager;

@Mapper
public interface IBatchDao {

	public int getTotalGroupNum();

	public List<BatGrp> getBatGrpListByPage(Pager pager);

	public BatGrp getBatGrpDetail(String grpId);

	public void insertBatchGroup(BatGrp vo);

	public void updateBatchGroup(BatGrp vo);

	public void deleteBatchGroup(String grpId);

	public List<BatGrp> searchBatGrp(@Param("pager")Pager pager, @Param("keyword")String keyword, 
			                          @Param("filtering")List<String> filtering);
	public int getTotalSearchNum(@Param("keyword")String keyword, @Param("filtering")List<String> filtering);

	public List<BatGrp> getBatGrpList();

}
