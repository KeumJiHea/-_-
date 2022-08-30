package com.kg.seeot.mybatis.cart;

public interface CartMapper {
	public void addCart_p(int productNo);
	public void addCart_u(); //임시 유저데이터 삽입
	
}
