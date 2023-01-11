package com.company.myapp.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.json.JSONObject;

import com.company.myapp.dto.Host;
import com.company.myapp.dto.Pager;

public interface IHostService {

	int getHostCount(); // 전체 호스트 수
	
	List<Host> getHostList(); // 전체 호스트 리스트
	
	List<Host> getHostList(Pager pager); // 호스트 리스트 (페이징 처리)

	void insertHost(Host host); // 호스트 등록

	void updateHost(Host host); // 호스트 수정

	void deleteHost(String hostId); // 호스트 삭제
	
	Host getHostByBatGrpId(String batGrpId); // 그룹 아이디로 호스트 정보 조회
	
	Map<String, String> connectHost(Set<String> set); // 

	List<Host> searchHost(Pager pager, Host host); // 호스트 검색 결과 리스트(페이징 처리)

	int getHostCountBySearch(Host host); // 검색 결과에 따른 호스트 수
}
