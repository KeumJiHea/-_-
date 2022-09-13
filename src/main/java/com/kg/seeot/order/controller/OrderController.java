package com.kg.seeot.order.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kg.seeot.member.service.MemberService;
import com.kg.seeot.order.service.OrderService;
import com.kg.seeot.product.service.ProductService;

@RestController
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
	
	
	@PostMapping(value = "orderchk", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map orderchk(@RequestBody Map map) {
		System.out.println("컨트롤러 동작 성공");
		
		System.out.println("주문 컨트롤러 동작");
		
		System.out.println("주문번호 : "+map.get("merchant_uid"));
		System.out.println("제품명 : "+map.get("name"));
		System.out.println("총 가격 : "+map.get("amount"));
		System.out.println("구매자 이름 : "+map.get("buyer_name"));
		System.out.println("구매자 주소 : "+map.get("buyer_addr"));
		System.out.println("구매자 우편번호 : "+map.get("buyer_postcode"));
		 
		return map;		//밑 함수에 데이터 옮겨야함 09.13
	}
	@GetMapping("ordersuccess")
	public void ordersuccess(Map map,Model model) {
		Map dto = orderchk(map);
		model.addAttribute("order",dto);
	}
}
