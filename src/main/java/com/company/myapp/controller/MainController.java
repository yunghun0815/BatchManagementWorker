package com.company.myapp.controller;

import java.io.IOException;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.company.myapp.batch.BatchServer;
import com.company.myapp.dto.Host;

@Controller
public class MainController {
	@GetMapping("/")
	public String main() {
		
		return "main";
	}
	
	
	@Autowired
	BatchServer batchServer;
	
	
	@GetMapping("/start")
	public String start() throws IOException {
		
		batchServer.start();
		
		return "";
	}
	
	@GetMapping("/test")
	public String test() {
		Host host = new Host();
		host.setHostIp("localhost");
		host.setHostPt(50001);
		
		JSONObject json = new JSONObject();
		json.put("batGrpId", "grp001");
		json.put("batGrpLogId", "grl001");
		json.put("batGrpRtyCnt", 0);
		json.put("batPrmId", "prm001");
		json.put("param", "test");
		json.put("path", "/test");
		
		batchServer.sendMessage(host, json);
		
		return "";
	}
}