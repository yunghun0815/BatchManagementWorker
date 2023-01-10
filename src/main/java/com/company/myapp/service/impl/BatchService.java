package com.company.myapp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.myapp.batch.BatchServer;
import com.company.myapp.dao.IBatchDao;
import com.company.myapp.dto.BatGrp;
import com.company.myapp.dto.BatPrm;
import com.company.myapp.dto.Host;
import com.company.myapp.dto.Pager;
import com.company.myapp.service.IBatchService;

@Service
public class BatchService implements IBatchService {

	@Autowired
	IBatchDao batchDao;
	
	@Autowired
	BatchServer batchServer;
	
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
		batchDao.insertBatGrp(vo);

	}

	@Override
	public void updateBatGrp(BatGrp vo) {
		for(BatPrm pvo: vo.getPrmList()) {
			batchDao.sortByUsers(pvo);
		}
		batchDao.updateBatGrp(vo);
	}

	@Override
	public void deleteBatGrp(String grpId) {
		List<BatPrm> batPrmList = batchDao.getBatPrmList(grpId);
		for(BatPrm pvo: batPrmList) {
			batchDao.deleteBatPrm(pvo.getBatPrmId());
		}
		batchDao.deleteBatGrp(grpId);
	}


	@Override
	public List<BatGrp> searchBatGrp(Pager pager, String keyword, List<String> filtering) {
		System.out.println(filtering.getClass().getName());
		List<BatGrp> resultList = batchDao.searchBatGrp(pager, keyword, filtering);
		return resultList;
	}

	@Override
	public int getTotalSearchNum(String keyword, List<String> filtering) {
		System.out.println(filtering.getClass().getName());
		return batchDao.getTotalSearchNum(keyword, filtering);
	}

	@Override
	public List<BatGrp> getBatGrpList() {
		return batchDao.getBatGrpList();
	}

	
	
	@Override
	public List<BatPrm> getBatPrmList(String grpId) {
		return batchDao.getBatPrmList(grpId);
	}

	@Override
	public BatPrm getBatPrmDetail(String prmId) {
		return batchDao.getBatPrmDetail(prmId);
	}

	@Override
	public void insertBatPrm(BatPrm vo) {
		int ord = batchDao.getLastExcnOrd(vo.getBatGrpId());
		vo.setExcnOrd(ord+1);
		batchDao.insertBatPrm(vo);
	}

	@Override
	public void deleteBatPrm(String prmId, String grpId) {
		System.out.println(grpId);
		batchDao.deleteBatPrm(prmId);
		batchDao.sortByRownum(grpId);
	}

	@Override
	public void updateBatPrm(BatPrm vo) {
		batchDao.updateBatPrm(vo);
	}

	@Override
	public List<String> getAgentBatchPath(Host host) {
		
		return batchServer.getPath(host);
	}

	@Override
	public List<String> getBatGrpIdListByHostId(String hostId) {
		
		return batchDao.getBatGrpIdListByHostId(hostId);
	}

	@Override
	public void updateExcnOrd(List<BatPrm> prmList) {
		for(BatPrm vo: prmList) {
			batchDao.sortByUsers(vo);
		}
		
	}

}
