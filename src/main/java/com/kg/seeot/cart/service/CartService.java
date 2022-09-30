package com.kg.seeot.cart.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.kg.seeot.cart.dto.CartDTO;
import com.kg.seeot.product.dto.ProductOrderDTO;

public interface CartService {
	public int addCart(HttpServletRequest request,int productNo,String productSize, String productColor,String productStack);
	public ArrayList<CartDTO> getCart(Model model,String memberId);
	public int deleteOneCart(String memberId,int productNo);
	public int deleteChkCart(String memberId, int cartNum);
	public List<ProductOrderDTO> productOrder(HttpServletRequest req, String productColor, String productSize, String productStack);
	public void alldel(String memberId);
}