package com.kg.seeot.order.service;


import com.kg.seeot.order.dto.OrderDTO;
import com.kg.seeot.order.dto.OrderHistoryDTO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.kg.seeot.product.dto.ProductDTO;

public interface OrderService {
	public void addOrder(OrderDTO dto); //주문추가
	public void orderView(HttpSession session,Model model,String memberId);//주문확인
	public void productOrder(Model model, HttpServletRequest req, String productColor, // 주문상세데이터 수집
								String productSize, String productStack);
	public void addHiOrder(OrderHistoryDTO hdto); //주문내역추가
	public void cancel(HttpServletRequest request,String orderNo,String memberId,String reason); //주문취소
}
