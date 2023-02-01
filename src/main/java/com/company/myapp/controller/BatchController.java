package com.company.myapp.controller;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
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

/**
 * 배치 관리 메뉴 컨트롤러 uri는 '/batch'로 시작
 */

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

	/*** 배치 그룹 ***/

	/**
	 * 배치 관리 메뉴 메인 페이지
	 * 
	 * @param pageNo 현재페이지
	 */
	@GetMapping("")
	public String getBatGrpList(@RequestParam(defaultValue = "1") int pageNo, Model model) {

		// 데이터의 전체 행수 가져온 후 페이징 처리
		int totalRows = batchService.getTotalGroupNum();
		Pager pager = new Pager(8, 5, totalRows, pageNo);

		// 현재 페이지에 맞는 데이터 가져오기
		List<BatGrp> batGrpList = batchService.getBatGrpList(pager);

		// Set으로 호스트Id 중복제거 한 후 연결상태 확인
		Set<String> set = new HashSet<>();
		for (BatGrp test : batGrpList) {
			set.add(test.getHostId());
		}
		Map<String, String> connect = hostService.connectHost(set);

		// 위에서 받아온 배치 그룹 리스트에 연결/실행상태 체크 후 세팅
		for (BatGrp vo : batGrpList) {
			String conn = connect.get(vo.getHostId()) != null ? connect.get(vo.getHostId()) : "off";
			vo.setConn(conn);
			if (jobService.checkExistsJobByGrpId(vo.getBatGrpId()) == true)
				vo.setRunCheck(true);
			else
				vo.setRunCheck(false);
		}

		// 그룹 등록할 때 필요한 등록된 호스트 리스트
		List<Host> hostList = hostService.getHostList();
		
		model.addAttribute("group", new BatGrp());
		model.addAttribute("hostList", hostList);
		model.addAttribute("pager", pager);
		model.addAttribute("batGrpList", batGrpList);
		model.addAttribute("menu", "batch");
		return "batch/batch";
	}

	/**
	 * 배치그룹 상세페이지 모달창(비동기 작업)
	 * 
	 * @param grpId 그룹아이디
	 * @return 배치그룹DTO
	 */
	@ResponseBody
	@GetMapping("/group/detail")
	public BatGrp getBatGrpDetail(@RequestParam(value = "grpId") String batGrpId, Model model) {
		// 그룹ID를 받아서 그룹 상세정보 및 등록된 프로그램 리스트 가져오기
		BatGrp batGrp = batchService.getBatGrpDetail(batGrpId);
		List<BatPrm> batPrmList = batchService.getBatPrmList(batGrpId);
		batGrp.setPrmList(batPrmList);
		return batGrp;
	}

	/**
	 * 배치그룹 등록
	 */
	@ResponseBody
	@PostMapping("/group/insert")
	public List<ObjectError> insertBatGrp(@Valid BatGrp vo, BindingResult result) {
		if(result.hasErrors()) {
			return result.getAllErrors();
		}
		batchService.insertBatGrp(vo);
		return null;
	}

	/**
	 * 배치그룹에 대한 정보 업데이트 및 Job에 대한 업데이트 실행
	 */
	@ResponseBody
	@PostMapping("/group/update")
	public List<ObjectError> updateBatGrp(@Valid BatGrp vo, BindingResult result) {
		System.out.println("!!!!!!!!!!!!!!!!!!!! 업데이트 시작" + vo);
		if(result.hasErrors()) {
			return result.getAllErrors();
		}
		batchService.updateBatGrp(vo);
		// 만약 Job에 해당 그룹이 등록되어 있다면 Job에도 업데이트 실행
		if (jobService.checkExistsJobByGrpId(vo.getBatGrpId())) {
			System.out.println(vo.getBatGrpId());
			jobService.updateJob(vo);
		}
		return null;
	}

	/**
	 * 스케줄링 일시중지 후 Job에서 그룹정보 삭제한 후, 해당 배치그룹 정보를 DB에서 삭제
	 */
	@PostMapping("/group/delete")
	public String deleteBatGrp(@RequestParam(value = "grpId") String batGrpId) {
		// 스케줄링 일시중지
		jobService.pauseJob(batGrpId);
		// Job 정보 삭제
		jobService.removeJob(batGrpId);
		// 배치 그룹 정보(+소속 프로그램) 삭제
		batchService.deleteBatGrp(batGrpId);
		return "redirect:/batch";
	}

	/**
	 * 각 속성별 키워드를 통해 검새
	 * 
	 * @param keyword  검색값
	 * @param checkBox 검색할 컬럼
	 * @return
	 */
	@GetMapping("/group/search")
	public String searchBatGrp(@RequestParam(defaultValue = "1") int pageNo, BatGrp vo, Model model,
			HttpServletRequest request) {
		// 데이터의 전체 행수 가져온 후 페이징 처리
		int totalRows = batchService.getTotalSearchNum(vo);
		Pager pager = new Pager(8, 5, totalRows, pageNo);

		// 검색된 배치그룹리스트
		List<BatGrp> searchResult = batchService.searchBatGrp(pager, vo);

		// Set으로 호스트Id 중복제거 한 후 연결상태 확인
		Set<String> set = new HashSet<>();
		for (BatGrp test : searchResult) {
			set.add(test.getHostId());
		}
		Map<String, String> connect = new HashMap<>();
		
		if(!vo.getUseYn().equals("N"))connect = hostService.connectHost(set);

		// 위에서 받아온 배치 그룹 리스트에 연결/실행상태 체크 후 세팅
		for (BatGrp grpVo : searchResult) {
			String conn = connect.get(grpVo.getHostId()) != null ? connect.get(grpVo.getHostId()) : "off";
			grpVo.setConn(conn);
			if (jobService.checkExistsJobByGrpId(grpVo.getBatGrpId()) == true)
				grpVo.setRunCheck(true);
			else
				grpVo.setRunCheck(false);
		}
		// 그룹 등록할 때 필요한 등록된 호스트 리스트
		List<Host> hostList = hostService.getHostList();
		
		model.addAttribute("group", new BatGrp());
		model.addAttribute("hostList", hostList);
		model.addAttribute("pager", pager);
		model.addAttribute("batGrpList", searchResult);

		model.addAttribute("menu", "batch");

		// view 페이지 페이징 버튼 url 생성
		StringBuilder sb = new StringBuilder();
		String use = "";
		Enumeration<String> paramKeys = request.getParameterNames();
		while (paramKeys.hasMoreElements()) {
			String key = paramKeys.nextElement();
			String value = request.getParameter(key);
			// 요청 파라미터 중 pageNo 제외 저장
			if (!key.equals("pageNo"))
				sb.append("&" + key + "=" + value);
			if(key.equals("useYn"))
				use = value;
		}
		model.addAttribute("search", sb.toString( ));
		model.addAttribute("useYn", use);
		return "batch/batch";
	}

	/*** 배치 프로그램 ***/

	/**
	 * 배치그룹Id에 등록된 전체 프로그램 리스트 가져오기(비동기작업)
	 */
	@ResponseBody
	@GetMapping("/program")
	public List<BatPrm> getBatPrmList(@RequestParam(value = "grpId") String batGrpId) {
		List<BatPrm> batPrmList = batchService.getBatPrmList(batGrpId);
		return batPrmList;
	}

	/**
	 * 프로그램의 경우, 선택된 호스트Id별로 접근 가능한 파일 경로 리스트 return(비동기작업)
	 */
	@ResponseBody
	@GetMapping("/path")
	public Map<String, Object> getPathListByGrpId(@RequestParam(value = "grpId") String batGrpId, @RequestParam(value ="path") String path) {
		// 배치그룹Id로 호스트DTO 가져오기
		Host vo = hostService.getHostByBatGrpId(batGrpId);
		// 위에서 가져온 호스트DTO를 통해 서버에서 접근 가능한 파일의 경로 리스트 가져오기
		Map<String, Object> result = batchServer.getPath(vo, path);
		
		return result;
	}

	@GetMapping("/popup/path")
	public String pathPopup() {
		return "/batch/agentPath";
	}
	
	/**
	 * 프로그램 상세 페이지 모달창(비동기작업)
	 */
	@ResponseBody
	@GetMapping("/program/detail")
	public BatPrm getBatPrmDetail(@RequestParam(value = "prmId") String batPrmId) {
		return batchService.getBatPrmDetail(batPrmId);
	}

	/**
	 * 배치프로그램 등록 등록된 후 돌아가는 페이지에 따라 향후 변동 가능성 있음
	 */
	@ResponseBody
	@PostMapping("/program/insert")
	public List<ObjectError> insertBatPrm(@Valid BatPrm vo, BindingResult result) {
		if(result.hasErrors()) {
			return result.getAllErrors();
		}
		batchService.insertBatPrm(vo);
		return null;
	}

	/**
	 * 배치프로그램 정보 업데이트 수정된 후 돌아가는 페이지에 따라 향후 변동 가능성 있음
	 */
	/*
	 * @ResponseBody
	 * 
	 * @PostMapping("/program/update") public List<BatPrm> updateBatPrm(BatPrm vo) {
	 * batchService.updateBatPrm(vo); return
	 * batchService.getBatPrmList(vo.getBatGrpId()); }
	 */
	@ResponseBody
	@PostMapping("/program/update")
	public List<ObjectError> updateBatPrm(@Valid BatPrm vo, BindingResult result) {
		if(result.hasErrors()) {
			return result.getAllErrors();
		}
		batchService.updateBatPrm(vo);
		return null;
	}

	/**
	 * 각 그룹별 프로그램 순서를 사용자 임의로 변경한 후, 업데이트된 프로그램 리스트 반환
	 */
	@ResponseBody
	@PostMapping("/program/update/ord")
	public void updateExcnOrd(@RequestBody BatGrp vo) {
		batchService.updateExcnOrd(vo.getPrmList());
	}

	/**
	 * 등록된 프로그램을 삭제한 후 프로그램 리스트 반환
	 * 
	 * @param prmId 삭제할 프로그램Id
	 * @param grpId 프로그램이 삭제된 후, 프로그램 순서 변동 및 프로그램 리스트 반환에 필요한 그룹Id
	 * @return
	 */
	@ResponseBody
	@PostMapping("/program/delete")
	public void deleteBatPrm(@RequestParam(value = "prmId") String batPrmId,
			@RequestParam(value = "grpId") String batGrpId) {
		batchService.deleteBatPrm(batPrmId, batGrpId);
	}

	/*** Job ***/

	/**
	 * 스케줄링 실행
	 */
	@ResponseBody
	@PostMapping("/scheduler/start")
	public void startSchedule() {
		log.info("스케줄링 시작");
		jobService.startSchedule();
	}

	/**
	 * 스케줄링 정지
	 */
	@ResponseBody
	@PostMapping("/scheduler/shutdown")
	public void shutdownSchedule() {
		log.info("스케줄링 정지");
		jobService.shutdownSchedule();
	}

	/**
	 * 배치그룹별 Job 실행 체크후 실행 및 중단
	 */
	@ResponseBody
	@PostMapping("/Job/{batGrpId}")
	public void schedule(boolean execute, @PathVariable String batGrpId) {
		if (execute) {
			jobService.pauseJob(batGrpId);
		} else {
			jobService.startJob(batGrpId);
		}
	}

	/**
	 * 그룹내 모든 프로그램 재실행
	 * 
	 * @param batGrpLogId 그룹 로그 아이디
	 * @return
	 */
	@ResponseBody
	@PostMapping("/retry/{cmd}")
	public void retryAll(@RequestBody Map<String, String> param, @PathVariable String cmd) {
		
		jobService.manuallyRun(param.get("batGrpLogId"), cmd, param);
	}

	/**
	 * 그룹 수동 실행
	 */
	@ResponseBody
	@PostMapping("/group/run")
	public void manuallyRun(String batGrpId) {
		jobService.manuallyRun(batGrpId);
	}
	
	/**
	 * 연결 상태 체크
	 */
	@ResponseBody
	@GetMapping("/health")
	public Map<String, String> checkHealth(@RequestParam(value="batGrpId")String batGrpId) {
		
		Host host = hostService.getHostByBatGrpId(batGrpId);
		List<Host> hostList = new ArrayList<>(); 
		hostList.add(host);

		Map<String ,String> connect = batchServer.healthCheck(hostList, new Hashtable<String,String>(), 0);

		String conn = connect.get(host.getHostId()) != null ? connect.get(host.getHostId()) : "off";
		
		Map<String, String> result = new HashMap<>();
		result.put("hostId", host.getHostId());
		result.put("conn", conn);
		return result;
	}
	
	/**
	 * 삭제한 그룹 복구
	 */
	@ResponseBody
	@GetMapping("/rollback")
	public boolean rollbackGroup(@RequestParam(value="batGrpId")String batGrpId) {
		boolean checkHost = false;
		if(hostService.getHostByBatGrpId(batGrpId).getUseYn() == 'Y') {
			batchService.rollback(batGrpId);
			checkHost = true;
		}
		return checkHost;
	}
	
	@ResponseBody
	@GetMapping("/checkName")
	public boolean checkGrpNm(@RequestParam(value="grpNm")String batGrpNm) {
		return batchService.checkGrpNm(batGrpNm);
	}
}
