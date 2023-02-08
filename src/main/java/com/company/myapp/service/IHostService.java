package com.company.myapp.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.company.myapp.dto.Host;
import com.company.myapp.dto.Pager;

public interface IHostService {

	int getHostCount(Host host); // 전체 호스트 수
	
	List<Host> getHostList(); // 전체 호스트 리스트
	
	List<Host> getHostList(Pager pager, Host host); // 호스트 리스트 (페이징 처리)

	void insertHost(Host host); // 호스트 등록

	void updateHost(Host host); // 호스트 수정

	void deleteHost(String hostId); // 호스트 삭제
	
	Host getHostByBatGrpId(String batGrpId); // 그룹 아이디로 호스트 정보 조회
	
	Map<String, String> connectHost(Set<String> set); // 

	int getBatGrpCntByHostId(String hostId); // 호스트에 등록된 배치 그룹 수

}
