package com.company.myapp.service;

import java.util.List;

import javax.validation.Valid;

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
}
