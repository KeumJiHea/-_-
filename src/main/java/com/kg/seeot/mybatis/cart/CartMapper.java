package com.kg.seeot.mybatis.cart;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.kg.seeot.cart.dto.CartDTO;

public interface CartMapper {
	public void addCart_p(@Param("n") int productNo,@Param("s") String productSize, @Param("c") String productColor,@Param("o") String productSatck);
	public void addCart_m(@Param("n") int productNo,@Param("s") String productSize, @Param("c") String productColor);
	public ArrayList<CartDTO> getCart(String memberId);
	public int deleteCartOne(@Param("m") String memberId, @Param("p") int productNo);
	public int deleteChkCart(@Param("m") String memberId, @Param("c") int cartNum);
	public void alldel(String memberId);
}
