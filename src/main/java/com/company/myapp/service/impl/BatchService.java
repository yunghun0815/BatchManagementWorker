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
	public List<BatGrp> getBatGrpList(Pager pager) {
		// TODO Auto-generated method stub
		List<BatGrp> batGrpList = batchDao.getBatGrpListByPage(pager);
		return batGrpList;
	}

	@Override
	public BatGrp getBatGrpDetail(String grpId) {
		BatGrp batGrp = batchDao.getBatGrpDetail(grpId);
		
		return batGrp;
	}

	@Override
	public void insertBatGrp(BatGrp vo) {
		batchDao.insertBatchGroup(vo);

	}

	@Override
	public void updateBatGrp(BatGrp vo) {
		batchDao.updateBatchGroup(vo);
	}

	@Override
	public void deleteBatGrp(String grpId) {
		batchDao.deleteBatchGroup(grpId);
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

	@Override
	public List<BatGrp> searchBatGrp(Pager pager, String keyword, List<String> filtering) {
		System.out.println(filtering.getClass().getName());
		List<BatGrp> resultList = batchDao.searchBatGrp(pager, keyword, filtering);
		return resultList;
	}

	@Override
	public int getTotalSearchNum(String keyword, List<String> filtering) {
		// TODO Auto-generated method stub
		System.out.println(filtering.getClass().getName());
		return batchDao.getTotalSearchNum(keyword, filtering);
	}

	@Override
	public List<BatGrp> getBatGrpList() {
		// TODO Auto-generated method stub
		return batchDao.getBatGrpList();
	}

}
