package com.kg.seeot.order.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("order")
public class OrderController {
	@GetMapping("test")
	public String test() {
		return "/order/test";
	}
	@PostMapping("test2")
	public String test2() {
		return "/order/test2";
	}
}
