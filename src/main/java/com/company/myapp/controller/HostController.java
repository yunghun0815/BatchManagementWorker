package com.company.myapp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.company.myapp.dto.HostDto;
import com.company.myapp.dto.PagerDto;
import com.company.myapp.service.IHostService;

@RequestMapping("/host")
@Controller
public class HostController {
	
	@Autowired
	IHostService hostService;
	
	@GetMapping("")
	public String hostList(@RequestParam(defaultValue = "1") int pageNo, Model model) {
		
//		PagerDto pagerDto = new PagerDto(10, 5, pageNo, pageNo);
//		List<HostDto> hostList = hostService.getHostList(pagerDto);
//		
//		model.addAttribute("hostList", hostList);
		
		return "host/host";
	}
	
}
