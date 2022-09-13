package com.kg.seeot.order.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.kg.seeot.product.dto.ProductDTO;

public interface OrderService {
	
	public void productOrder(Model model, HttpServletRequest req, String productColor, String productSize, String productStack);
	
}
