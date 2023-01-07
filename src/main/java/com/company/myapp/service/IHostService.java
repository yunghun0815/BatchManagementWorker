package com.company.myapp.service;

import java.util.List;
import java.util.Set;

import javax.validation.Valid;

import org.json.JSONObject;

import com.company.myapp.dto.BatGrp;
import com.company.myapp.dto.Host;
import com.company.myapp.dto.Pager;

public interface IHostService {

	int getHostCount();
	
	List<Host> getHostList();
	
	List<Host> getHostList(Pager pager);

	void insertHost(Host host);

	Host getHostDetail(String hostId);

	void updateHost(Host host);

	void deleteHost(String hostId);
	
	Host getHostByBatGrpId(String batGrpId);
	
	JSONObject connectHost(Set<String> set);
}
