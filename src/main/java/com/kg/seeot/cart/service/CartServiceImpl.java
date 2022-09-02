package com.kg.seeot.cart.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.kg.seeot.cart.dto.CartDTO;
import com.kg.seeot.mybatis.cart.CartMapper;

@Service
public class CartServiceImpl implements CartService{
	@Autowired CartMapper cm;

	@Override
	public void addCart(int productNo) {
		System.out.println("productNo : "+productNo);
		cm.addCart_p(productNo);
		//임시 유저데이터 삽입
		System.out.println("카트 데이터 주입성공");
	}

	@Override
	public ArrayList<CartDTO> getCart(Model model,String memberId) {
		ArrayList<CartDTO> list = new ArrayList<CartDTO>();		
		System.out.println("memberId : "+memberId);
		list = cm.getCart(memberId);
		model.addAttribute("cart",list);
		
		return list;
	}
	
	
}
