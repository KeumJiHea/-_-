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
import com.kg.seeot.order.dto.OrderHistoryDTO;
import com.kg.seeot.order.service.OrderService;
import com.kg.seeot.product.dto.ProductDTO;
import com.kg.seeot.product.service.ProductService;

@Controller
@RequestMapping("order")
public class OrderController {
	@Autowired OrderService os;
	@Autowired ProductService ps;
	@Autowired MemberService ms;
	
	@PostMapping("ordermain")
	public String orderMain(int productNo,Model model, HttpServletRequest req, String productName, String productColor, String productSize , String productStack) {
		System.out.println("컨트롤러 동작 성공");
		HttpSession session = req.getSession();
		String memberId = (String)session.getAttribute("loginUser");
		os.productOrder(model, req, productColor, productSize, productStack);
		ms.getUser(model, memberId);
		return "/order/orderMain";
	}
	
	
	@PostMapping(value = "orderchk", produces = "application/json; charset=utf-8")
	@ResponseBody
	public void orderchk(@RequestBody Map map, String memberId,HttpSession session) { //0919 개별결제 해결해야함
		memberId = (String) session.getAttribute("loginUser");
		ArrayList name = (ArrayList) map.get("glist");
		ArrayList file = (ArrayList) map.get("gfile");
		ArrayList no = (ArrayList) map.get("gno");
		ArrayList stack = (ArrayList) map.get("gstack");
		ArrayList cost = (ArrayList) map.get("gcost");
		session.setAttribute("orderdata", map);				
	}
	
	@GetMapping("order")
	public String ordersuccess(HttpSession session,Model model,String memberId) {
		memberId = (String) session.getAttribute("loginUser");
		Map map = (Map) session.getAttribute("orderdata");
		model.addAttribute("order",map);
		ArrayList name = (ArrayList) map.get("glist");
		ArrayList file = (ArrayList) map.get("gfile");
		ArrayList no = (ArrayList) map.get("gno");
		ArrayList stack = (ArrayList) map.get("gstack");
		ArrayList cost = (ArrayList) map.get("gcost");
		ArrayList size = (ArrayList) map.get("gsize");
		ArrayList color = (ArrayList) map.get("gcolor");
		
		model.addAttribute("result",file.size());
		
		OrderDTO dto = new OrderDTO();		
		OrderHistoryDTO hdto = new OrderHistoryDTO();
		for(int i =0; i<file.size();i++) {
			dto.setOrderNo(map.get("merchant_uid").toString());
			dto.setOrderPrice(Integer.parseInt(map.get("amount").toString()));// 09.14 dto추가해야함
			dto.setProductNo(Integer.parseInt(no.get(i).toString()));
			dto.setProductPrice(Integer.parseInt(cost.get(i).toString()));
			dto.setOrderStack(Integer.parseInt(stack.get(i).toString()));
			dto.setProductColor(color.get(i).toString());
			dto.setProductSize(Integer.parseInt(size.get(i).toString()));
			dto.setOrderAddr1(map.get("buyer_postcode").toString());
			dto.setOrderAddr2(map.get("buyer_addr").toString());
			dto.setProductName(name.get(i).toString());
			dto.setProductFile(file.get(i).toString());
			dto.setMemberId(memberId);
			os.addOrder(dto);
			hdto.setHiMemberId(dto.getMemberId());
			hdto.setHiOrderAddr1(dto.getOrderAddr1());
			hdto.setHiOrderAddr2(dto.getOrderAddr2());
			hdto.setHiOrderNo(dto.getOrderNo());
			hdto.setHiOrderPrice(dto.getOrderPrice());
			hdto.setHiOrderStack(dto.getOrderStack());
			hdto.setHiOrderStatus(1);
			hdto.setHiProductColor(dto.getProductColor());
			hdto.setHiProductFile(dto.getProductFile());
			hdto.setHiProductName(dto.getProductName());
			hdto.setHiProductNo(dto.getProductNo());
			hdto.setHiProductPrice(dto.getProductPrice());
			hdto.setHiProductSize(dto.getProductSize());	
			os.addHiOrder(hdto);
		}
		return "/order/order";
	}
	
	@PostMapping("test2")
	public String productOrder(Model model, HttpServletRequest req, String productName, String productColor, String productSize , String productStack) {

		os.productOrder(model, req, productColor, productSize, productStack);
		return "/order/test2";
	}
	
	@PostMapping(value = "cancel", produces = "application/json; charset=utf-8")
	@ResponseBody
	public void cancel(HttpServletRequest request,@RequestBody Map data,String memberId) {
		String orderNo = (String) data.get("merchant_uid");
		os.cancle(request,orderNo,memberId);
	}
}
