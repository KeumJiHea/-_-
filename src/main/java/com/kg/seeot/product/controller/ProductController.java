package com.kg.seeot.product.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("goods")
public class ProductController {
	@GetMapping("list?product_categorie=")
	public String list() {
		return "product/product";
	}
}
