package com.company.myapp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.myapp.dao.IHostDao;
import com.company.myapp.dto.Host;
import com.company.myapp.dto.Pager;
import com.company.myapp.service.IHostService;

@Service
public class HostService implements IHostService{

	@Autowired
	IHostDao hostDao;
	
	@Override
	public int getHostCount() {
		return hostDao.getHostCount();
	}
	
	@Override
	public List<Host> getHostList() {
		return hostDao.getHostList();
	}
	
	@Override
	public List<Host> getHostList(Pager pager) {
		return hostDao.getHostListByPage(pager);
	}

	@Override
	public void insertHost(Host host) {
		hostDao.insertHost(host);
	}

	@Override
	public Host getHostDetail(String hostId) {
		return hostDao.getHostDetail(hostId);
	}

	@Override
	public void updateHost(Host host) {
		hostDao.updateHost(host);
	}

	@Override
	public void deleteHost(String hostId) {
		hostDao.deleteHost(hostId);
	}

	@Override
	public Host getHostByBatGrpId(String batGrpId) {
		return hostDao.getHostByBatGrpId(batGrpId);
	}



}
