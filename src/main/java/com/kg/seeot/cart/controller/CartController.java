package com.kg.seeot.cart.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

import com.kg.seeot.cart.service.CartService;
import com.kg.seeot.common.SessionName;
import com.kg.seeot.member.service.MemberService;

@Controller
@RequestMapping("cart")
public class CartController {
	@Autowired CartService cs;
	@Autowired SessionName sn;
	@Autowired MemberService ms;
	
	
	@PostMapping(value = "addcart")
	@ResponseBody
	public void addCart(HttpServletRequest request,HttpServletResponse response,String productName, String productColor, String productSize , String productStack) throws Exception {
		System.out.println("장바구니 등록 컨트롤러 동작 성공");
		System.out.println("productStack : "+productStack);
		int productNo = Integer.parseInt(request.getParameter("productNo"));
		cs.addCart(request, productNo,productStack,productSize,productColor);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('장바구니에 추가되었습니다!'); history.go(-1);</script>");
		out.flush(); 
		
	}
	
	@GetMapping("mycart")
	public String mycart(String memberId,Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();
		memberId = (String)session.getAttribute("loginUser");
		ms.getUser(model, memberId);
		cs.getCart(model, memberId);
		return "cart/mycart.page";
	}
	
	@GetMapping("cartdeleteOne")
	public void deleteOne(String memberId, int productNo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("장바구니 개별삭제 컨트롤러 동작 성공");
		System.out.println("id : "+memberId);
		System.out.println("no : "+productNo);
		
		int result = cs.deleteOneCart(memberId,productNo);		 
	}
	
	@PostMapping("cartchkdel")
	@ResponseBody
	public void cartchkdel(HttpServletRequest request,String memberId,HttpServletResponse response) throws Exception {
		System.out.println("선택삭제 컨트롤러 동작 성공");
		int cartNum;
		String[] cartlist = request.getParameterValues("cartlist");
		for(int i =0; i<cartlist.length; i++) {
			System.out.println("cartlist : "+cartlist[i]);
			cartNum = Integer.parseInt(cartlist[i]);			
			cs.deleteChkCart(memberId, cartNum);
		}
		System.out.println("id : "+memberId);		
	}
}
