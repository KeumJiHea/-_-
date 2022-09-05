package com.kg.seeot.mybatis.cart;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kg.seeot.cart.dto.CartDTO;

public interface CartMapper {
	public void addCart_p(@Param("n") int productNo,@Param("o") int orderStack);
	public void addCart_u(); //임시 유저데이터 삽입
	public ArrayList<CartDTO> getCart(String memberId);
	public int deleteCartOne(@Param("m") String memberId, @Param("p") int productNo);
	public int deleteChkCart(@Param("m") String memberId, @Param("c") int cartNum);
}
