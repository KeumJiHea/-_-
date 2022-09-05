package com.kg.seeot.mybatis.cart;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.kg.seeot.cart.dto.CartDTO;

public interface CartMapper {
	public void addCart_p(int productNo);
	public void addCart_u(); //임시 유저데이터 삽입
	public ArrayList<CartDTO> getCart(String memberId);
	public int deleteCartOne(@Param("m") String memberId, @Param("p") int productNo);
}
