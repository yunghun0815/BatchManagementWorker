package com.company.myapp.controller;

import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.company.myapp.batch.BatchStatusCode;
import com.company.myapp.dto.BatGrpLog;
import com.company.myapp.dto.BatPrmLog;
import com.company.myapp.dto.Pager;
import com.company.myapp.service.ILogService;

@Controller
@RequestMapping("/log")
public class LogController {
	
	@Autowired
	ILogService logService;
	
	/**
	 * 로그 관리 페이지
	 * @param pageNo 페이지 번호
	 * @return
	 */
	@GetMapping("")
	public String getBatGrpLogList(@RequestParam(defaultValue = "1") int pageNo, Model model) {
		
		int batGrpLogSize = logService.getBatGrpLogCount();
		
		Pager pager = new Pager(8, 5, batGrpLogSize, pageNo);
		
		List<BatGrpLog> batGrpLogList = logService.getBatGrpLogList(pager);
		for(BatGrpLog batGrpLog : batGrpLogList) {
			batGrpLog.setBatGrpStCd(BatchStatusCode.codeToTitle(batGrpLog.getBatGrpStCd())); // 코드 -> 한글 메세지로 변환
		}
		
		model.addAttribute("batGrpLogList", batGrpLogList);
		model.addAttribute("pager", pager);
		model.addAttribute("menu", "log");
		return "log/log";
	}
	
	/**
	 * 로그 검색 결과 
	 * @param pageNo 페이지 번호
	 * @param log 검색어
	 * @param model
	 * @return
	 */
	@GetMapping("/search")
	public String searchBatGrpLog(@RequestParam(defaultValue = "1") int pageNo, BatGrpLog log, Model model, HttpServletRequest request) {
		// yyyy-mm-dd hh24:mm 으로 맞추기 위해 T 제거
		log.setBatBgngDtStart(log.getBatBgngDtStart().replaceFirst("T", " "));
		log.setBatBgngDtEnd(log.getBatBgngDtEnd().replaceFirst("T", " "));
		
		// 검색한 전체 그룹 로그 조회
		int batGrpLogSize = logService.getBatGrpLogCountBySearch(log);
		// 페이저 객체 생성
		Pager pager = new Pager(8, 5, batGrpLogSize, pageNo);
		// 페이징 처리해 조회
		List<BatGrpLog> batGrpLogList = logService.searchBatGrpLog(pager, log);
		
		for(BatGrpLog batGrpLog : batGrpLogList) {
			batGrpLog.setBatGrpStCd(BatchStatusCode.codeToTitle(batGrpLog.getBatGrpStCd())); // 코드 -> 한글 메세지로 변환
		}
		
		model.addAttribute("batGrpLogList", batGrpLogList);
		model.addAttribute("pager", pager);
		model.addAttribute("menu", "log");
		
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
		return "log/log";
	}
	
	/*	@ResponseBody
		@GetMapping("/program/list")
		public String getBatPrmLogList(@RequestParam(defaultValue = "1") int pageNo, Model model) {
	
			int batPrmLogSize = logService.getBatPrmLogCount();
			
			Pager pager = new Pager(10, 5, batPrmLogSize, pageNo);
			
			List<BatPrmLog> batPrmLogList = logService.getBatPrmLogList(pager);
			
			model.addAttribute("batPrmLogList", batPrmLogList);
			model.addAttribute("menu", "log");
			return "log/program";
		}*/
	
	@ResponseBody
	@GetMapping("/program/list") 
	public JSONObject getBatGrpLogDetail(String batGrpLogId) {
		
		List<BatGrpLog> batGrpLog = logService.getBatGrpLogDetailList(batGrpLogId);  // 로그ID에 대한 전체 그룹 리스트
		
		List<BatPrmLog> batPrmLogList = logService.getBatPrmLogListByBatGrpLogId(batGrpLogId, 0); // 첫 번째 프로그램 로그 리스트
		
		
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("batGrpLog", batGrpLog);
		jsonObj.put("batPrmLogList", batPrmLogList);
		
		return jsonObj;
	}
	
	@ResponseBody
	@GetMapping("/program/detail")
	public BatPrmLog getBatPrmLogDetail(String batGrpLogId, int batGrpRtyCnt, String batPrmId) {
		
		BatPrmLog batPrmLog = logService.getBatPrmLogDetail(batGrpLogId, batGrpRtyCnt, batPrmId);
		
		return batPrmLog;
	}
}
