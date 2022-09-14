package com.kg.seeot.order.controller;

import java.util.ArrayList;
import java.util.HashMap;
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

import com.kg.seeot.member.service.MemberService;
import com.kg.seeot.order.dto.OrderDTO;
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
	
	
	@PostMapping(value = "orderchk", produces = "application/json; charset=utf-8")
	@ResponseBody
	public void orderchk(@RequestBody Map map, String memberId,HttpSession session) {
		memberId = (String) session.getAttribute("loginUser");
		System.out.println("컨트롤러 동작 성공");
		System.out.println("memberId : "+memberId);
		System.out.println("주문 컨트롤러 동작");
		System.out.println("map : "+map);
		HashMap pdata = new HashMap();
		ArrayList name = (ArrayList) map.get("glist");
		ArrayList file = (ArrayList) map.get("gfile");
		ArrayList no = (ArrayList) map.get("gno");
		ArrayList stack = (ArrayList) map.get("gstack");
		ArrayList cost = (ArrayList) map.get("gcost");
		
		System.out.println("각제품명 배열 : "+map.get("glist"));
		for(int i =0; i<name.size();i++) {
			System.out.println("제품이름"+i+" : "+name.get(i));			
		}				
		System.out.println("제품사진명 배열 : "+map.get("gfile"));
		for(int i =0; i<file.size();i++) {
			System.out.println("제품사진"+i+" : "+file.get(i));			
		}
		System.out.println("제품번호 배열 : "+map.get("gno"));		
		for(int i =0; i<no.size();i++) {
			System.out.println("제품번호"+i+" : "+no.get(i));
		}		
		System.out.println("각제품개수 배열 : "+map.get("gstack"));
		for(int i =0; i<stack.size();i++) {
			System.out.println("제품개수"+i+" : "+stack.get(i));
		}
		System.out.println("각 제품 가격 배열 : "+map.get("gcost"));
		for(int i =0; i<cost.size();i++) {
			System.out.println("제품가격"+i+" : "+cost.get(i));
		}
		
		System.out.println("주문번호 : "+map.get("merchant_uid"));
		System.out.println("간단한 제품명 : "+map.get("name"));
		System.out.println("총 가격 : "+map.get("amount"));
		System.out.println("구매자 이름 : "+map.get("buyer_name"));
		System.out.println("구매자 주소 : "+map.get("buyer_addr"));
		System.out.println("구매자 우편번호 : "+map.get("buyer_postcode"));
		//os.addOrder(memberId);
		session.setAttribute("orderdata", map);
		
				
	}
	@GetMapping("order")
	public String ordersuccess(HttpSession session,Model model,String memberId) {
		memberId = (String) session.getAttribute("loginUser");
		System.out.println("memberId : "+memberId);
		Map map = (Map) session.getAttribute("orderdata");
		model.addAttribute("order",map);
		System.out.println("넘겨준 세션값 : "+session.getAttribute("orderdata"));
		System.out.println("모든파일이름 : "+map.get("gfile"));
		ArrayList file = (ArrayList) map.get("gfile");
		
		for(int i =0; i<file.size();i++) {
			System.out.println("파일이름"+i+" : "+file.get(i));
		}
		model.addAttribute("result",file.size());
		System.out.println("model result : "+model.getAttribute("result"));
		System.out.println(model.getAttribute("result").getClass().getName());
		OrderDTO dto = new OrderDTO();
		
		for(int i =0; i<file.size();i++) {
			dto.setOrderNo((Integer.parseInt((String) map.get("merchant_uid"))));
			dto.setOrderPrice((map.get("amount"));// 09.14 dto추가해야함
		}
		
		
		//os.addOrder(memberId);
		return "/order/order";
	}
}
