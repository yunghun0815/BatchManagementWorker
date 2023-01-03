package com.company.myapp.controller;

import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.company.myapp.dto.BatGrpLog;
import com.company.myapp.dto.BatPrmLog;
import com.company.myapp.dto.Pager;
import com.company.myapp.service.ILogService;

@RequestMapping("/log")
@Controller
public class LogController {
	
	@Autowired
	ILogService logService;
	
	@GetMapping("/group/list")
	public String getBatGrpLogList(@RequestParam(defaultValue = "1") int pageNo, Model model) {
		
		int batGrpLogSize = logService.getBatGrpLogCount();
		
		Pager pager = new Pager(10, 5, batGrpLogSize, pageNo);
		
		List<BatGrpLog> batGrpLogList = logService.getBatGrpLogList(pager);
		
		model.addAttribute("batGrpLogList", batGrpLogList);
		return "log/group";
	}
	
	@GetMapping("/program/list")
	public String getBatPrmLogList(@RequestParam(defaultValue = "1") int pageNo, Model model) {

		int batPrmLogSize = logService.getBatPrmLogCount();
		
		Pager pager = new Pager(10, 5, batPrmLogSize, pageNo);
		
		List<BatPrmLog> batPrmLogList = logService.getBatPrmLogList(pager);
		
		model.addAttribute("batPrmLogList", batPrmLogList);
		
		return "log/program";
	}
	
	@ResponseBody
	@GetMapping("/group/detail") 
	public JSONObject getBatGrpLogDetail(String batGrpLogId, int batGrpRtyCnt) {
		
		BatGrpLog batGrpLog = logService.getBatGrpLogDetail(batGrpLogId, batGrpRtyCnt); 
		List<BatPrmLog> batPrmLogList = logService.getBatPrmLogListByBatGrpLogId(batGrpLogId);
		
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
