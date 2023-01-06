package com.company.myapp.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.company.myapp.dto.Host;
import com.company.myapp.dto.Pager;
import com.company.myapp.service.IBatchService;
import com.company.myapp.service.IHostService;

@Controller
@RequestMapping("/host")
public class HostController {
	
	@Autowired
	IHostService hostService;
	
	@Autowired
	IBatchService batchService;
	
	/**
	 * 호스트 관리 페이지
	 * @param pageNo 페이지 번호
	 */
	@GetMapping("")
	public String getHostList(@RequestParam(defaultValue = "1") int pageNo, Model model) {
		
		int hostSize = hostService.getHostCount();
		
		Pager pager = new Pager(10, 5, hostSize, pageNo);
		
		List<Host> hostList = hostService.getHostList(pager);
		
		model.addAttribute("host", new Host());
		model.addAttribute("pager", pager);
		model.addAttribute("hostList", hostList);
		
		model.addAttribute("menu","host");
		return "host/host";
	}
	
	/**
	 * 호스트 상세 정보
	 * @param hostId 호스트 아이디
	 */
	@ResponseBody
	@GetMapping("/detail")
	public Host getHostDetail(String hostId) {
		Host host = hostService.getHostDetail(hostId);
		
		return host;
	}
	
	/**
	 * 호스트 저장 
	 * @param hostNm 호스트명
	 * @param hostIp 호스트 아이피
	 * @param hostPt 호스트 포트
	 */
	@ResponseBody
	@PostMapping("/insert")
	public List<ObjectError> insertHost(@ModelAttribute("host") @Valid Host host, BindingResult result) {
		
		if(result.hasErrors()) {
			return result.getAllErrors();
		}
		hostService.insertHost(host);
		return null;
	}
	
	/**
	 * 호스트 수정
	 * @param hostId 호스트 아이디
	 * @param hostNm 호스트명
	 * @param hostIp 호스트 아이피
	 * @param hostPt 호스트 포트
	 */
	@ResponseBody
	@PostMapping("/update")
	public List<ObjectError> updateHost(@ModelAttribute("host") @Valid Host host, BindingResult result) {
		if(result.hasErrors()) {
			return result.getAllErrors();
		}
		hostService.updateHost(host);
		return null;
	}
	
	/**
	 * 호스트 삭제 
	 * @param hostId
	 */
	@ResponseBody
	@PostMapping("/delete")
	public void deleteHost(String hostId) {
		hostService.deleteHost(hostId);
		
		List<String> grpIdList = batchService.getBatGrpIdListByHostId(hostId);
		
		for(String grpId : grpIdList) {
			batchService.deleteBatGrp(grpId);
		}
	}
}
