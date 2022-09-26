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
	
	
	//productView에서 바로 구매하기
	@PostMapping("ordermain") 
	public String orderMain(int productNo,Model model, HttpServletRequest req, String productName, String productColor, String productSize , String productStack) {
		System.out.println("컨트롤러 동작 성공");

		HttpSession session = req.getSession();
		String memberId = (String)session.getAttribute("loginUser");
		os.productOrder(model, req, productColor, productSize, productStack);
		ms.getUser(model, memberId);
		return "/order/orderMain";


	}
	
	//들어오는 모든 주문처리
	@PostMapping(value = "orderchk", produces = "application/json; charset=utf-8")
	@ResponseBody
	public void orderchk(@RequestBody Map map,Model model, String memberId,HttpSession session) { 
		memberId = (String) session.getAttribute("loginUser");
		ArrayList name = (ArrayList) map.get("glist");
		ArrayList file = (ArrayList) map.get("gfile");
		ArrayList no = (ArrayList) map.get("gno");
		ArrayList stack = (ArrayList) map.get("gstack");
		ArrayList cost = (ArrayList) map.get("gcost");
		ArrayList size = (ArrayList) map.get("gsize");
		ArrayList color = (ArrayList) map.get("gcolor");
		session.setAttribute("orderdata", map);
		
		
		//결제성공시 주문데이터 DB(goods_order,order_history)에 저장
		OrderDTO dto = new OrderDTO();		
		OrderHistoryDTO hdto = new OrderHistoryDTO();
		for(int i =0; i<file.size();i++) {
			dto.setOrderNo(map.get("merchant_uid").toString());
			dto.setOrderPrice(Integer.parseInt(map.get("amount").toString()));
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
	}
	
	//결제완료후 직전에 결제한내용 출력
	@GetMapping("order")
	public String ordersuccess(HttpSession session,Model model,String memberId) {
		os.orderView(session, model, memberId);
		return "/order/order";
	}
	
	//order페이지에서 주문취소시 취소사유,회원아이디,주문번호 받아오는 페이지
	@PostMapping(value = "cancel", produces = "application/json; charset=utf-8")
	@ResponseBody
	public void cancel(HttpServletRequest request,@RequestBody Map data,String memberId,String reason) {
		String orderNo = (String) data.get("merchant_uid");
		reason = (String) data.get("reason");
		
		os.cancel(request,orderNo,memberId,reason);
	}
	
	@GetMapping("orderadmin")
	public String orderadmin(Model model,HttpServletRequest request) {
		model.getAttribute("cdto");
		OrderDTO odto = new OrderDTO();
		os.getAllOrders(request,model);
		return "/order/orderadmin";
	}
	
	@PostMapping(value = "cancelchk",produces = "application/json; charset=utf-8")
	@ResponseBody
	public void cancelchk(HttpServletRequest request,Model model,@RequestBody Map map,String memberId,String orderNo) {
		memberId = (String) map.get("memberId");
		orderNo = (String)map.get("orderNo");		
		os.getCancel(request, model, memberId, orderNo);
	}
	
	@PostMapping(value = "cancelOk", produces = "application/json; charset=utf-8")
	@ResponseBody
	public void cancelOk(HttpServletRequest request,@RequestBody Map data,String memberId,String reason) {
		String orderNo = (String) data.get("merchant_uid");
		os.cancel(request, orderNo, memberId, reason);
	}
	
	@PostMapping(value = "delevery",produces = "application/json; charset=utf-8" )
	@ResponseBody
	public void delevery(HttpServletRequest request,Model model,@RequestBody Map map,String orderNo) {
		orderNo = (String)map.get("orderNo");
		os.doDelevery(orderNo);
	}
	@PostMapping(value = "enddelevery",produces = "application/json; charset=utf-8" )
	@ResponseBody
	public void enddelevery(HttpServletRequest request,Model model,@RequestBody Map map,String orderNo) {
		orderNo = (String) map.get("orderNo");
		os.endDelevery(orderNo);
	}
	
	@GetMapping("getSearchList")
	@ResponseBody
	public ArrayList<OrderDTO> getSearchList(String type,String keyword,Model model) {
		OrderDTO dto = new OrderDTO();
		dto.setKeyword(keyword);
		dto.setType(type);
		return os.getSearchList(dto,type,keyword);
	}
	
	@PostMapping("sorting")
	@ResponseBody
	public ArrayList<OrderDTO> sorting(String sort) {
		switch(sort) {
		case "0" : return os.orderNoSorting_DESC();
		case "1" : return os.orderNoSorting_ASC();
		case "2" : return os.memberIdSorting_DESC();
		case "3" : return os.memberIdSorting_ASC();
		case "4" : return os.orderPriceSorting_DESC();
		case "5" : return os.orderPriceSorting_ASC();
		}
		return null;
	}
	
	//test용
	@PostMapping("test2")
	public String productOrder(Model model, HttpServletRequest req, String productName, String productColor, String productSize , String productStack) {
		os.productOrder(model, req, productColor, productSize, productStack);
		return "/order/test2";
	}
}