package com.kg.seeot.order.service;


import com.kg.seeot.order.dto.OrderDTO;
import com.kg.seeot.order.dto.OrderHistoryDTO;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.kg.seeot.product.dto.ProductDTO;

public interface OrderService {
	public void addOrder(OrderDTO dto); //주문추가
	public void orderView(HttpSession session,Model model,String memberId);//직전주문확인
	public void productOrder(Model model, HttpServletRequest req, String productColor, // 주문상세데이터 수집
								String productSize, String productStack);
	public void addHiOrder(OrderHistoryDTO hdto); //주문내역추가
	
	public void getOrderHistorys(Model model,String memberId);
	public void getOrder(Model model,String memberId,String orderNo);
	public void getOrders(Model model,String memberId);
	public ArrayList<OrderDTO> getAllOrders(HttpServletRequest request,Model model,int num);
	
	public void cancel(HttpServletRequest request,String orderNo,String memberId,String reason); //주문취소
	public void nonCancel(HttpServletRequest request,String orderNo); //주문취소를 취소
	public void getCancel(HttpServletRequest request,Model model,String memberId,String orderNo);
	public void doDelevery(String orderNo);
	public void endDelevery(String orderNo);
	
	public ArrayList<OrderDTO> getSearchList(OrderDTO dto,String type,String keyword);
	public ArrayList<OrderHistoryDTO> getStatusList(OrderDTO dto, String type, String memberId);
	public ArrayList<OrderDTO> orderNoSorting_ASC();
	public ArrayList<OrderDTO> orderNoSorting_DESC();
	public ArrayList<OrderDTO> memberIdSorting_ASC();
	public ArrayList<OrderDTO> memberIdSorting_DESC();
	public ArrayList<OrderDTO> orderPriceSorting_ASC();
	public ArrayList<OrderDTO> orderPriceSorting_DESC();
}
