package com.kg.seeot.order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kg.seeot.member.service.MemberService;
import com.kg.seeot.order.service.OrderService;
import com.kg.seeot.product.service.ProductService;

@Controller
@RequestMapping("order")
public class OrderController {
	@Autowired OrderService os;
	@Autowired ProductService ps;
	@Autowired MemberService ms;
	
	@GetMapping("ordermain")
	public String orderMain(Model model,int productNo) {
		System.out.println("컨트롤러 동작 성공");
		ps.productView(model, productNo);
		return "/order/orderMain";
	}
	@GetMapping("cartorder")
	public String cartOrder(Model model,String memberId) {
		
		return "/order/cartorder";
	}
	@PostMapping("orderchk")
	public String orderchk() {
		System.out.println("컨트롤러 동작 성공");
		return "/order/orderchk";
		
	}
}
