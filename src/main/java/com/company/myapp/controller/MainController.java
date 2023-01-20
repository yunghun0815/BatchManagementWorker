package com.company.myapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.company.myapp.batch.activeMQ.ActiveMQConfiguration;
import com.company.myapp.batch.activeMQ.EmailProducer;

@Controller
public class MainController {
	
	@GetMapping("/")
	public String main(Model model) {
		model.addAttribute("menu", "home");
		return "main";
	}
	
	@Autowired
	EmailProducer producer;
	
	@GetMapping("/test")
	public String test() {
		producer.sendMsg("admin@kcc.com", "테스트");
		
		return "test";
	}
}