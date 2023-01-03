package com.company.myapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.company.myapp.dto.Host;
import com.company.myapp.dto.Pager;

@Mapper
public interface IHostDao {

	List<Host> getHostList(Pager pager);

	int insertHost(Host host);

	int getHostCount();

	Host getHostDetail(String hostId);

	int updateHost(Host host);

	int deleteHost(String hostId);

}
