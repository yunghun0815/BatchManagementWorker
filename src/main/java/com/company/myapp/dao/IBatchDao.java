package com.company.myapp.dao;

import java.util.List;

import com.company.myapp.dto.BatGrp;
import com.company.myapp.dto.Pager;

public interface IBatchDao {

	public int getTotalGroupNum();

	public List<BatGrp> getBatGrpListByPage(Pager pager);

	public BatGrp getBatGrpDetail(String grpId);

	public void insertBatchGroup(BatGrp vo);

	public void updateBatchGroup(BatGrp vo);

	public void deleteBatchGroup(String grpId);

	public List<BatGrp> searchBatGrp(String keyword, List<String> checkBox);

}
