package com.company.myapp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.company.myapp.batch.BatchServer;
import com.company.myapp.dto.Host;

@Controller
public class MainController {
	
	@GetMapping("/")
	public String main(Model model) {
		model.addAttribute("menu", "home");
		return "main";
	}
	
	@GetMapping("/test")
	public String test() {
		
		return "drag";
	}
	
	@Autowired
	BatchServer batchServer;
	
	@ResponseBody
	@GetMapping("/path")
	public Map<String, Object> path(Host host,String path) {
//		Host host = new Host();
//		host.setHostIp("localhost");
//		host.setHostPt(50001);
		Map<String, Object> map = batchServer.getPath(host, path);
		/*System.out.println(map.get("dir"));
		System.out.println(map.get("file"));*/
		
		return map;
	}
}