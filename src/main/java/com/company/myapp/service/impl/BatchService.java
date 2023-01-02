package com.company.myapp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.myapp.dao.IBatchDao;
import com.company.myapp.dto.BatGrp;
import com.company.myapp.dto.Pager;
import com.company.myapp.service.IBatchService;

@Service
public class BatchService implements IBatchService {

	@Autowired
	IBatchDao batchDao;
	
	@Override
	public int getTotalGroupNum() {
		// TODO Auto-generated method stub
		return batchDao.getTotalGroupNum();
	}

	@Override
	public List<BatGrp> getBatchGroupList(Pager pager) {
		// TODO Auto-generated method stub
		List<BatGrp> batGrpList = batchDao.getBatGrpListByPage(pager);
		return batGrpList;
	}

	@Override
	public BatGrp getBatchGroupDetail(String grpId) {
		BatGrp batGrp = batchDao.getBatGrpDetail(grpId);
		
		return batGrp;
	}

	@Override
	public void insertBatchGroup(BatGrp vo) {
		batchDao.insertBatchGroup(vo);

	}

	@Override
	public void updateBatchGroup(BatGrp vo) {
		batchDao.updateBatchGroup(vo);
	}

	@Override
	public void deleteBatchGroup(String grpId) {
		batchDao.deleteBatchGroup(grpId);
	}

	@Override
	public List<BatGrp> searchBatGrp(String keyword) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<BatGrp> searchBatGrp(String keyword, List<String> checkBox) {
		// TODO Auto-generated method stub
		return batchDao.searchBatGrp(keyword, checkBox);
	}

	
	@Override
	public boolean checkJob(String grpId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void startJob(String grpId) {
		
	}

	@Override
	public void stopJob(String grpId) {
		// TODO Auto-generated method stub

	}

}
