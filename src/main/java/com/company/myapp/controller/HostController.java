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
import com.company.myapp.service.IHostService;

@RequestMapping("/host")
@Controller
public class HostController {
	
	@Autowired
	IHostService hostService;
	
	@GetMapping("")
	public String hostList(@RequestParam(defaultValue = "1") int pageNo, Model model) {
		
		int hostCount = hostService.getHostCount();
		
		Pager pager = new Pager(10, 5, hostCount, pageNo);
		
		List<Host> hostList = hostService.getHostList(pager);
		
		model.addAttribute("host", new Host());
		model.addAttribute("pager", pager);
		model.addAttribute("hostList", hostList);
		
		return "host/host";
	}
	
	@ResponseBody
	@GetMapping("/detail")
	public Host hostDetail(String hostId) {
		Host host = hostService.getHostDetail(hostId);
		
		return host;
	}
	
	@ResponseBody
	@PostMapping("/insert")
	public List<ObjectError> insertHost(@ModelAttribute("host") @Valid Host host, BindingResult result) {
		
		if(result.hasErrors()) {
			return result.getAllErrors();
		}
		hostService.insertHost(host);
		return null;
	}
	
	@ResponseBody
	@PostMapping("/update")
	public List<ObjectError> updateHost(@ModelAttribute("host") @Valid Host host, BindingResult result) {
		if(result.hasErrors()) {
			return result.getAllErrors();
		}
		hostService.updateHost(host);
		return null;
	}
	
	@ResponseBody
	@PostMapping("/delete")
	public void deleteHost(String hostId) {
		hostService.deleteHost(hostId);
	}
}
