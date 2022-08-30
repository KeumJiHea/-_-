package com.kg.seeot.order.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("order")
public class OrderController {
	@GetMapping("goods")
	public String orderMain() {
		return "/order/orderMain";
	}
	@PostMapping("orderchk")
	public String orderchk() {
		return "/order/orderchk";
	}
}
