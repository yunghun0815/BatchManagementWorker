package com.company.myapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.company.myapp.dto.Host;
import com.company.myapp.dto.Pager;

@Mapper
public interface IHostDao {
	
	List<Host> getHostList();
	
	List<Host> getHostListByPage(Pager pager);

	int insertHost(Host host);

	int getHostCount();

	Host getHostDetail(String hostId);

	int updateHost(Host host);

	int deleteHost(String hostId);

	Host getHostByBatGrpId(String batGrpId);

	List<Host> searchHost(@Param(value = "pager") Pager pager, @Param(value = "host") Host host);

	int getHostCountBySearch(Host host);

	

}
