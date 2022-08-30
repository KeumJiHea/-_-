package com.kg.seeot.cart.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kg.seeot.cart.service.CartService;

@RestController
@RequestMapping("cart")
public class CartController {
	@Autowired CartService cs;
	
	
	@GetMapping("addcart")
	public void addCart(HttpServletRequest request,HttpServletResponse response,int productNo) throws Exception {
		System.out.println("컨트롤러 동작 성공");
		cs.addCart(productNo);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('장바구니에 추가되었습니다!'); history.go(-1);</script>");
		out.flush(); 
		
	}
	
	@GetMapping("mycart")
	public String mycart() {
		
		return "cart/mycart";
	}
}
