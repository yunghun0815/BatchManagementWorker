package com.company.myapp.controller;

import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
		
		// 전체 호스트 수
		int hostSize = hostService.getHostCount();
		// 페이저 객체 생성
		Pager pager = new Pager(7, 5, hostSize, pageNo);
		// 페이징 처리 해 조회 
		List<Host> hostList = hostService.getHostList(pager);
		
		model.addAttribute("host", new Host());
		model.addAttribute("pager", pager);
		model.addAttribute("hostList", hostList);
		
		model.addAttribute("menu","host");
		return "host/host";
	}
	/**
	 * 호스트 검색 결과
	 * @param pageNo 페이지 번호
	 * @param host
	 * @return
	 */
	@GetMapping("/search")
	public String searchHost(@RequestParam(defaultValue = "1") int pageNo, Host host, Model model, HttpServletRequest request) {
		if(host.getSearchPt() != null && !host.getSearchPt().equals("")) {
			host.setHostPt(Integer.parseInt(host.getSearchPt()));
		}
		
		// 검색한 전체 호스트 수
		int hostSize = hostService.getHostCountBySearch(host);
		
		// 페이저 객체 생성
		Pager pager = new Pager(7, 5, hostSize, pageNo);
		// 페이징 처리 해 조회 
		List<Host> hostList = hostService.searchHost(pager, host);
		
		model.addAttribute("host", new Host());
		model.addAttribute("pager", pager);
		model.addAttribute("hostList", hostList);
		
		model.addAttribute("menu","host");
		
		// view 페이지 페이징 버튼 url 생성
		StringBuilder sb = new StringBuilder();
		
		Enumeration<String> paramKeys = request.getParameterNames();
		while(paramKeys.hasMoreElements()) {
			String key = paramKeys.nextElement();
			String value = request.getParameter(key);
			// 요청 파라미터 중 pageNo 제외 저장
			if(!key.equals("pageNo"))sb.append("&" + key + "=" + value);
		}
		model.addAttribute("search", sb.toString());
		
		return "host/host";
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
	 * 호스트 삭제 (사용여부를 N으로)
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
	
	@ResponseBody
	@GetMapping("/grp/cnt")
	public int getBatGrpCnt(String hostId) {
		
		int cnt = hostService.getBatGrpCntByHostId(hostId);
		
		return cnt;
	}
	
	@ResponseBody
	@PostMapping("/rollback")
	public void rollback(String hostId) {
		
		Host host = new Host();
		host.setHostId(hostId);
		host.setUseYn('Y');
		hostService.updateHost(host);
	}
}
