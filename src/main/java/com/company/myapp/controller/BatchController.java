package com.company.myapp.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.company.myapp.batch.BatchServer;
import com.company.myapp.dto.BatGrp;
import com.company.myapp.dto.BatPrm;
import com.company.myapp.dto.Host;
import com.company.myapp.dto.Pager;
import com.company.myapp.service.IBatchService;
import com.company.myapp.service.IHostService;
import com.company.myapp.service.IJobService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/batch")
public class BatchController {

	@Autowired
	IBatchService batchService;
	@Autowired
	IJobService jobService;
	@Autowired
	IHostService hostService;
	@Autowired
	BatchServer batchServer;
	
	/**
	 * 처음에 배치관리 메뉴로 들어갔을때
	 * @param pageNo 페이지 수
	 *
	 * @return 배치관리페이지
	 */

	@GetMapping("")
	public String getBatGrpList(@RequestParam(defaultValue = "1") int pageNo, Model model) {
		
		//데이터의 전체 행수 가져온 후 페이징 처리
		int totalRows = batchService.getTotalGroupNum();
		Pager pager = new Pager(8, 5, totalRows, pageNo);
		
		//현재 페이지에 맞는 데이터 가져오기
		List<BatGrp> batGrpList = batchService.getBatGrpList(pager);
		
		Set<String> set = new HashSet<>();
		for(BatGrp test : batGrpList) {
			set.add(test.getHostId());
		}
		JSONObject connect = hostService.connectHost(set);
		
		for(BatGrp vo: batGrpList) {
			vo.setConn(connect.getString(vo.getHostId()));
			if(jobService.checkJob(vo.getBatGrpId())==true) vo.setRunCheck(true);
			else vo.setRunCheck(false);
		}
		List<Host> hostList = hostService.getHostList();
		model.addAttribute("hostList", hostList);
		model.addAttribute("pager", pager);
		model.addAttribute("batGrpList", batGrpList);
		model.addAttribute("menu","batch");
		return "board";
	}
	
	/**
	 * 배치그룹 상세페이지 모달창 -> json으로 return(비동기)
	 * @param grpId 그룹아이디
	 * @param model
	 * @return
	 */
	@ResponseBody
	@GetMapping("/group/detail")
	public BatGrp getBatGrpDetail(@RequestParam(value="grpId") String grpId, Model model) {
		BatGrp batGrp = batchService.getBatGrpDetail(grpId);
		List<BatPrm> batPrmList = batchService.getBatPrmList(grpId);
		batGrp.setPrmList(batPrmList);
		return batGrp;
	}
//	@GetMapping("/group/detail")
//	public String getBatGrpDetail(@RequestParam(value="grpId") String grpId, Model model) {
//		BatGrp batGrp = batchService.getBatGrpDetail(grpId);
//		List<BatPrm> batPrmList = batchService.getBatPrmList(grpId);
//		model.addAttribute("grp", batGrp);
//		model.addAttribute("prmList", batPrmList);
//		return "group/groupDetail";
//	}
	
	@ResponseBody
	@GetMapping("/path")
	public List<String> getPathListByGrpId(@RequestParam(value="grpId")String grpId){
		System.out.println(grpId);
		Host vo = hostService.getHostByBatGrpId(grpId);
		System.out.println(vo);
		List<String> pathList = batchServer.getPath(vo);
		System.out.println(pathList);
		return pathList;
	}
	
	@PostMapping("/group/insert")
	public String insertBatGrp(BatGrp vo) {
		System.out.println(vo);
		batchService.insertBatGrp(vo);
		return "redirect:/batch";
	}
	
	@PostMapping("/group/update")
	public String updateBatGrp(BatGrp vo) {
		batchService.updateBatGrp(vo);
		if(jobService.checkExistsJobByGrpId(vo.getBatGrpId())) {
			jobService.updateJob(vo);
		}
		return "redirect:/batch";
	}
	
	@GetMapping("/group/delete")
	public String deleteBatGrp(@RequestParam(value="grpId")String grpId) {
		jobService.pauseJob(grpId);
		jobService.removeJob(grpId);
		batchService.deleteBatGrp(grpId);
		return "redirect:/batch";
	}
	
	/**
	 * 검색 결과 return하는 메서드. 뷰->체크박스로 값 전달, mybatis->foreach,choose사용해서 필터링 
	 * @param keyword 검색값
	 * @param checkBox 검색할 컬럼
	 * @return
	 */
	@GetMapping("/group/search")
	public String searchBatGrp(@RequestParam(defaultValue = "1") int pageNo, 
			                          @RequestParam(value="keyword") String keyword,
			                             @RequestParam List<String> filtering, Model model){
		
		//데이터의 전체 행수 가져온 후 페이징 처리
		int totalRows = batchService.getTotalSearchNum(keyword, filtering);
		Pager pager = new Pager(5, 5, totalRows, pageNo);

		List<BatGrp> searchResult = batchService.searchBatGrp(pager, keyword, filtering);	
		
		model.addAttribute("pager", pager);
		model.addAttribute("batGrpList", searchResult);
		return "group/batchManagment";
	}

	
//	@GetMapping("/searchPage")
//	public String searchBatGrp(){
//		
//		return "group/search";
//	}
	
	@ResponseBody
	@GetMapping("/program")
	public List<BatPrm> getBatPrmList(String grpId){
		System.out.println(grpId);
		List<BatPrm> batPrmList = batchService.getBatPrmList(grpId);
		System.out.println(batPrmList);
		return batPrmList;
	}
	
	@ResponseBody
	@GetMapping("/program/detail")
	public BatPrm getBatPrmDetail(@RequestParam(value="prmId")String prmId) {
		return batchService.getBatPrmDetail(prmId);
	}
	
	@ResponseBody
	@PostMapping("/program/delete")
	public List<BatPrm> deleteBatPrm(@RequestParam(value="prmId")String prmId,
										@RequestParam(value="grpId")String grpId) {
		batchService.deleteBatPrm(prmId, grpId);
		return batchService.getBatPrmList(grpId);
	}
	
	@ResponseBody
	@PostMapping("/program/insert")
	public String insertBatPrm(BatPrm vo) {
		batchService.insertBatPrm(vo);
		return "redirect:/batch";
	} 
	
	/*
	 * @ResponseBody
	 * 
	 * @PostMapping("/program/update") public List<BatPrm> updateBatPrm(BatPrm vo) {
	 * batchService.updateBatPrm(vo); return
	 * batchService.getBatPrmList(vo.getBatGrpId()); }
	 */
	@PostMapping("/program/update")
	public String updateBatPrm(BatPrm vo) {
		batchService.updateBatPrm(vo);
		return "redirect:/batch";
	}

	@ResponseBody
	@PostMapping("/program/update/ord")
	public List<BatPrm> updateExcnOrd(@RequestBody BatGrp vo){
		batchService.updateExcnOrd(vo.getPrmList());
		return batchService.getBatPrmList(vo.getBatGrpId());
	}
	/**
	 * 배치그룹별 스케쥴러 실행 체크후 실행 및 중단
	 * @param grpId
	 */
	@ResponseBody
	@PostMapping("/Job/{grpId}")
	public void schedule(boolean execute, @PathVariable String grpId) {
		System.out.println(execute);
		//boolean check = jobService.checkJob(grpId);
		if (execute) {
			System.out.println("정지서비스");
			jobService.pauseJob(grpId);
		}
		else{

			System.out.println("시작서비스");
			jobService.startJob(grpId);
			
		}
	}

	@ResponseBody
	@PostMapping("/scheduler/start")
	public void startSchedule() {
		jobService.startSchedule();
	}

	@ResponseBody
	@PostMapping("/scheduler/shutdown")
	public void shutdownSchedule() {
		jobService.shutdownSchedule();
	}
	
	/**
	 * 그룹내 모든 프로그램 재실행
	 * @param batGrpLogId 그룹 로그 아이디
	 * @return
	 */
	@ResponseBody
	@PostMapping("/retry/all")
	public String retryAll(String batGrpLogId) {
		// 마지막 차수 조회
		String cmd = "all";
		log.info("전부 재실행");
		return jobService.retryJob(batGrpLogId, cmd);
	}
	
	/**
	 * 그룹내 실패한 프로그램 재실행
	 * @param batGrpLogId 그룹 로그 아이디
	 * @return
	 */	
	@ResponseBody
	@PostMapping("/retry/fail")
	public String retryFail(String batGrpLogId) {
		String cmd = "fail";
		log.info("실패한것만 재실행");
		return jobService.retryJob(batGrpLogId, cmd);
	}
	
//	@ResponseBody
//	@PostMapping("/job/start")
//	public void startJob(String grpId) {
//		jobService.addJob(grpId);
//		jobService.startJob(grpId);
//	}
//	
//	@ResponseBody
//	@PostMapping("/job/pause")
//	public void pauseJob(String grpId) {
//		jobService.pauseJob(grpId);
//	}
//	
//	@ResponseBody
//	@PostMapping("/job/add")
//	public void addJob(String grpId) {
//		jobService.addJob(grpId);
//	}
//	
//	@ResponseBody
//	@PostMapping("/job/remove")
//	public void removeJob(String grpId) {
//		jobService.removeJob(grpId);
//	}
}
