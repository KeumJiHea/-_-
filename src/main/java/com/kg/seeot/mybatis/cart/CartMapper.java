package com.kg.seeot.mybatis.cart;

import com.kg.seeot.cart.dto.CartDTO;

public interface CartMapper {
	public void addCart_p(int productNo);
	public void addCart_u(); //임시 유저데이터 삽입
	public CartDTO getCart(String memberId);
	
}
