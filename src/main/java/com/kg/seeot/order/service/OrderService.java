package com.kg.seeot.order.service;


import com.kg.seeot.order.dto.OrderDTO;
import com.kg.seeot.order.dto.OrderHistoryDTO;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.kg.seeot.product.dto.ProductDTO;

public interface OrderService {
	public void addOrder(OrderDTO dto);
	public void productOrder(Model model, HttpServletRequest req, String productColor, String productSize, String productStack);
	public void addHiOrder(OrderHistoryDTO hdto);
	public void cancle(HttpServletRequest request,String orderNo,String memberId);
}
