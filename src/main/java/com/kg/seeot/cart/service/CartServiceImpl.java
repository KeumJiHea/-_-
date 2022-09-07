package com.kg.seeot.cart.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.kg.seeot.cart.dto.CartDTO;
import com.kg.seeot.mybatis.cart.CartMapper;

@Service
public class CartServiceImpl implements CartService{
	@Autowired CartMapper cm;

	@Override
	public void addCart(int productNo,int orderStack) {
		System.out.println("productNo : "+productNo);
		System.out.println("productStack : "+orderStack);
		int result = 0;
		cm.addCart_p(productNo);
		result = cm.addOrderStack(orderStack, productNo);
		if(result==1) {
			System.out.println("카트 데이터 주입성공");
			System.out.println("orderstack : "+orderStack);
		}
	}

	@Override
	public ArrayList<CartDTO> getCart(Model model,String memberId) {
		ArrayList<CartDTO> list = new ArrayList<CartDTO>();		
		list = cm.getCart(memberId);
		model.addAttribute("cart",list);
		
		return list;
	}

	@Override
	public int deleteOneCart(String memberId, int productNo) {
		int result = cm.deleteCartOne(memberId,productNo);
		return result;
	}

	@Override
	public int deleteChkCart(String memberId,int cartNum) {
		int result = cm.deleteChkCart(memberId,cartNum);
		return result;
	}
	
	
}
