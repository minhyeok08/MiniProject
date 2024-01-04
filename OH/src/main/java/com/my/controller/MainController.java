package com.my.controller;

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
	
	@GetMapping("main/cart.do")
	public String main_cart() {
		return "cart";
	}
	
	
}
