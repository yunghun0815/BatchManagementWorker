package com.company.myapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.company.myapp.dto.Host;
import com.company.myapp.dto.Pager;

@Mapper
public interface IHostDao {
	
	List<Host> getHostList();
	
	List<Host> getHostListByPage(@Param(value = "pager") Pager pager, @Param(value = "host") Host host);

	int insertHost(Host host);

	int getHostCount(Host host);

	Host getHostDetail(String hostId);

	int updateHost(Host host);

	int deleteHost(String hostId);

	Host getHostByBatGrpId(String batGrpId);

	int getHostCountBySearch(Host host);

	int getBatGrpCntByHostId(String hostId);

	

}
