package com.kg.seeot.cart.service;

import java.util.List;

import org.springframework.ui.Model;

import com.kg.seeot.cart.dto.CartDTO;

public interface CartService {
	public void addCart(int productNo);
	public CartDTO getCart(Model model,String memberId);
}
