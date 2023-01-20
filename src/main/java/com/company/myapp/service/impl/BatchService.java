package com.company.myapp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.myapp.batch.BatchServer;
import com.company.myapp.dao.IBatchDao;
import com.company.myapp.dto.BatGrp;
import com.company.myapp.dto.BatPrm;
import com.company.myapp.dto.Host;
import com.company.myapp.dto.Pager;
import com.company.myapp.service.IBatchService;

/**
 * 배치 그룹 및 프로그램 관리 Service
 */
@Service
public class BatchService implements IBatchService {

	@Autowired
	IBatchDao batchDao;
	
	@Autowired
	BatchServer batchServer;
	
	/**
	 * 사용중인 배치 그룹 개수 반환
	 */
	@Override
	public int getTotalGroupNum() {
		return batchDao.getTotalGroupNum();
	}

	/**
	 * 페이지별 배치 그룹 리스트 반환
	 */
	@Override
	public List<BatGrp> getBatGrpList(Pager pager) {
		List<BatGrp> batGrpList = batchDao.getBatGrpListByPage(pager);
		return batGrpList;
	}

	/**
	 * 배치 그룹 상세정보 반환
	 */
	@Override
	public BatGrp getBatGrpDetail(String batGrpId) {
		BatGrp batGrp = batchDao.getBatGrpDetail(batGrpId);
		
		return batGrp;
	}

	/**
	 * 배치 그룹 등록
	 */
	@Override
	public void insertBatGrp(BatGrp vo) {
		batchDao.insertBatGrp(vo);

	}

	/**
	 * 배치 그룹 정보 업데이트
	 */
	@Override
	public void updateBatGrp(BatGrp vo) {
		batchDao.updateBatGrp(vo);
	}

	/**
	 * 배치 그룹에 등록된 프로그램 삭제 후, 그룹 삭제
	 */
	@Override
	public void deleteBatGrp(String batGrpId) {
		batchDao.deleteBatPrmByGrp(batGrpId);
		batchDao.deleteBatGrp(batGrpId);
	}

	/**
	 * 검색된 그룹의 총개수 반환
	 */
	@Override
	public int getTotalSearchNum(BatGrp vo) {
		return batchDao.getTotalSearchNum(vo);
	}
	
	/**
	 * 키워드로 특정 배치 그룹 검색
	 */
	@Override
	public List<BatGrp> searchBatGrp(Pager pager, BatGrp vo) {
		List<BatGrp> resultList = batchDao.searchBatGrp(pager, vo);
		return resultList;
	}

	/**
	 * 사용중인 전체 배치 그룹 리스트 반환
	 */
	@Override
	public List<BatGrp> getBatGrpList() {
		return batchDao.getBatGrpList();
	}

	/**
	 * 특정 배치 그룹에 속한 배치 프로그램 리스트 반환
	 */
	@Override
	public List<BatPrm> getBatPrmList(String batGrpId) {
		return batchDao.getBatPrmList(batGrpId);
	}

	/**
	 * 배치 프로그램 상세정보 반환
	 */
	@Override
	public BatPrm getBatPrmDetail(String batPrmId) {
		return batchDao.getBatPrmDetail(batPrmId);
	}

	/**
	 * 프로그램의 경우, 실행 순서를 맨마지막으로 세팅 후 등록
	 */
	@Override
	public void insertBatPrm(BatPrm vo) {
		//시용중인 프로그램 중 마지막 실행 순서를 반환하는 메서드
		int ord = batchDao.getLastExcnOrd(vo.getBatGrpId());
		vo.setExcnOrd(ord+1);
		batchDao.insertBatPrm(vo);
	}

	/**
	 * 배치 프로그램 삭제 후 배치 그룹에 대한 프로그램 실행 순서 변경
	 */
	@Override
	public void deleteBatPrm(String batPrmId, String batGrpId) {
		batchDao.deleteBatPrm(batPrmId);
		batchDao.sortByRownum(batGrpId);
	}

	/**
	 * 배치 프로그램 정보 업데이트
	 */
	@Override
	public void updateBatPrm(BatPrm vo) {
		batchDao.updateBatPrm(vo);
	}
	
	/**
	 * 호스트별 접근 가능한 파일에 대한 경로 리스트 반환
	 */
	@Override
	public Map<String, Object> getAgentBatchPath(Host host, String dir) {
		return batchServer.getPath(host, dir);
	}

	/**
	 * 호스트Id별 등록된 배치 그룹 리스트 반환
	 */
	@Override
	public List<String> getBatGrpIdListByHostId(String hostId) {
		return batchDao.getBatGrpIdListByHostId(hostId);
	}

	/**
	 * 사용자가 임의로 배치 프로그램에 대한 순서 변경 시, 정보 업데이트
	 */
	@Override
	public void updateExcnOrd(List<BatPrm> prmList) {
		for(BatPrm vo: prmList) {
			batchDao.sortByUsers(vo);
		}
	}

	@Override
	public void rollback(String batGrpId) {
		batchDao.rollbackGroup(batGrpId);
		batchDao.rollbackProgram(batGrpId);
		
	}
}
