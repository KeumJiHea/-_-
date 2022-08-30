package com.kg.seeot.cart.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("cart")
public class CartController {
	
	@PostMapping("mycart")
	public String mycart() {
		return "cart/mycart";
	}
}
