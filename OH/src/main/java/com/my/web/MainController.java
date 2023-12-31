package com.my.web;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@CrossOrigin("*")
public class MainController {
	@GetMapping("main/main.do")
	public String main_main() {
		return "main";
	}
	
}
